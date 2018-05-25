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
import GFCustomView
import Masonry


class HomeFragmentVC: BaseViewController,UIScrollViewDelegate {
    var navView = UIView()
    var arrIcon:Array<Any>! = nil
    var arrMenu:Array<Any> = Array()
    var MainscrollView = UIScrollView()
    var weekNew = UIView()
    var tableView = UITableView()
    var scrollMenView = GFScrollMenView()
    var red = UIView()
    var BottomLab = UILabel()
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 图片URL 或者 本地图片名称
    var topImages = ["WechatIMG1.jpeg"]
    var bottomImages = ["WechatIMG8.jpeg"]
    var scrollMenViewImg:NSMutableArray = ["touxiang","WechatIMG7","WechatIMG1","WechatIMG2","WechatIMG3","WechatIMG4","WechatIMG5","WechatIMG6"]
    var scrollMenViewTitle:NSMutableArray = ["依人贷","莉莉贷","爽戴","晨贷","你贷","我贷","他贷","大家贷"]
    public var pgCtrlNormalColor: UIColor! = UIColor.white
    public var pgCtrlSelectedColor: UIColor! = UIColor.gray
    public var pgCtrlShouldHidden: Bool! = false
    public var countRow:Int! = 2
    public var countCol:Int! = 5
    public var countItem:Int! = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        Thread.sleep(forTimeInterval: 1) //延长1秒
        intiNavigationControlle()
        getMainScrollView()
        getTopBanner()
        getweekNew()
        getScrollMenView()
        getBottomBanner()
        getRed()
        getBottomLine()
        MainscrollView.contentSize = (CGSize(width: SCREEN_WIDTH,height: BottomLab.frame.maxY + navH))
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
    //获取getMainScrollView
    func getMainScrollView(){
        MainscrollView = UIScrollView()
        //设置代理
        MainscrollView.delegate = self
        MainscrollView.frame = CGRect(x:0, y:navH, width:SCREEN_WIDTH, height:SCREEN_HEIGHT );//UIScrollView大小
        // 点击状态栏时，可以滚动回顶端
        MainscrollView.scrollsToTop = true
        //隐藏滚动条
        MainscrollView.showsVerticalScrollIndicator = false
        //设置内容大小
        MainscrollView.contentSize = CGSize(width:self.MainscrollView.bounds.width, height: SCREEN_HEIGHT*1.3)
        view.addSubview(MainscrollView)
    }
    
    private func getweekNew(){
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
        MainscrollView.addSubview(weekNew)
    }
    
    //获取Banner滚动条
    private func getTopBanner(){
        if(topImages.count<=1){
            topBanner.isDisableScrollGesture = true
        }else{
            topBanner.isDisableScrollGesture = false
        }
        MainscrollView.addSubview(topBanner)
    }
    
    private func getBottomBanner(){
        if(bottomImages.count<=1){
            bottomBanner.isDisableScrollGesture = true
        }else{
            bottomBanner.isDisableScrollGesture = false
        }
        MainscrollView.addSubview(bottomBanner)
    }
    
    func getScrollMenView(){
//        scrollMenView=GFScrollMenView(frame: CGRect(x:0, y:weekNew.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 100)))
        scrollMenView.titlesArray = scrollMenViewTitle
        scrollMenView.imagesArray = scrollMenViewImg
        // 总数(必须赋值)
        scrollMenView.totallNumber = 8
        // 每页显示个数(必须赋值)
        scrollMenView.pageNum = 4
        // 每行显示个数(必须赋值)
        scrollMenView.rowNum = 4
        // 指示器圆点颜色
        scrollMenView.pageTintColor = UIColor.lightGray
        // 指示器当前页圆点颜色
        scrollMenView.currentPageTintColor = UIColor.gray
        scrollMenView.gfScrollMenViewClickIndex = {(_ index: Int) -> Void in
        SYIToast.alert(withTitleBottom: "\(self.scrollMenViewTitle[index])")
        }
        scrollMenView.backgroundColor = UIColor.white
        MainscrollView.addSubview(scrollMenView)
        scrollMenView.mas_makeConstraints { (make) in
            make?.top.equalTo()(weekNew.frame.maxY)
            make?.left.equalTo()(0)
            make?.right.equalTo()(0)
            make?.width.equalTo()(SCREEN_WIDTH)
            make?.height.equalTo()(100)
        }
    }
    
    
    //视图滚动中一直触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("x:\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
        // 禁止下拉
        // if scrollView.contentOffset.y <= 0 {
        // scrollView.contentOffset.y = 0
        //
        //禁止上拉
        //if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height {
        //scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.size.height
        //}
    }

    /*  设置为系统的pageControl样式利用dotType */
    private lazy var topBanner: LTAutoScrollView = {
        let topBanner = LTAutoScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height:kHeightRelIPhone6(height: 150)))
        topBanner.glt_timeInterval = 3.5
        topBanner.images = topImages
        topBanner.imageHandle = {(imageView, imageName) in
        imageView.image = UIImage(named: imageName)
        }
        topBanner.didSelectItemHandle = {
            print("点击了第 \($0 + 1) 张图")
            self.navigationController?.pushViewController(WebViewController(), animated: true)
        }

        let layout = LTDotLayout(dotColor: UIColor.lightGray, dotSelectColor: UIColor.gray, dotType: .default)
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
        let bottomBanner = LTAutoScrollView(frame: CGRect(x: 0, y:weekNew.frame.maxY+100, width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 150)))
        bottomBanner.glt_timeInterval = 3.5
        bottomBanner.images = bottomImages
        bottomBanner.imageHandle = {(imageView, imageName) in
        imageView.image = UIImage(named: imageName)
        }
        bottomBanner.didSelectItemHandle = {
            SYIToast.alert(withTitleBottom: "点击了第 \($0 + 1) 张图")
        }
        
        let layout = LTDotLayout(dotColor: UIColor.lightGray, dotSelectColor: UIColor.gray, dotType: .default)
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
    
    func getRed(){
        red = UIView(frame: CGRect(x:0, y:bottomBanner.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: UIScreen.main.bounds.height/2)))
        red.backgroundColor = UIColor.Red
        MainscrollView.addSubview(red)
    }
    func getBottomLine(){
        BottomLab = UILabel(frame: CGRect(x:0, y:red.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 40)))
        BottomLab.text = "———— 我是有底线的 ————"
        BottomLab.textAlignment=NSTextAlignment.center
        BottomLab.textColor = UIColor.Line
        BottomLab.font = UIFont.boldSystemFont(ofSize: 13)
        MainscrollView.addSubview(BottomLab)
    }
}
