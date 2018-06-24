//
//  AboutUsViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  关于我们界面

import UIKit

class AboutUsViewController: BaseViewController {
    var box = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initView()
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
    
    func initView(){
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kWithRelIPhone6(width: 70), height: kHeightRelIPhone6(height: 70)))
        img.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: SCREEN_HEIGHT/4)
        img.image  = UIImage(named:"AppIcon")
        img.layer.cornerRadius = 15.0
        img.clipsToBounds = true
        view.addSubview(img)
        
        let Lab = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 30)))
        Lab.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: img.frame.maxY + 40)
        Lab.text = "杭州快便付信息技术有限公司"
        Lab.textAlignment=NSTextAlignment.center  
        Lab.textColor = UIColor.Font2nd
        Lab.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(Lab)
        
        let VersionLab = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 30)))
        VersionLab.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: Lab.frame.maxY + 40)
        let infoDictionary = Bundle.main.infoDictionary
        let appVersion = infoDictionary!["CFBundleShortVersionString"]
        VersionLab.text = "当前版本是:"+String(describing: appVersion!)
        VersionLab.textAlignment=NSTextAlignment.center
        VersionLab.textColor = UIColor.Font2nd
        VersionLab.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(VersionLab)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
 
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }

 
}
