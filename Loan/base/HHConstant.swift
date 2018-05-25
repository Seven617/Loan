//
//  HHConstant.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/24.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import UIKit

//屏幕高度
let kScreen_Height = UIScreen.main.bounds.size.height;

//屏幕宽度
let kScreen_Width = UIScreen.main.bounds.size.width;

//判断iPhone4
let IPHONE4_DEV:Bool! = (UIScreen.main.bounds.size.height == 480.0) ? true : false

//判断iPhone5/5c/5s
let IPHONE5_DEV:Bool! = (UIScreen.main.bounds.size.height == 568.0) ? true : false

//判断iPhone6/6s/7/8
let IPHONE6_DEV:Bool! = (UIScreen.main.bounds.size.height == 667.0) ? true : false

//判断iPhone6p/7p/8p
let IPHONE6p_DEV:Bool! = (UIScreen.main.bounds.size.height == 736.0) ? true : false

//判断iphoneX
let IPHONEX_DEV:Bool! = (UIScreen.main.bounds.size.height == 812.0) ? true : false


//其它屏幕尺寸相对iphone6的宽度
func kWithRelIPhone6(width: CGFloat) -> CGFloat {
    return width * kScreen_Width / 375.0;
}

//其它屏幕尺寸相对iphone6的高度
func kHeightRelIPhone6(height: CGFloat) -> CGFloat {
    return  (kScreen_Height / 667.0)*height;
}

//RGB 16进制转换
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//通过颜色获取图片
func imageWithColor(color:UIColor, size:CGSize) -> UIImage {
    
    let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height);
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext();
    context?.setFillColor(color.cgColor);
    context?.addRect(rect);
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    return img!;
}

