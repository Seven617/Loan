//
//  MainTabViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //一共包含了三个视图
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewHome = storyboard.instantiateViewController(withIdentifier: String(describing:
            type(of: HomeFragmentVC())))
        viewHome.title = "首页"
        let viewLoan = storyboard.instantiateViewController(withIdentifier: String(describing: type(of:LoanFragmentVC())))
        viewLoan.title = "借贷"
        let viewMine = storyboard.instantiateViewController(withIdentifier: String(describing: type(of:MineFragmentVC())))
        viewMine.title = "我的"
        
        //分别声明三个视图控制器定义tab按钮图标和字体大小
        let main = UINavigationController(rootViewController:viewHome)
        main.tabBarItem.image = UIImage(named:"home")
        main.tabBarItem.selectedImage=UIImage(named: "home_press")
        main.tabBarItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedStringKey : UIFont.systemFont(ofSize: 12)], for: .normal)
        //定义tab按钮添加个badge小红点值
        //main.tabBarItem.badgeValue = "!"
        let loan = UINavigationController(rootViewController:viewLoan)
        loan.tabBarItem.image = UIImage(named:"loan")
        loan.tabBarItem.selectedImage=UIImage(named: "loan_press")
        loan.tabBarItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedStringKey : UIFont.systemFont(ofSize: 12)], for: .normal)
        let mine = UINavigationController(rootViewController:viewMine)
        mine.tabBarItem.image = UIImage(named:"mine")
        mine.tabBarItem.selectedImage=UIImage(named: "mine_press")
        mine.tabBarItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedStringKey : UIFont.systemFont(ofSize: 12)], for: .normal)
        self.viewControllers = [main,loan,mine]
        
        //默认选中界面视图
        self.selectedIndex = 0
    }

}
