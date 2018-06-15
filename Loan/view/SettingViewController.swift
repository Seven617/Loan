//
//  SettingViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/14.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  设置界面

import UIKit

class SettingViewController: BaseViewController {
    var navView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        initNavigationControlle()
        initView()
    }
    func initNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
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
        titleLabel.text = "设置"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    func initView(){
        let background = UIView(frame: CGRect(x: 0, y: navView.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/3))
        background.backgroundColor = UIColor.white
        view.addSubview(background)
        
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kWithRelIPhone6(width: 70), height: kHeightRelIPhone6(height: 70)))
        img.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: navH+10)
        img.image  = UIImage(named:"AppIcon")
        img.layer.cornerRadius = 15.0
        img.clipsToBounds = true
        background.addSubview(img)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.6, height: kHeightRelIPhone6(height: 30)))
        btn.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: img.frame.maxY + 50)
//        btn.backgroundColor = UIColor.white
        btn.setTitle("《快便贷用户服务协议》", for:.normal)
        btn.setTitleColor(UIColor.Main, for: .normal) //普通状态下文字的颜色
        btn.setTitleColor(UIColor.MainPress, for: .highlighted) //触摸状态下文字的颜色
        btn.setTitleColor(UIColor.gray, for: .disabled) //禁用状态下文字的颜色
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        background.addSubview(btn)
        
        let LoginOutBtn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.8, height: kHeightRelIPhone6(height: 40))))
        LoginOutBtn.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: background.frame.maxY + 50)
        LoginOutBtn.setTitle("退出当前账号", for:.normal)
        LoginOutBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        LoginOutBtn.backgroundColor = UIColor.Main
        LoginOutBtn.addTarget(self,action:#selector(loginOut),for:.touchUpInside)
        LoginOutBtn.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        LoginOutBtn.layer.cornerRadius = 20.0
        LoginOutBtn.clipsToBounds = true
        view.addSubview(LoginOutBtn)

    }
    
    @objc func loginOut(){
        SYIToast.alert(withTitleBottom: "你点击了退出！")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
