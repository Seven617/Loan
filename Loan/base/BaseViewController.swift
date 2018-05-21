//
//  BaseViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/17.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var topY: CGFloat = 20
    var navH: CGFloat = 64
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SCREEN_HEIGHT == 812 {
            topY = 44
            navH = 88
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
