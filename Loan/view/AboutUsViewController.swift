//
//  AboutUsViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  关于我们界面

import UIKit

class AboutUsViewController: UIViewController,UIScrollViewDelegate {
    var scroll:UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关于我们"
        view.backgroundColor = UIColor.white
        scroll = UIScrollView(frame: view.bounds)
        let myView = UIView(frame: CGRect(x: 50, y: 50, width: 300, height: 500))
        myView.backgroundColor = UIColor.lightGray
        scroll.addSubview(myView)
        //内容大小，小于scrollView的大小肯定不会scroll啊
        scroll.contentSize = CGSize(width: view.bounds.width*2, height: view.bounds.height*2)
        //但是可以设定，内容就算小于它，也能拖：
        scroll.alwaysBounceVertical = true //还有水平的
        //内容的初始位置偏移到指定point处
        scroll.contentOffset = CGPoint(x: 20, y: 20)
        //拉到头时可否反弹 default为true
        scroll.bounces = true
        //拖时候不能改变方向。但往对角线方向开始拖，可以自由拖
        scroll.isDirectionalLockEnabled = false //default false
        //翻页效果，true就是手滑动小了回到原位置，大了直接跳下一页
        scroll.isPagingEnabled = false
        //scroll.isScrollEnabled = false //false就不能滑了==
        //点状态栏回到最上方
        scroll.scrollsToTop = true;
        //滚动条到屏幕边缘的距离 offset <-> inset ,offset偏移，inset内移
        scroll.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        //add additional scroll area around content
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //是否显示滚动条
        scroll.showsVerticalScrollIndicator = true //还有水平的
        scroll.indicatorStyle = .black //默认黑，黑白两色可选
        function()
        //实现两指缩放与扩大
        scroll.minimumZoomScale = 0.5
        scroll.maximumZoomScale = 1.6
        //超过放大范围再弹回来
        scroll.bouncesZoom = true
        //如果正显示着键盘，拖动，则键盘撤回
        scroll.keyboardDismissMode = .onDrag
        //scroll.refreshControl = UIRefreshControl(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        
        //        open var decelerationRate: CGFloat
        
        //        open var indexDisplayMode: UIScrollViewIndexDisplayMode
        //现在实现ScrollViewDelegate,补充后面的协议方法
        scroll.delegate = self
        view.addSubview(scroll)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //设置可以缩放
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return scrollView.subviews[0]
    }
    func function(){
        //滚动条突然显现一下
        scroll.flashScrollIndicators()
    }
    //点击状态栏时触发，返回false则不能滑上去 相应的 didScrollToTop是已经回了调用的
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    //开始拖拽前：
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    //手滑后，松手减速，结束时：
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    //拖拽结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    //滚动动画结束
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    }
    //剩下的真的不想写了，，用到时候直接看文档吧，都是差不多的方法。。。可以自己试出来
}
