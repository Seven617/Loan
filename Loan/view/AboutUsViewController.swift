//
//  AboutUsViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  关于我们界面

import UIKit

class AboutUsViewController: BaseViewController {
    var scroll:UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initImg()
    }
    func intiNavigationControlle(){
        // 自定义导航栏视图
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.lightGray
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        backBtn.setImage(UIImage(named: "back_black"), for: UIControlState.normal)
        navView.addSubview(backBtn)
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "关于我们"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    func initImg(){
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        img.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: SCREEN_HEIGHT/4)
        img.image  = UIImage(named:"AppIcon")
        img.layer.cornerRadius = 15.0
        img.clipsToBounds = true
        view.addSubview(img)
        
        let Lab = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        Lab.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: img.frame.maxY + 40)
        Lab.text = "杭州快便付信息技术有限公司"
        Lab.textAlignment=NSTextAlignment.center  
        Lab.textColor = UIColor.Font2nd
        Lab.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(Lab)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .default
    }
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    @objc func backBtnClicked() {
        print("H1自定义返回按钮点击")
        navigationController?.popViewController(animated: true)
    }

 
}
