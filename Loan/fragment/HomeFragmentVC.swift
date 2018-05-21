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
    var arrIcon:Array<Any>! = nil
    var arrMenu:Array<Any> = Array()
    var MainscrollView = UIScrollView()
    var weekNew = UIView()
    var tableView = UITableView()
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 图片URL 或者 本地图片名称
    var topImages = ["WechatIMG1.jpeg"]
    var bottomImages = ["WechatIMG1.jpeg"]
    public var pgCtrlNormalColor: UIColor! = UIColor.white
    public var pgCtrlSelectedColor: UIColor! = UIColor.gray
    public var pgCtrlShouldHidden: Bool! = false
    public var countRow:Int! = 2
    public var countCol:Int! = 5
    public var countItem:Int! = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
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
        getTopBanner()
        getweekNew()
        getTableView()
        getBottomBanner()
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
        
        
        let red = UIView(frame: CGRect(x:0, y:bottomBanner.frame.maxY ,width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/2))
        red.backgroundColor = UIColor.Red
        
        let BottomLab = UILabel(frame: CGRect(x:0, y:red.frame.maxY ,width: UIScreen.main.bounds.width, height:40))
        BottomLab.text = "———— 我是有底线的 ————"
        BottomLab.textAlignment=NSTextAlignment.center
        BottomLab.textColor = UIColor.Line
        BottomLab.font = UIFont.boldSystemFont(ofSize: 13)
        
        MainscrollView.addSubview(topBanner)
        MainscrollView.addSubview(weekNew)
        MainscrollView.addSubview(tableView)
        MainscrollView.addSubview(bottomBanner)
        MainscrollView.addSubview(red)
        MainscrollView.addSubview(BottomLab)
        //设置内容大小
        MainscrollView.contentSize = CGSize(width:self.MainscrollView.bounds.width, height: BottomLab.frame.maxY + navH)
        view.addSubview(MainscrollView)
    }
    
    private func getweekNew(){
        weekNew = UIView(frame: CGRect(x:0, y:topBanner.frame.maxY ,width: UIScreen.main.bounds.width, height:40))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: 5, height:20))
        icon.backgroundColor = UIColor.Main
        weekNew.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:20))
        weekLab.text = "本周上新"
        weekLab.textColor = UIColor.Font2nd
        weekLab.font = UIFont.boldSystemFont(ofSize: 13)
        weekNew.addSubview(weekLab)
    }
    
    //获取Banner滚动条
    private func getTopBanner(){
        if(topImages.count<=1){
            topBanner.isDisableScrollGesture = true
        }else{
            topBanner.isDisableScrollGesture = false
        }
    }
    
    private func getBottomBanner(){
        if(bottomImages.count<=1){
            bottomBanner.isDisableScrollGesture = true
        }else{
            bottomBanner.isDisableScrollGesture = false
        }
    }
    
    //获取滚动菜单
    private func getTableView(){
        tableView = UITableView(frame: CGRect(x:0, y:weekNew.frame.maxY ,width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/4 + 15), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        //隐藏滚动条
        tableView.showsVerticalScrollIndicator = false
        setData()
        regReuseView()
    }
    
    
    //视图滚动中一直触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("x:\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
        // 禁止下拉
        // if scrollView.contentOffset.y <= 0 {
        // scrollView.contentOffset.y = 0
        //
        // 禁止上拉
        // if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height {
        // scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.size.height
        // }
    }
    
    /*  设置为系统的pageControl样式利用dotType */
    private lazy var topBanner: LTAutoScrollView = {
        let topBanner = LTAutoScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/4))
        topBanner.glt_timeInterval = 3.5
        topBanner.images = topImages
        topBanner.imageHandle = {(imageView, imageName) in
            imageView.image = UIImage(named: imageName)
        }
        topBanner.didSelectItemHandle = {
            Toast(text: "点击了第 \($0 + 1) 张图").show()
        }

        let layout = LTDotLayout(dotColor: UIColor.lightGray, dotSelectColor: UIColor.white, dotType: .default)
        /*设置dot的间距*/
        layout.dotMargin = 8
        /* 如果需要改变dot的大小，设置dotWidth的宽度即可 */
        layout.dotWidth = 8
        /*如需和系统一致，dot放大效果需手动关闭 */
        layout.isScale = false
        topBanner.dotLayout = layout
        return topBanner
    }()
    
    private lazy var bottomBanner: LTAutoScrollView = {
        let bottomBanner = LTAutoScrollView(frame: CGRect(x: 0, y: tableView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4))
        bottomBanner.glt_timeInterval = 3.5
        bottomBanner.images = bottomImages
        bottomBanner.imageHandle = {(imageView, imageName) in
            imageView.image = UIImage(named: imageName)
        }
        bottomBanner.didSelectItemHandle = {
            Toast(text: "点击了第 \($0 + 1) 张图").show()
        }
        
        let layout = LTDotLayout(dotColor: UIColor.lightGray, dotSelectColor: UIColor.white, dotType: .default)
        /*设置dot的间距*/
        layout.dotMargin = 8
        /* 如果需要改变dot的大小，设置dotWidth的宽度即可 */
        layout.dotWidth = 8
        /*如需和系统一致，dot放大效果需手动关闭 */
        layout.isScale = false
        bottomBanner.dotLayout = layout
        return bottomBanner
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
            return (UIScreen.main.bounds.size.width / CGFloat(countCol) + 8.0) * CGFloat(countRow) + 15.0 // 10.0 用于显示pageControl, 8.0 为单个菜单按钮高度与宽度的差 ,此处数字不需要修改
        }
        else {
            return 50.0
        }
    }
}
