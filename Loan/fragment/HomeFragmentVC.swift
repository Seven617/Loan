//
//  HomeFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class HomeFragmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource, LPBannerViewDelegate {

    @IBOutlet var bannerView: LPBannerView!
    @IBOutlet var tableView: UITableView!
    var dataDic:Dictionary<String, Any>! = nil
    var arrIcon:Array<Any>! = nil
    var arrMenu:Array<Any> = Array()
//    public var pgCtrlNormalColor: UIColor! = nil
//    public var pgCtrlSelectedColor: UIColor! = nil
    public var pgCtrlShouldHidden: Bool! = false
    public var countRow:Int! = 2
    public var countCol:Int! = 5
    public var countItem:Int! = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        //隐藏返回按钮
        self.navigationItem.hidesBackButton = true
        Thread.sleep(forTimeInterval: 1) //延长1秒
        //导航栏
        self.title = "快便贷"
        //设置导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/256.0, green: 220/256.0, blue: 210/256.0, alpha: 1)
        //定义标题颜色与字体大小字典
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white, kCTFontAttributeName : UIFont.boldSystemFont(ofSize: 25)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        
        // 图片URL 或者 本地图片名称
        let imagesArr = ["WechatIMG2.jpeg","WechatIMG3.jpeg","WechatIMG4.jpeg","WechatIMG5.jpeg","WechatIMG6.jpeg","WechatIMG7.jpeg"]
        // 轮播图一（最简单基本的用法）
        //        view.addSubview(bannerView)
        let bannerView = self.bannerView
        bannerView?.autoScrollTimeInterval = 5
        bannerView?.isHiddenWhenSinglePage = true
        bannerView?.delegate = self
        bannerView?.placeholderImage = #imageLiteral(resourceName: "WechatIMG6")
        bannerView?.clickItemClosure = { (index) -> Void in
            print("闭包回调---\(index)")
        }
        // 异步网络请求得到相关数据之后赋值刷新
        bannerView?.imagePaths = imagesArr
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        setData()
        regReuseView()
        
    }
    
    // 轮播图点击回调方法
    func cycleScrollView(_ scrollView: LPBannerView, didSelectItemAtIndex index: Int) {
        print("方法回调--->>>\(index)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setData() {
        let plistPath = Bundle.main.path(forResource: "menuData", ofType: "plist")
        let arrayAllMenu: Array<Any> = NSArray(contentsOfFile: plistPath!) as!  Array<Any>
        for index in (0..<countItem) {
            arrMenu.append(arrayAllMenu[index])
        }
        tableView.reloadData()
    }
    
    // 注册可复用视图
    func regReuseView() {
        tableView.register(CoolTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    // MARK: - 数据源
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CoolTableViewCell
        cell.pgCtrlShouldHidden = pgCtrlShouldHidden
//        cell.pgCtrlNormalColor = pgCtrlNormalColor
//        cell.pgCtrlSelectedColor = pgCtrlSelectedColor
        cell.countRow = countRow
        cell.countCol = countCol
        cell.arrMenu = arrMenu
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (UIScreen.main.bounds.size.width / CGFloat(countCol) + 8.0) * CGFloat(countRow) + 10.0 // 10.0 用于显示pageControl, 8.0 为单个菜单按钮高度与宽度的差 ,此处数字不需要修改
        }
        else {
            return 50.0
        }
        
    }
}
