//
//  LBSwift_PersonalPage.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/14.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class LBSwift_PersonalPage: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    let LBWIDTH = UIScreen.main.bounds.size.width
    let LBHEIGHT = UIScreen.main.bounds.size.height
    var BackGroupHeight:CGFloat  = 200
    var HeadImageHeight:CGFloat = 80
    var dataArr = NSMutableArray()
    var tabView  :UITableView?
    var BGView :UIView?
    var headImageView :UIImageView?
    var imageBG:UIImageView?
    var nameLabel:UILabel?
    var leftBtn:UIButton?
    var rightBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .createUI()
    }
    
    func createUI(){
        
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        var rect = CGRectMake(0, 0, LBWIDTH, LBHEIGHT)
        tabView = UITableView(frame:UIScreen.main.bounds,style:.plain)
        tabView!.delegate = self
        tabView!.dataSource = self
        tabView!.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        
        self.view.addSubview(tabView!)
        tabView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tabView?.tableFooterView = UIView(frame: CGRect.zero)
        
        imageBG = UIImageView(frame: CGRect(x:0,y: -200,width: LBWIDTH,height: 200))
        imageBG?.image = UIImage (named: "BG.jpg")
        tabView!.addSubview(imageBG!)
        
        BGView = UIView(frame: CGRect(x:0,y: -200,width: 0,height:200))
        BGView?.backgroundColor = UIColor.clear
        tabView!.addSubview(BGView!)
        
        let X = (LBWIDTH - 80)/2 as CGFloat
        headImageView = UIImageView(frame: CGRect(x:X,y: 40,width: 80,height: 80))
        headImageView?.layer.cornerRadius = 80/2
        headImageView?.clipsToBounds = true
        headImageView?.image = UIImage(named: "myheadimage.jpeg")
        BGView!.addSubview(headImageView!)
        
        nameLabel = UILabel(frame: CGRect(x:X, y:(headImageView!.frame).maxY+5, width:80, height:20))
        nameLabel?.text = "BISON"
        nameLabel?.textAlignment = NSTextAlignment.center
        BGView!.addSubview(nameLabel!)
        
        leftBtn = UIButton(frame: CGRect(x:0,y: 0,width: 45,height: 20))
        leftBtn!.setTitle("lift", for: .normal)
        leftBtn!.setTitleColor(UIColor.white, for: .normal)
        leftBtn!.addTarget(self, action: Selector(("leftBtnClick")), for: .touchUpInside)
        let leftItem:UIBarButtonItem = UIBarButtonItem(customView: leftBtn!)
        self.navigationItem.leftBarButtonItem = leftItem
        
        rightBtn = UIButton(frame: CGRect(x:0,y: 0,width: 45,height: 20))
        rightBtn!.setTitle("right", for: .normal)
        rightBtn!.setTitleColor(UIColor.white, for: .normal)
        rightBtn!.addTarget(self, action: Selector(("rightBtnClick")), for: .touchUpInside)
        let rightItem:UIBarButtonItem = UIBarButtonItem(customView: rightBtn!)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
    }
    
    func leftBtnClick(){
        print("点了我的左边")
    }
    func rightBtnClick(){
        print("点了我的右边")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.textLabel?.text = "BISON"
        
        return cell
    }
    
    
    private func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset:CGFloat = scrollView.contentOffset.y
        
        let xOffset:CGFloat  = (yOffset + 200)/2
        
        if yOffset < -200{
            var rect:CGRect = imageBG!.frame
            rect.origin.y = yOffset
            rect.size.height = -yOffset
            rect.origin.x = xOffset
            rect.size.width = LBWIDTH + fabs(xOffset)*2
            imageBG?.frame = rect
            
            var HeadImageRect:CGRect = CGRect(x:(LBWIDTH - 80)/2,y: 40,width: 80,height: 80)
            HeadImageRect.origin.y = headImageView!.frame.origin.y
            HeadImageRect.size.height = HeadImageHeight + fabs(xOffset)*0.5
            HeadImageRect.origin.x = LBWIDTH/2 - HeadImageRect.size.height/2
            HeadImageRect.size.width = HeadImageHeight + fabs(xOffset)*0.5
            headImageView?.frame = HeadImageRect
            headImageView?.layer.cornerRadius = HeadImageRect.size.height/2
            headImageView?.clipsToBounds = true
            
            var NameRect:CGRect = nameLabel!.frame
            NameRect.origin.y = (headImageView!.frame).maxY+5
            NameRect.size.height = 20 + fabs(xOffset)*0.5
            NameRect.origin.x = LBWIDTH/2 - NameRect.size.width/2
            NameRect.size.width = HeadImageHeight + fabs(xOffset)*0.5
            
            nameLabel?.font = UIFont.systemFont(ofSize: 17 + fabs(xOffset)*0.2)
            nameLabel?.frame = NameRect
        }else{
            
            var HeadImageRect:CGRect = CGRect(x:(LBWIDTH - 80)/2, y:40,width: 80,height: 80)
            HeadImageRect.origin.y = 40
            HeadImageRect.size.height = HeadImageHeight - fabs(xOffset)*0.5
            HeadImageRect.origin.x = LBWIDTH/2 - HeadImageRect.size.height/2
            HeadImageRect.size.width = HeadImageHeight - fabs(xOffset)*0.5
            headImageView?.frame = HeadImageRect
            headImageView?.layer.cornerRadius = HeadImageRect.size.height/2
            headImageView?.clipsToBounds = true
            
            var NameRect:CGRect = CGRect(x:(LBWIDTH - 80)/2,y: 120+5,width: 80, height:20)
            NameRect.origin.y = HeadImageRect.origin.y + HeadImageRect.size.width + 5
            NameRect.size.height = 20
            NameRect.origin.x = LBWIDTH/2 - HeadImageRect.size.height/2
            NameRect.size.width = HeadImageHeight - fabs(xOffset)*0.5
            
            nameLabel?.font = UIFont.systemFont(ofSize: 17 - fabs(xOffset)*0.2)
            nameLabel?.frame = NameRect
            
        }
        
    }
    
    //    func imageWiwhColor(color :UIColor)->UIImage{
    //
    //        // 描述矩形
    //        var rect:CGRect  = CGRectMake(0.0, 0.0, 1.0, 1.0)
    //        // 开启位图上下文
    //        UIGraphicsBeginImageContext(rect.size)
    //        // 获取位图上下文
    //        var context:CGContextRef = UIGraphicsGetCurrentContext()
    //        // 使用color演示填充上下文
    //        CGContextSetFillColorWithColor(context, color.CGColor)
    //        // 渲染上下文
    //        CGContextFillEllipseInRect(context, rect)
    //        // 从上下文中获取图片
    //        var theImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
    //        // 结束上下文
    //        UIGraphicsEndImageContext()
    //
    //
    //        return theImage
    //    }
    
    
}
