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
import Masonry


class HomeFragmentVC: BaseViewController,SCCycleScrollViewDelegate,UIScrollViewDelegate {
    var navView = UIView()
    var arrIcon:Array<Any>! = nil
    var arrMenu:Array<Any> = Array()
    var MainscrollView = UIScrollView()
    var topBanner : SCCycleScrollView!
    var bottomBanner : SCCycleScrollView!
    var weekNew = UIView()
    var tableView = UITableView()
    var scrollMenView = IWBusinessCategorySV()
    var noticeView = ZJNoticeView()
    var asView = ASAdverRollView()
    var red = UIView()
    var BottomLab = UILabel()
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 图片URL 或者 本地图片名称
    var topImages = ["http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/c0b8c738-7e62-497a-b79c-d53d26cb7f34.png"]
    var bottomImages = ["http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/28b3830f-53bd-45af-9340-74736f9ccbcb.jpg"]
    var scrollMenViewImg = ["http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/560132b9-e06a-4c31-9cf8-1a99205955ee", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/2f5846d7-62e4-454c-88b3-56d0828e9cf1", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/50be8bf4-2882-46fa-9026-d3873730e3b5", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/3164493f-09cb-4bdc-8ffc-93b4866e9654.png", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/c43074ea-de2e-4203-899c-2849b6f982b5", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/05feec47-10a0-4617-9039-106c572025e1", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/1e91c3f4-25d2-40f1-9a1d-58b30a12d711", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/33526177-597d-44bc-8fa0-63d266db7efe.png", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/4a4c3f10-19e6-4bc1-ab10-5e3aa32f011a.png", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/51147ab9-0546-408b-812f-996c77f1bd54.png", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/a3bc518e-3b8e-413d-8600-754ea2b1ef30.png", "http://ruifo.oss-cn-hangzhou.aliyuncs.com/uploads/355fc1d2-eb48-4c45-9e16-51d50b7b7ff9.png"]
    var scrollMenViewTitle = ["极速白卡", "金龙钱包", "91借吧", "汪汪贷", "花了呗", "壁虎岩", "联仲花花", "花个够", "大唐贷", "信享乐", "财多多", "简速花"]
    var radioString = ["134*****263在信享乐成功借款1000.0元", "186*****966在极速白卡成功借款1000.0元", "185*****587在金龙钱包成功借款3000.0元", "151*****666在信享乐成功借款2000.0元", "156*****944在简速花成功借款3000.0元", "187*****721在联仲花花成功借款2000.0元", "188*****401在花个够成功借款900.0元", "187*****325在大唐贷成功借款2000.0元", "185*****451在联仲花花成功借款2000.0元", "137*****811在极速白卡成功借款1000.0元", "133*****871在财多多成功借款4000.0元", "153*****351在壁虎岩成功借款10000.0元", "186*****611在大唐贷成功借款2000.0元", "188*****546在91借吧成功借款4000.0元", "138*****661在信享乐成功借款1000.0元", "150*****373在91借吧成功借款10000.0元", "186*****717在金龙钱包成功借款3000.0元", "133*****564在花个够成功借款700.0元", "186*****223在极速白卡成功借款2000.0元", "152*****131在壁虎岩成功借款5000.0元"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
//        Thread.sleep(forTimeInterval: 1) //延长1秒
        intiNavigationControlle()
        getTopBanner()
        getweekNew()
        getScrollMenView()
        getnoticeView()
        getBottomBanner()
        getRed()
        getBottomLine()
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
        MainscrollView = UIScrollView(frame: CGRect(x:0, y:navH, width:SCREEN_WIDTH, height:SCREEN_HEIGHT))
        //设置代理
        MainscrollView.delegate = self
        // 点击状态栏时，可以滚动回顶端
        MainscrollView.scrollsToTop = true
        //隐藏滚动条
        MainscrollView.showsVerticalScrollIndicator = false
        view.addSubview(MainscrollView)
        MainscrollView.addSubview(topBanner)
        MainscrollView.addSubview(weekNew)
        MainscrollView.addSubview(scrollMenView)
        MainscrollView.addSubview(noticeView)
        MainscrollView.addSubview(bottomBanner)
        MainscrollView.addSubview(red)
        MainscrollView.addSubview(BottomLab)
        //设置内容大小
        if #available(iOS 11.0, *) {
            MainscrollView.contentSize = CGSize(width:SCREEN_WIDTH, height:
                navH+red.frame.maxY)
        } else {
            MainscrollView.contentSize = CGSize(width:SCREEN_WIDTH, height:
                navH+red.frame.maxY+(self.tabBarController?.tabBar.frame.size.height)!)
        }
        
    }
    //获取Banner滚动条
    /*  设置为系统的pageControl样式利用dotType */
    func getTopBanner(){
        let placeholderImage = UIImage(named: "WechatIMG1")
        topBanner = SCCycleScrollView.cycleScrollView(frame: CGRect(x: 0, y:0, width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 150)),delegate: self,placeholderImage: placeholderImage)
        topBanner.delegate = self
        topBanner.timeInterval = 3.5
        topBanner.imageArray = topImages as [AnyObject]
        topBanner.pageControlBottomMargin = 5
        topBanner.pageControlRightMargin = (UIScreen.main.bounds.width - topBanner.pageControlSize.width) / 2.0
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
    }
    
    func getScrollMenView(){
        scrollMenView = IWBusinessCategorySV(frame: CGRect(x:0, y:weekNew.frame.maxY ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 190)),imageArray: scrollMenViewImg, titleArray: scrollMenViewTitle, target: self, action: #selector(HomeFragmentVC.clickBusinessCategoryBtn(_:)))
    }
    @objc func clickBusinessCategoryBtn(_ sender: UIButton?) {
        let tag = (sender?.tag ?? 0) - Int(KCategoryTag)
        SYIToast.alert(withTitleBottom: scrollMenViewTitle[tag])
    }
    
    func getnoticeView(){
        noticeView.frame = CGRect(x: 0, y: scrollMenView.frame.maxY, width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 30))
        noticeView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5);
        noticeView.scrollLabel.setTexts(radioString)
        noticeView.scrollLabel.resume()


//        asView = ASAdverRollView(frame: CGRect(x: 0, y: noticeView.frame.maxY, width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 30)))
//        asView.adverTitles = ["关关雎鸠，在河之洲。窈窕淑女，君子好逑。",
//                              "参差荇菜，左右流之。窈窕淑女，寤寐求之。",
//                              "求之不得，寤寐思服。悠哉悠哉，辗转反侧。",
//                              "参差荇菜，左右采之。窈窕淑女，琴瑟友之。",
//                              "参差荇菜，左右芼之。窈窕淑女，钟鼓乐之。"]
//        asView.asBGColor = UIColor.lightGray.withAlphaComponent(0.5)
//        asView.fontColor = UIColor.red
//        asView.alignment = .center
//        MainscrollView.addSubview(asView)
//        asView.startScroll()
    }
    
    //视图滚动中一直触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("x:\(scrollView.contentOffset.x) y:\(scrollView.contentOffset.y)")
        // 禁止下拉
        // if scrollView.contentOffset.y <= 0 {
        // scrollView.contentOffset.y = 0
        //
        //禁止上拉
        //if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height {
        //scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.size.height
        //}
    }

    func getBottomBanner() {
        let placeholderImage = UIImage(named: "WechatIMG1")
        bottomBanner = SCCycleScrollView.cycleScrollView(frame: CGRect(x: 0, y:noticeView.frame.maxY, width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 180)),delegate: self,placeholderImage: placeholderImage)
        bottomBanner.delegate = self
        bottomBanner.timeInterval = 3.5
        bottomBanner.imageArray = bottomImages as [AnyObject]
        bottomBanner.pageControlBottomMargin = 5
        bottomBanner.pageControlRightMargin = (UIScreen.main.bounds.width - bottomBanner.pageControlSize.width) / 2.0
    }
    func cycleScrollView(_ cycleScrollView: SCCycleScrollView, didSelectItemAt index: Int) {
        let web = WebViewController()
        if cycleScrollView==topBanner{
            web.url="https://ecentre.spdbccc.com.cn/creditcard/indexActivity.htm?data=I2362551&itemcode=shmr050001"
        
        }else{
            web.url = "https://hualebei-agent.yylky.cn/mobile/gotodownload?2BA8B11C47DE5DAA204A6DE2D13225045E6D7230953AF0860263E1BCE0943B64="
        }
        self.navigationController?.pushViewController(web, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRed(){
        red = UIView(frame: CGRect(x:0, y:bottomBanner.frame.maxY ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 180)))
        red.backgroundColor = UIColor.Red
    }
    func getBottomLine(){
        BottomLab = UILabel(frame: CGRect(x:0, y:red.frame.maxY ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 40)))
        BottomLab.text = "———— 我是有底线的 ————"
        BottomLab.textAlignment=NSTextAlignment.center
        BottomLab.textColor = UIColor.Line
        BottomLab.font = UIFont.boldSystemFont(ofSize: 13)
    }
}
