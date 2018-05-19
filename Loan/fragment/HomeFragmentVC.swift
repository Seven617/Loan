//
//  HomeFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  HomeFragment

import UIKit
import Toaster
import LTAutoScrollView
import MJRefresh

class HomeFragmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    var topY: CGFloat = 20
    var navH: CGFloat = 64
    var dataDic:Dictionary<String, Any>! = nil
    var arrIcon:Array<Any>! = nil
    var arrMenu:Array<Any> = Array()
    var MainscrollView = UIScrollView()
    var tableView = UITableView()
    var adView: CCLoopCollectionView!
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 图片URL 或者 本地图片名称
    var images = ["WechatIMG1.jpeg"]
    public var pgCtrlNormalColor: UIColor! = UIColor.white
    public var pgCtrlSelectedColor: UIColor! = UIColor.gray
    public var pgCtrlShouldHidden: Bool! = false
    public var countRow:Int! = 2
    public var countCol:Int! = 5
    public var countItem:Int! = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SCREEN_HEIGHT == 812 {
            topY = 44
            navH = 88
        }
        Thread.sleep(forTimeInterval: 1) //延长1秒
        //导航栏
        self.title = "快便贷"
        view.backgroundColor = UIColor.white
        //定义标题颜色与字体大小字典
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white, kCTFontAttributeName : UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        getBanner()
        getTableView()
        getCollectionView()

        getMainScrollView()
        //下拉刷新相关设置
        header.lastUpdatedTimeLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeFragmentVC.headerRefresh))
        MainscrollView.mj_header = header
    }
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新.")
        sleep(2)
        //重现生成数据
//        refreshItemData()
        //结束刷新
        MainscrollView.mj_header.endRefreshing()
    }

    //获取getMainScrollView
    func getMainScrollView(){
        MainscrollView = UIScrollView()
        //设置代理
        MainscrollView.delegate = self
        MainscrollView.frame = self.view.bounds
        // 点击状态栏时，可以滚动回顶端
        MainscrollView.scrollsToTop = true
        //隐藏滚动条
        MainscrollView.showsVerticalScrollIndicator = false
        let red = UIView(frame: CGRect(x:0, y:adView.frame.maxY ,width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/2))
        red.backgroundColor = UIColor.Red
        MainscrollView.addSubview(autoScrollView)
        MainscrollView.addSubview(tableView)
        MainscrollView.addSubview(adView)
        MainscrollView.addSubview(red)
        //设置内容大小
        MainscrollView.contentSize = CGSize(width:self.MainscrollView.bounds.width, height:red.frame.maxY + (self.tabBarController?.tabBar.frame.size.height)! + navH)
        view.addSubview(MainscrollView)
    }
    //获取Banner滚动条
    private func getBanner(){
//        view.addSubview(autoScrollView)
        if(images.count<=1){
            autoScrollView.isDisableScrollGesture = true
        }else{
            autoScrollView.isDisableScrollGesture = false
        }
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    //获取滚动菜单
    private func getTableView(){
        tableView = UITableView(frame: CGRect(x:0, y:autoScrollView.frame.maxY ,width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/4 + 10), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        //隐藏滚动条
        tableView.showsVerticalScrollIndicator = false
//        view.addSubview(tableView)
        setData()
        regReuseView()
    }
    
    private func getCollectionView(){
        let tempAry = [#imageLiteral(resourceName: "WechatIMG1.jpeg")]
        //根据frame创建view
        adView = CCLoopCollectionView(frame: CGRect(x: 0, y: tableView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4))
        //给轮播图赋值内容（可以为UIImage或UIString）
        adView.contentAry = tempAry as [AnyObject]
        //是否开始自动循环
        adView.enableAutoScroll = true
        //循环间隔时间
        adView.timeInterval = 3.5
        //是否显示UIPageControl
        adView.showPageControl = true
        //UIPageControl当前颜色
        adView.currentPageControlColor = UIColor.white
        //UIPageControl其它颜色
        adView.pageControlTintColor = UIColor.gray
        //设置图片显示模式
        adView.imageShowMode = .redraw
        //添加到父视图
//        view.addSubview(adView)
        adView.getClickedIndex { (index) in
            print("clicked index = \(index+1)")
        }
    }
    
    //视图滚动中一直触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("x:\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
    }

    /*  设置为系统的pageControl样式利用dotType */
    private lazy var autoScrollView: LTAutoScrollView = {
        let autoScrollView = LTAutoScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/4))
        autoScrollView.glt_timeInterval = 3.5
        autoScrollView.images = images
        autoScrollView.imageHandle = {(imageView, imageName) in
            imageView.image = UIImage(named: imageName)
        }
        autoScrollView.didSelectItemHandle = {
            Toast(text: "点击了第 \($0 + 1) 张图").show()
        }

        let layout = LTDotLayout(dotColor: UIColor.lightGray, dotSelectColor: UIColor.white, dotType: .default)
        /*设置dot的间距*/
        layout.dotMargin = 8
        /* 如果需要改变dot的大小，设置dotWidth的宽度即可 */
        layout.dotWidth = 8
        /*如需和系统一致，dot放大效果需手动关闭 */
        layout.isScale = false
        autoScrollView.dotLayout = layout
        return autoScrollView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData() {
        let plistPath = Bundle.main.path(forResource: "menuData", ofType: "plist")
        let arrayAllMenu: Array<Any> = NSArray(contentsOfFile: plistPath!) as!  Array<Any>
        for index in (0..<countItem) {
            arrMenu.append(arrayAllMenu[index])
        }
        tableView.reloadData()
    }
    
    // 注册可复用视图
    func regReuseView() {
        tableView.register(CoolTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    // MARK: - 数据源
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CoolTableViewCell
        cell.pgCtrlShouldHidden = pgCtrlShouldHidden
        cell.pgCtrlNormalColor = pgCtrlNormalColor
        cell.pgCtrlSelectedColor = pgCtrlSelectedColor
        cell.countRow = countRow
        cell.countCol = countCol
        cell.arrMenu = arrMenu
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (UIScreen.main.bounds.size.width / CGFloat(countCol) + 8.0) * CGFloat(countRow) + 10.0 // 10.0 用于显示pageControl, 8.0 为单个菜单按钮高度与宽度的差 ,此处数字不需要修改
        }
        else {
            return 50.0
        }
        
    }
}
