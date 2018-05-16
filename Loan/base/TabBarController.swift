//
//  TabBarController.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addAllChildVcs()
        self.tabBar.tintColor = UIColor.Main
        UITabBar.appearance().backgroundColor = UIColor.Gray
    }
    
    // 添加所有的子控制器
    func addAllChildVcs() {
        
        self.addOneChildViewController(HomeFragmentVC(), title: "首页", imageName: "home", selectedImageName: "home_press")
        
        self.addOneChildViewController(LoanFragmentVC(), title: "借贷", imageName: "loan", selectedImageName: "loan_press")
        
        self.addOneChildViewController(MineFragmentVC(), title: "我的", imageName: "mine", selectedImageName: "mine_press")
    }
    
    // 创建子控制器
    func addOneChildViewController(_ childVC:UIViewController, title:String, imageName:String, selectedImageName:String) {
        
        childVC.title = title;
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let nav = NavigationController(rootViewController:childVC)
        self.addChildViewController(nav)
    }
}
