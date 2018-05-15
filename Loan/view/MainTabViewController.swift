//
//  MainTabViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  支持Fragment的住界面

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
        UITabBarItem.appearance().setTitleTextAttributes([kCTFontAttributeName as NSAttributedStringKey : UIFont.systemFont(ofSize: 12)], for: .normal)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor:UIColor(red: 50/256.0, green: 220/256.0, blue: 210/256.0, alpha: 1), kCTFontAttributeName : UIFont.boldSystemFont(ofSize: 12)]
        
        let main = UINavigationController(rootViewController:viewHome)
        main.tabBarItem.image = UIImage(named:"home")?.withRenderingMode(.alwaysOriginal)
        main.tabBarItem.selectedImage=UIImage(named: "home_press")?.withRenderingMode(.alwaysOriginal)
        main.tabBarItem.setTitleTextAttributes( dict as? [NSAttributedStringKey : Any], for: .selected)
        
        //main.tabBarItem.badgeValue = "!"
        let loan = UINavigationController(rootViewController:viewLoan)
        loan.tabBarItem.image = UIImage(named:"loan")?.withRenderingMode(.alwaysOriginal)
        loan.tabBarItem.selectedImage=UIImage(named: "loan_press")?.withRenderingMode(.alwaysOriginal)
        loan.tabBarItem.setTitleTextAttributes( dict as? [NSAttributedStringKey : Any], for: .selected)
   
        let mine = UINavigationController(rootViewController:viewMine)
        mine.tabBarItem.image = UIImage(named:"mine")?.withRenderingMode(.alwaysOriginal)
        mine.tabBarItem.selectedImage=UIImage(named: "mine_press")?.withRenderingMode(.alwaysOriginal)
        mine.tabBarItem.setTitleTextAttributes( dict as? [NSAttributedStringKey : Any], for: .selected)
       
        
        self.viewControllers = [main,loan,mine]
        //默认选中界面视图
        self.selectedIndex = 0
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
