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


class HomeFragmentVC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,SCCycleScrollViewDelegate,UIScrollViewDelegate {
    //本周最新贷款的数量
    var weeknewList : [weeknewdata] = []
    
    //自定义导航栏
    var navView = UIView()
    
    //外层scrollView
    var MainscrollView = UIScrollView()
    
    //包含UI控件层
    var incloudView = UIView()
    
    //头部banner
    var topbannerId:[Int]=[]
    var toptitle:[String]=[]
    var topImages:[String]=[]
    var topbannertype:[Int]=[]
    var topbannerLinke:[String]=[]
    var topBanner : SCCycleScrollView!
    
    //底部banner
    var bottombannerId:[Int]=[]
    var bottomtitle:[String]=[]
    var bottomImages:[String]=[]
    var bottombannertype:[Int]=[]
    var bottombannerLinke:[String]=[]
    var bottomBanner : SCCycleScrollView!
    
    //本周上新（文字）
    var weekNew = UIView()
    //本周热门（文字）
    var weekHot = UIView()
    //极速贷款（文字）
    var speedLoan = UIView()
    //分割线
    var Introduce = UIView()
    
    //本周上新
    var weekNewView: UICollectionView!
    
    //滚动广播
    var radiotxt:[String]=[]
    var radioView = ZJNoticeView()
    
    //本周热门
    var weekHotID:[Int]=[]
    var weekHotTitle:[String]=[]
    var weekHotImg:[String]=[]
    var weekHotLinke:[String]=[]
    var weekHotView : IWBusinessCategorySV!
    
    //本周热门
    var speedLoanID:[Int]=[]
    var speedLoanTitle:[String]=[]
    var speedLoanImg:[String]=[]
    var speedLoanLinke:[String]=[]
    var speedLoanView : IWBusinessCategorySV!
    //底线
    var BottomLab = UILabel()
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        //        Thread.sleep(forTimeInterval: 1) //延长1秒
        view.setNeedsLayout()
        view.layoutIfNeeded()
        initView()
        initData()
        //下拉刷新相关设置
        header.lastUpdatedTimeLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeFragmentVC.headerRefresh))
        MainscrollView.mj_header = header
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
        initTopBanner()
        getweekNewLab()
        getweekNewView()
        getLine()
        getRadioView()
        getweekHotLab()
        getweekHotView()
        initBottomBanner()
//        getspeedLoanLab()
//        getspeedLoanView()
        getBottomLine()
        getMainScrollView()
    }
    func initData(){
        getBanner()
        getWeekNew()
        getRadio()
        getWeekHot()
//        getSpeed()
    }
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新.")
        dataclear()
        initData()
        sleep(2)
        //结束刷新
        MainscrollView.mj_header.endRefreshing()
    }
    func dataclear(){
        toptitle=[]
        topImages=[]
        topbannerId=[]
        topbannertype=[]
        topbannerLinke=[]
        
        bottomtitle=[]
        bottomImages=[]
        bottombannerId=[]
        bottombannertype=[]
        bottombannerLinke=[]
        
        
        radiotxt=[]
        
        weekHotID=[]
        weekHotTitle=[]
        weekHotImg=[]
        weekHotLinke=[]
        
        speedLoanID=[]
        speedLoanTitle=[]
        speedLoanImg=[]
        speedLoanLinke=[]
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
    
    func getBanner(){
        bannerdata.request { (banner) in
            for topbanner in (banner?.bannerList)!{
                self.toptitle.append(topbanner.title)
                self.topImages.append(topbanner.image)
                self.topbannerId.append(topbanner.id)
                self.topbannertype.append(topbanner.targetType)
                self.topbannerLinke.append(topbanner.targetContent)
            }
//            self.initTopBanner()
            self.topBanner.imageArray = self.topImages as [AnyObject]
            for bottombanner in (banner?.classifyList)!{
                self.bottomtitle.append(bottombanner.title)
                self.bottomImages.append(bottombanner.image)
                self.bottombannerId.append(bottombanner.id)
                self.bottombannertype.append(bottombanner.targetType)
                self.bottombannerLinke.append(bottombanner.targetContent)
            }
            self.initBottomBanner()
        }
    }
    
    @objc func getWeekNew(){
        weeknewdata.request { (weeknew) in
            if let  weeknew = weeknew{
                OperationQueue.main.addOperation {
                    self.weeknewList = weeknew
                    self.weekNewView.reloadData()
                }
            }else {
                print("网络错误")
            }
        }
    }
    func getSpeed(){
       weekspeeddata.request { (weekspeed) in
            for data in weekspeed!{
                self.speedLoanID.append(data.id)
                self.speedLoanTitle.append(data.name)
                self.speedLoanImg.append(data.logo)
                self.speedLoanLinke.append(data.link)
            }
            self.getspeedLoanView()
        }
    }
    func getRadio(){
        radiodata.request { (radio) in
            for msg in (radio?.list)!{
                self.radiotxt.append(msg.descriptionBoard)
            }
            self.radioView.scrollLabel.setTexts(self.radiotxt)
        }
    }
    
    func getWeekHot(){
        weekhotdata.request { (weekhot) in
            for data in weekhot!{
                self.weekHotID.append(data.id)
                self.weekHotTitle.append(data.name)
                self.weekHotImg.append(data.logo)
                self.weekHotLinke.append(data.link)
            }
            self.getweekHotView()
        }
    }
    
    func initincloudView(){
        incloudView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*3))
    }
    
    //获取getMainScrollView
    func getMainScrollView(){
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
    //获取Banner滚动条
    /*  设置为系统的pageControl样式利用dotType */
    func initTopBanner(){
        let placeholderImage = UIImage(named: " ")
        topBanner = SCCycleScrollView.cycleScrollView(frame: CGRect(x: 0, y:0, width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 150)),delegate: self,placeholderImage: placeholderImage)
        topBanner.delegate = self
        topBanner.timeInterval = 3.5
        topBanner.imageArray = topImages as [AnyObject]
        topBanner.pageControlBottomMargin = 5
        topBanner.pageControlRightMargin = (UIScreen.main.bounds.width - topBanner.pageControlSize.width) / 2.0
        incloudView.addSubview(topBanner)
    }
    
    private func getweekNewLab(){
        weekNew = UIView(frame: CGRect(x:0, y:topBanner.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 40)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        icon.backgroundColor = UIColor.Main
        weekNew.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        weekLab.text = "本周上新"
        weekLab.textColor = UIColor.Font2nd
        weekLab.font = UIFont.boldSystemFont(ofSize: 13)
        weekNew.addSubview(weekLab)
        weekNew.backgroundColor = UIColor.white
        incloudView.addSubview(weekNew)
    }
    func getLine(){
        Introduce=UIView(frame: CGRect(x:0, y:weekNewView.frame.bottom ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height:40)))
        Introduce.backgroundColor=UIColor.white
        incloudView.addSubview(Introduce)
        
        let line = UIView(frame:CGRect(x: 30, y: 5 , width: kWithRelIPhone6(width:SCREEN_WIDTH - 100), height: kHeightRelIPhone6(height:1)))
        line.backgroundColor=UIColor.Gray
        Introduce.addSubview(line)
        
        let img1 = UIImageView(frame: CGRect(x:40, y:line.frame.bottom+10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height:15)))
        img1.image = UIImage(named:"gou")
        let convenient = UILabel(frame: CGRect(x:img1.frame.right+5, y:line.frame.bottom+10 ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:15)))
        convenient.text="借款便利"
        convenient.textAlignment = .center
        convenient.textColor=UIColor.MainPress
        convenient.font=UIFont.italicSystemFont(ofSize: 12)
        Introduce.addSubview(img1)
        Introduce.addSubview(convenient)
        
        let img2 = UIImageView(frame: CGRect(x:convenient.frame.right + 40, y:line.frame.bottom+10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height:15)))
        img2.image = UIImage(named:"gou")
        let highpassrate = UILabel(frame: CGRect(x:img2.frame.right+5, y:line.frame.bottom+10 ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:15)))
        highpassrate.text="高通过率"
        highpassrate.textAlignment = .center
        highpassrate.textColor=UIColor.MainPress
        highpassrate.font=UIFont.italicSystemFont(ofSize: 12)
        Introduce.addSubview(img2)
        Introduce.addSubview(highpassrate)
        
        let img3 = UIImageView(frame: CGRect(x:highpassrate.frame.right + 40, y:line.frame.bottom+10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height:15)))
        img3.image = UIImage(named:"gou")
        let sesameloan = UILabel(frame: CGRect(x:img3.frame.right+5, y:line.frame.bottom+10 ,width: kWithRelIPhone6(width: 60), height:kHeightRelIPhone6(height:15)))
        sesameloan.text="芝麻分贷"
        sesameloan.textAlignment = .center
        sesameloan.textColor=UIColor.MainPress
        sesameloan.font=UIFont.italicSystemFont(ofSize: 12)
        Introduce.addSubview(img3)
        Introduce.addSubview(sesameloan)
        
        
    }
    private func getweekHotLab(){
        weekHot = UIView(frame: CGRect(x:0, y:radioView.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 40)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        icon.backgroundColor = UIColor.Main
        weekHot.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        weekLab.text = "本周热门"
        weekLab.textColor = UIColor.Font2nd
        weekLab.font = UIFont.boldSystemFont(ofSize: 13)
        weekHot.addSubview(weekLab)
        weekHot.backgroundColor = UIColor.white
        incloudView.addSubview(weekHot)
    }
    
    private func getspeedLoanLab(){
        speedLoan = UIView(frame: CGRect(x:0, y:bottomBanner.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 40)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        icon.backgroundColor = UIColor.Main
        speedLoan.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        weekLab.text = "极速贷款"
        weekLab.textColor = UIColor.Font2nd
        weekLab.font = UIFont.boldSystemFont(ofSize: 13)
        speedLoan.addSubview(weekLab)
        speedLoan.backgroundColor = UIColor.white
        incloudView.addSubview(speedLoan)
    }
    
    
    func getweekNewView(){
        weekNewView=UICollectionView(frame: CGRect(x:0, y:weekNew.frame.maxY ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 100)),collectionViewLayout: collectionLayout())
        weekNewView.backgroundColor = UIColor.white
        weekNewView.isPagingEnabled = true
        weekNewView.showsHorizontalScrollIndicator = true
        weekNewView.delegate = self
        weekNewView.dataSource = self
        incloudView.addSubview(weekNewView)
        weekNewView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func getspeedLoanView(){
        speedLoanView = IWBusinessCategorySV(frame: CGRect(x:0, y:speedLoan.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 190)),imageArray: speedLoanImg, titleArray: speedLoanTitle, target: self, action: #selector(HomeFragmentVC.clickgetspeedLoan(_:)))
        incloudView.addSubview(speedLoanView)
    }
    
    @objc func clickgetspeedLoan(_ sender: UIButton?) {
        let tag = (sender?.tag ?? 0) - Int(KCategoryTag)
        //        SYIToast.alert(withTitleBottom: weekNewTitle[tag])
        let detil = DetilViewController()
        detil.productId=speedLoanID[tag]
        detil.navtitle=speedLoanTitle[tag]
        self.navigationController?.pushViewController(detil, animated: true)
    }
    
    func getRadioView(){
        radioView.frame = CGRect(x: 0, y: Introduce.frame.maxY+5, width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 30))
        radioView.backgroundColor = UIColor.white;
        radioView.scrollLabel.setTexts(radiotxt)
        radioView.scrollLabel.resume()
        incloudView.addSubview(radioView)
    }
    
    func initBottomBanner() {
        let placeholderImage = UIImage(named: " ")
        bottomBanner = SCCycleScrollView.cycleScrollView(frame: CGRect(x: 0, y:weekHotView.frame.maxY, width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 180)),delegate: self,placeholderImage: placeholderImage)
        bottomBanner.delegate = self
        bottomBanner.timeInterval = 3.5
        bottomBanner.imageArray = bottomImages as [AnyObject]
        bottomBanner.pageControlBottomMargin = 5
        bottomBanner.pageControlRightMargin = (UIScreen.main.bounds.width - bottomBanner.pageControlSize.width) / 2.0
        incloudView.addSubview(bottomBanner)
    }
    
    func cycleScrollView(_ cycleScrollView: SCCycleScrollView, didSelectItemAt index: Int) {
        let web = WebViewController()
        let detil = DetilViewController()
        if cycleScrollView==topBanner{
            if topbannertype[index]==2{
                detil.navtitle=toptitle[index]
                detil.productId=Int(topbannerLinke[index])!
                self.navigationController?.pushViewController(detil, animated: true)
            }else if topbannertype[index]==3{
                web.url=topbannerLinke[index]
                web.webtitle=toptitle[index]
                self.navigationController?.pushViewController(web, animated: true)
            }
        }else{
            if bottombannertype[index]==2{
                detil.navtitle=bottomtitle[index]
                detil.productId=Int(bottombannerLinke[index])
                self.navigationController?.pushViewController(detil, animated: true)
            }else if bottombannertype[index]==3{
                web.webtitle=bottomtitle[index]
                web.url = bottombannerLinke[index]
                self.navigationController?.pushViewController(web, animated: true)
            }
        }
        
    }
    // set up layout
    private func collectionLayout() -> UICollectionViewLayout {
        let layout = CustomLayout()
        layout.row=1
        layout.column=4
        layout.padding=10
        layout.edgeMargin=10
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weeknewlist = weeknewList[indexPath.row]
        let detil = DetilViewController()
        detil.productId=weeknewlist.id
        detil.navtitle=weeknewlist.name
        self.navigationController?.pushViewController(detil, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getweekHotView(){
        weekHotView = IWBusinessCategorySV(frame: CGRect(x: 0, y: weekHot.frame.maxY, width: view.bounds.width, height: 200), imageArray: weekHotImg, titleArray: weekHotTitle, target: self, action: #selector(HomeFragmentVC.clickWeekHotBtn(_:)))
        incloudView.addSubview(weekHotView)
    }
    @objc func clickWeekHotBtn(_ sender: UIButton?) {
        let tag = (sender?.tag ?? 0) - Int(KCategoryTag)
        //        SYIToast.alert(withTitleBottom: weekHotTitle[tag])
        let detil = DetilViewController()
        detil.productId=weekHotID[tag]
        detil.navtitle=weekHotTitle[tag]
        self.navigationController?.pushViewController(detil, animated: true)
    }
    func getBottomLine(){
        BottomLab = UILabel(frame: CGRect(x:0, y:bottomBanner.frame.maxY ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 40)))
        BottomLab.text = "———— 到底了哦 ————"
        BottomLab.textAlignment=NSTextAlignment.center
        BottomLab.textColor = UIColor.Line
        BottomLab.font = UIFont.boldSystemFont(ofSize: 13)
        incloudView.addSubview(BottomLab)
    }
}
