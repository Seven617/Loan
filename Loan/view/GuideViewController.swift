//
//  GuideViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  引导界面

import UIKit

class GuideViewController: UIViewController {

    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var startButton: UIButton!
    
    fileprivate var scrollView: UIScrollView!
    fileprivate let numOfPages = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        //隐藏返回按钮
        self.navigationItem.hidesBackButton = true
        let frame = self.view.bounds
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: 0)
        
        scrollView.delegate = self
        
        for index  in 0..<numOfPages {
            let imgview = UIImageView(image: UIImage(named: "guide_background\(index + 1)"))
            imgview.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imgview)
        }
        
        self.view.insertSubview(scrollView, at: 0)
        
        // 给开始按钮设置圆角
        startButton.layer.cornerRadius = 15.0
        // 隐藏开始按钮
        startButton.alpha = 0.0
    }
    
    @IBAction func click(_ sender: UIButton) {
        navigationController!.pushViewController(MainController(),animated:true)
    }
    
    // 隐藏状态栏
    //    override var prefersStatusBarHidden : Bool {
    //        return true
    //    }
}

// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        // 选中圆点颜色
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        // 未选中圆点颜色
        pageControl.pageIndicatorTintColor = UIColor.gray
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            })
        }
    }

}
