//
//  String+Extension.swift
//  WKWebViewSwift
//
//  Created by XiaoFeng on 2017/10/20.
//  Copyright © 2017年 XiaoFeng. All rights reserved.
//

import Foundation

extension String {
    /// 截取字符串
    ///
    /// - Parameter index: 截取从index位开始之前的字符串
    /// - Returns: 返回一个新的字符串
    func mySubString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    /// 截取字符串
    ///
    /// - Parameter index: 截取从index位开始到末尾的字符串
    /// - Returns: 返回一个新的字符串
    func mySubString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
}

/**
 计算label的宽度和高度
 
 :param: text       label的text的值
 :param: attributes label设置的字体
 
 :returns: 返回计算后label的CGRece
 */
func labelSize(text:String ,attributes : [NSObject : AnyObject]) -> CGRect{
    var size = CGRect();
    let size2 = CGSize(width: SCREEN_WIDTH-40, height: 0);//设置label的最大宽度
    size = text.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as? [NSAttributedStringKey : Any] , context: nil);
    return size
}

