//
//  UIFont_Extension.swift
//  ScreenEdgePanGesture
//
//  Created by Tony on 2017/9/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func auto(size: CGFloat) -> UIFont {
        let autoSize = size * SCREEN_WIDTH / 375.0
        return UIFont.systemFont(ofSize: autoSize)
    }
    
    class func systemFont(ofSize fontSize: CGFloat) -> UIFont {
        var fontSize = fontSize
        //根据屏幕尺寸判断的设备，然后字体设置为0.8倍
        if SCREEN_HEIGHT < 568 {
            fontSize = fontSize * 0.8
        }else{
            fontSize = fontSize * 1.2
        }
        let newFont: UIFont? = UIFont.preferredFont(forTextStyle: .body)
        let ctfFont: UIFontDescriptor? = newFont?.fontDescriptor
        let fontString = ctfFont?.object(forKey: UIFontDescriptor.AttributeName("NSFontNameAttribute")) as? String
        //使用fontWithName 设置字体
        return (UIFont(name: fontString ?? "", size: fontSize))!
    }
}
