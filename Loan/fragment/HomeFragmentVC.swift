//
//  HomeFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  HomeFragment

import UIKit
import LTAutoScrollView
import MJRefresh
import Kingfisher


class HomeFragmentVC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,SCCycleScrollViewDelegate,UIScrollViewDelegate ,UITableViewDelegate,UITableViewDataSource{
    //本周最新贷款的数量
    var weeknewList : [weeknewdata] = []
    //本周最火贷款数量
    var weekhotList : [weekhotdata] = []
    //BannerList
    var bannerList : [bannerList] = []
    //RadioList
    var radioList : [radiolist] = []
    //自定义导航栏
    var navView = UIView()
    //外层scrollView
    var MainscrollView = UIScrollView()
    //包含UI控件层
    var incloudView = UIView()
    //banner
    var BannerView : SCCycleScrollView!
    
    //本周上新（文字）
    var weekNew = UIView()
    //本周热门（文字）
    var weekHot = UIView()
    //极速贷款（文字）
    var speedLoan = UIView()
    //精选专题
    var featuredTopics = UIView()
    //三个按钮
    var BtnGroup = UIView()
    //本周上新
    var weekNewView:UICollectionView!
    var pageControl: UIPageControl!
    //滚动广播
    var radioView = ZJNoticeView()
    //本周热门
    var tableView:UITableView!
    //用户数量
    var amountofusers:UIView!
    //底线
    var BottomLab = UILabel()
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        Thread.sleep(forTimeInterval: 0.8) //延长1秒
        view.setNeedsLayout()
        view.layoutIfNeeded()
        initView()
        //下拉刷新相关设置
        header.lastUpdatedTimeLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeFragmentVC.headerRefresh))
        MainscrollView.mj_header = header
        initData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let maxh: CGFloat = navH+BottomLab.frame.maxY
        if #available(iOS 11.0, *) {
            MainscrollView.contentSize = CGSize(width:SCREEN_WIDTH, height:maxh)
        } else {
            MainscrollView.contentSize = CGSize(width:SCREEN_WIDTH, height:
                maxh+(self.tabBarController?.tabBar.frame.size.height)!)
        }
    }
    
    func initView(){
        intiNavigationControlle()
        initincloudView()
        initBanner()
        initBtnView()
        initLine()
        initweekNewLab()
        initweekNewView()
        initpageControl()
        initRadioView()
        initweekHotLab()
        initweekHotView()
        initAmountofusers()
        initBottomLine()
        initMainScrollView()
    }
    
    func initData(){
        getBanner()
        getWeekNew()
        getRadio()
        getWeekHot()
    }
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新.")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
            {
                self.getBanner()
                self.getWeekNew()
                self.getRadio()
                self.getWeekHot()
        })
    }
    
    func intiNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.Main
        view.addSubview(navView)
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "快便贷"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    @objc func getBanner(){
        bannerdata.request { (banner) in
            if let banner = banner{
                if let classifyList = banner.bannerList{
                    OperationQueue.main.addOperation {
                        self.bannerList = classifyList
                        var bottomImages:[String]=[]
                        for img in self.bannerList{
                            bottomImages.append(img.image)
                        }
                        self.BannerView.imageArray=bottomImages as [AnyObject]
                    }
                }
            }else {
                print("网络错误")
            }
        }
    }
    
    @objc func getRadio(){
        radiodata.request { (radio) in
            if let radio = radio{
                if let radiolist = radio.list{
                    self.radioList=radiolist
                    var radiotxt:[String]=[]
                    for radio in self.radioList{
                        radiotxt.append(radio.descriptionBoard)
                    }
                    self.radioView.scrollLabel.setTexts(radiotxt)
                }
            }else {
                print("网络错误")
            }
        }
    }
    
    
    @objc func getWeekNew(){
        weeknewdata.request { (weeknew) in
            if let  weeknew = weeknew{
                OperationQueue.main.addOperation {
                    self.weeknewList = weeknew
                    self.pageControl.numberOfPages = self.weeknewList.count/2
                    self.weekNewView.reloadData()
                }
            }else {
                print("网络错误")
            }
        }
    }
    
    @objc func getWeekHot(){
        weekhotdata.request { (weekhot) in
            if let weekhot = weekhot{
                OperationQueue.main.addOperation {
                    self.weekhotList = weekhot
                    self.tableView.reloadData()
                    //结束刷新
                    self.MainscrollView.mj_header.endRefreshing()
                }
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
                    {
                        SYIToast.alert(withTitleBottom: "网络错误！")
                        //结束刷新
                        self.MainscrollView.mj_header.endRefreshing()
                })
            }
        }
    }
    
    func initincloudView(){
        incloudView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*3))
    }
    
    //获取getMainScrollView
    func initMainScrollView(){
        MainscrollView = UIScrollView(frame: CGRect(x:0, y:navH, width:SCREEN_WIDTH, height:SCREEN_HEIGHT))
        //设置代理
        MainscrollView.delegate = self
        // 点击状态栏时，可以滚动回顶端
        MainscrollView.scrollsToTop = true
        //隐藏滚动条
        MainscrollView.showsVerticalScrollIndicator = false
        view.addSubview(MainscrollView)
        MainscrollView.addSubview(incloudView)
        //设置内容大小
        
        
    }
    
    private func initweekNewLab(){
        weekNew = UIView(frame: CGRect(x:0, y:featuredTopics.frame.maxY+10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 40)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height: 15)))
        icon.image=UIImage(named: "weeknew_icon")
        weekNew.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:kHeightRelIPhone6(height: 10) ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 15)))
        weekLab.text = "今日精选"
        weekLab.textColor = UIColor.Font1st
        weekLab.font = UIFont.systemFont(ofSize: 14)
        weekNew.addSubview(weekLab)
        weekNew.backgroundColor = UIColor.white
        incloudView.addSubview(weekNew)
    }
    
    func initBtnView(){
        BtnGroup=UIView(frame: CGRect(x:0, y:BannerView.frame.bottom ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height:120)))
        BtnGroup.backgroundColor=UIColor.white
        incloudView.addSubview(BtnGroup)
        
        let img1 = UIImageView(frame: CGRect(x:SCREEN_WIDTH*(1/6)-kWithRelIPhone6(width: 30), y:kHeightRelIPhone6(height: 20) ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:60)))
        img1.image = UIImage(named:"convenient")
        let convenient = UILabel(frame: CGRect(x:SCREEN_WIDTH*(1/6)-kWithRelIPhone6(width: 30), y:img1.frame.bottom+kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:15)))
        convenient.text="借款便利"
        convenient.textAlignment = .center
        convenient.textColor=UIColor.black
        convenient.font=UIFont.systemFont(ofSize: 13)
        BtnGroup.addSubview(img1)
        BtnGroup.addSubview(convenient)
        
        let img2 = UIImageView(frame: CGRect(x:SCREEN_WIDTH*(3/6)-kWithRelIPhone6(width: 30), y:kHeightRelIPhone6(height: 20) ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:60)))
        img2.image = UIImage(named:"highpassrate")
        let highpassrate = UILabel(frame: CGRect(x:SCREEN_WIDTH*(3/6)-kWithRelIPhone6(width: 30), y:img2.frame.bottom+kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:15)))
        highpassrate.text="高通过率"
        highpassrate.textAlignment = .center
        highpassrate.textColor=UIColor.black
        highpassrate.font=UIFont.systemFont(ofSize: 13)
        BtnGroup.addSubview(img2)
        BtnGroup.addSubview(highpassrate)
        
        let img3 = UIImageView(frame: CGRect(x:SCREEN_WIDTH*(5/6)-kWithRelIPhone6(width: 30), y:kHeightRelIPhone6(height: 20) ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:60)))
        img3.image = UIImage(named:"sesameloan")
        let sesameloan = UILabel(frame: CGRect(x:SCREEN_WIDTH*(5/6)-kWithRelIPhone6(width: 30), y:img3.frame.bottom+kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:15)))
        sesameloan.text="芝麻分贷"
        sesameloan.textAlignment = .center
        sesameloan.textColor=UIColor.black
        sesameloan.font=UIFont.systemFont(ofSize: 13)
        BtnGroup.addSubview(img3)
        BtnGroup.addSubview(sesameloan)
    }
    
    func initLine(){
        featuredTopics = UIView(frame: CGRect(x:0, y:BtnGroup.frame.maxY+10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 180)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height: 15)))
        icon.image=UIImage(named: "best_icon")
        featuredTopics.addSubview(icon)
        
        let bestLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 15)))
        bestLab.text = "精选专题"
        bestLab.textColor = UIColor.Font1st
        bestLab.font = UIFont.systemFont(ofSize: 14)
        featuredTopics.backgroundColor = UIColor.white
        featuredTopics.addSubview(bestLab)
        incloudView.addSubview(featuredTopics)
        
        let weeknewbtn = UIButton(frame:CGRect(x: SCREEN_WIDTH*0.2/3, y: kHeightRelIPhone6(height:bestLab.frame.bottom+20) , width: SCREEN_WIDTH*0.4, height: kHeightRelIPhone6(height:110)))
        weeknewbtn.setImage(UIImage(named: "weeknew"), for: .normal)
        
        weeknewbtn.addTarget(self,action:#selector(touchDownWithButton),for:.touchUpInside)
        weeknewbtn.tag=1
        featuredTopics.addSubview(weeknewbtn)
        
        let weekbestbtn = UIButton(frame:CGRect(x:weeknewbtn.frame.right+SCREEN_WIDTH*0.2/3, y: kHeightRelIPhone6(height:bestLab.frame.bottom+20) , width: SCREEN_WIDTH*0.4, height: kHeightRelIPhone6(height:45)))
        weekbestbtn.setImage(UIImage(named: "weekbest"), for: .normal)
        weekbestbtn.addTarget(self,action:#selector(touchDownWithButton),for:.touchUpInside)
        weekbestbtn.tag=2
        featuredTopics.addSubview(weekbestbtn)
        
        let weekhotbtn = UIButton(frame:CGRect(x:weeknewbtn.frame.right+SCREEN_WIDTH*0.2/3, y: weekbestbtn.frame.bottom+kHeightRelIPhone6(height:20) , width: SCREEN_WIDTH*0.4, height: kHeightRelIPhone6(height:45)))
        weekhotbtn.setImage(UIImage(named: "weekhot"), for: .normal)
        weekhotbtn.addTarget(self,action:#selector(touchDownWithButton),for:.touchUpInside)
        weekhotbtn.tag=3
        featuredTopics.addSubview(weekhotbtn)
    }
    @objc func touchDownWithButton(button:UIButton) {
        if (button.tag==1) {
            navigationController?.pushViewController(WeekNewViewController(), animated: true)
        }
        if (button.tag==2) {
            navigationController?.pushViewController(WeekBestViewController(), animated: true)
        }
        if (button.tag==3) {
            navigationController?.pushViewController(WeekHotViewController(), animated: true)
        }
    }
    private func initweekHotLab(){
        weekHot = UIView(frame: CGRect(x:0, y:radioView.frame.maxY+10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 40)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height: 15)))
        icon.image=UIImage(named:"weekhot_icon")
        weekHot.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 15)))
        weekLab.text = "热门产品"
        weekLab.textColor = UIColor.Font1st
        weekLab.font = UIFont.systemFont(ofSize: 14)
        weekHot.addSubview(weekLab)
        weekHot.backgroundColor = UIColor.white
        incloudView.addSubview(weekHot)
        
        let seemoreBtn = UIButton(frame: CGRect(x:SCREEN_WIDTH-80, y:10 ,width: kWithRelIPhone6(width: 80), height:kHeightRelIPhone6(height: 15)))
        seemoreBtn.setTitle("查看更多", for:.normal)
        seemoreBtn.addTarget(self,action:#selector(touchDownWithButton),for:.touchUpInside)
        seemoreBtn.tag=3
        seemoreBtn.setTitleColor(UIColor.Font3rd, for: .normal) //普通状态下文字的颜色
        seemoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        weekHot.addSubview(seemoreBtn)
    }
 
    func initweekNewView(){
        weekNewView=UICollectionView(frame: CGRect(x:0, y:weekNew.frame.maxY ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 80)),collectionViewLayout: collectionLayout())
        weekNewView.backgroundColor = UIColor.white
        weekNewView.isPagingEnabled = true
        weekNewView.showsHorizontalScrollIndicator = true
        weekNewView.delegate = self
        weekNewView.dataSource = self
        weekNewView.showsVerticalScrollIndicator = false
        weekNewView.showsHorizontalScrollIndicator = false
        incloudView.addSubview(weekNewView)
        weekNewView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func initpageControl(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: weekNewView.frame.maxY - kHeightRelIPhone6(height: 12), width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 10)))
        pageControl.backgroundColor=UIColor.white
//        pageControl.numberOfPages = weeknewList.count
        pageControl.currentPageIndicatorTintColor = UIColor.Main
        // 未选中圆点颜色
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        incloudView.addSubview(pageControl)
    }
    
    func initRadioView(){
        radioView.frame = CGRect(x: 0, y: pageControl.frame.maxY+kHeightRelIPhone6(height: 10), width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 30))
        radioView.backgroundColor = UIColor.white;
        radioView.scrollLabel.setTexts([" "])
        radioView.scrollLabel.resume()
        incloudView.addSubview(radioView)
    }
    
    func initBanner() {
        let placeholderImage = UIImage(named: "loading")
        BannerView = SCCycleScrollView.cycleScrollView(frame: CGRect(x: 0, y:0, width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 150)),delegate: self,placeholderImage: placeholderImage)
        BannerView.delegate = self
        BannerView.timeInterval = 3.5
        BannerView.imageArray = nil
        BannerView.pageControlBottomMargin = 5
        BannerView.pageControlRightMargin = (UIScreen.main.bounds.width - BannerView.pageControlSize.width) / 2.0
        incloudView.addSubview(BannerView)
    }
    
    func cycleScrollView(_ cycleScrollView: SCCycleScrollView, didSelectItemAt index: Int) {
        if BannerView.imageArray == nil{
            
        }else{
            let web = WebViewController()
            let detil = DetilViewController()
            let classify = bannerList[index]
            if classify.targetType==2{
//                detil.navtitle=classify.title
                detil.productId=Int(classify.targetContent)
                self.navigationController?.pushViewController(detil, animated: true)
            }else if classify.targetType==3{
                web.webtitle=classify.title
                web.url = classify.targetContent
                self.navigationController?.pushViewController(web, animated: true)
            }
        }
    }
    // set up layout
    private func collectionLayout() -> UICollectionViewLayout {
        let layout = CustomLayout()
        layout.row=1// 每页有多少行
        layout.column=2// 每页有多少列
        layout.padding=0// 内部每个cell的间距
        layout.edgeMargin=kWithRelIPhone6(width: 10)// 边界的间距
        return layout;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeknewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let weeknewlist = weeknewList[indexPath.row]
        let url = URL(string: weeknewlist.logo)
        cell.img.kf.indicatorType = .activity
        cell.img.kf.setImage(with: url )
        cell.name.text = weeknewlist.name
        cell.quota.text = ("\(forTrailingZero(temp: (weeknewlist.minAmount as! Float)/1000)) ~ \(forTrailingZero(temp: (weeknewlist.maxAmount as! Float)/1000))万元")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let witdh = collectionView.frame.width - (collectionView.contentInset.left*2)
        let index = collectionView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pageControl.currentPage = Int(roundedIndex)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weeknewlist = weeknewList[indexPath.row]
        let detil = DetilViewController()
        detil.productId=weeknewlist.id
//        detil.navtitle=weeknewlist.name
        self.navigationController?.pushViewController(detil, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initweekHotView(){
        tableView = UITableView(frame: CGRect(x: 0, y: weekHot.frame.maxY, width: view.bounds.width, height: kHeightRelIPhone6(height: 350)), style: UITableViewStyle.plain)
        tableView.register(LoanCell.self,forCellReuseIdentifier: "SampleCell")
        tableView.dataSource = self
        tableView.delegate = self
        //隐藏滚动条
        tableView.showsVerticalScrollIndicator = false
        //禁止拖动
        tableView.bounces=false
        tableView.tableFooterView = UIView()
        tableView.ly_emptyView = MyDIYEmpty.diyNoData()
        incloudView.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekhotList.prefix(5).count
    }    
    
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kHeightRelIPhone6(height:70)
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath) as! LoanCell
        let news = weekhotList.prefix(5)[indexPath.row]
        let url = URL(string: news.logo)
        cell.img.kf.indicatorType = .activity
        cell.img.kf.setImage(with: url )
        cell.name.text = news.name
        cell.quota.text = ("\(news.minAmount.description!) - \(news.maxAmount.description!)")
        cell.rates.text = ("\(news.minRate.description!) %")
        let a:Int = news.rateUnit as! Int
        var time:String?=nil
        switch(a)
        {
        case 1 :
            //要執行動作
            time="年"
            break
        case 2 :
            //要執行動作
            time="月"
            break
        case 3 :
            //要執行動作
            time="日"
            break
        case 4 :
            //要執行動作
            time="笔"
            break
        default :
            //要執行動作
            break
        }
        cell.rateslab.text = time!+"费率"
        cell.descriptionlab.text = news.comment
        return cell
    }
    
    
    //cell点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = weekhotList[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: false)
        let detil = DetilViewController()
        detil.productId=news.id
//        detil.navtitle=news.name
        self.navigationController?.pushViewController(detil, animated: true)
    }
    
    func initAmountofusers(){
        amountofusers = UIView(frame: CGRect(x:0, y:tableView.frame.maxY+kHeightRelIPhone6(height: 10),width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 100)))
        amountofusers.backgroundColor=UIColor.white
        incloudView.addSubview(amountofusers)
        
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height: 15)))
        icon.image=UIImage(named:"save_icon")
        amountofusers.addSubview(icon)
        
        let safeLab = UILabel(frame: CGRect(x:icon.frame.right+10, y:kHeightRelIPhone6(height: 10)  ,width: kWithRelIPhone6(width: 80), height:kHeightRelIPhone6(height: 15)))
        safeLab.text = "安全透明"
        safeLab.textColor = UIColor.Font1st
        safeLab.font = UIFont.systemFont(ofSize: 14)
        amountofusers.addSubview(safeLab)

        let useheart = UILabel(frame: CGRect(x:safeLab.frame.right, y:kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 180), height:kHeightRelIPhone6(height: 15)))
        useheart.text="随心 用心 放心"
        useheart.textAlignment = .left
        useheart.textColor=UIColor.Font3rd
        useheart.font = UIFont.systemFont(ofSize: 12)
        amountofusers.addSubview(useheart)
        
        let user = UILabel(frame: CGRect(x:0,y:useheart.frame.bottom+kHeightRelIPhone6(height: 15) ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 20)))
        user.text="2,346,578位"
        user.textAlignment = .center
        user.textColor=UIColor.orange
        user.font = UIFont.systemFont(ofSize: 18)
        amountofusers.addSubview(user)
        
        let leb = UILabel(frame: CGRect(x:0,y:user.frame.bottom+kHeightRelIPhone6(height: 15) ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 10)))
        leb.text="平台用户数"
        leb.textAlignment = .center
        leb.textColor=UIColor.Font3rd
        leb.font = UIFont.systemFont(ofSize: 12)
        amountofusers.addSubview(leb)
    }
    
    func initBottomLine(){
        BottomLab = UILabel(frame: CGRect(x:0, y:amountofusers.frame.maxY ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 40)))
        BottomLab.text = "没有更多内容了"
        BottomLab.textAlignment=NSTextAlignment.center
        BottomLab.textColor = UIColor.Font3rd
        BottomLab.font = UIFont.systemFont(ofSize: 13)
        incloudView.addSubview(BottomLab)
    }
}
