//
//  WeekBestViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class WeekBestViewController: BaseViewController {
    var navView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        initNavigationControlle()
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
        titleLabel.text = "精选贷款"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
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
        navigationController?.popViewController(animated: true)
    }
}
