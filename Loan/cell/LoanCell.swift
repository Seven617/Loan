//
//  SampleCell.swift
//  PullToBounce
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class LoanCell: UITableViewCell {
    
    let color = UIColor.lightBlue
    let img = UIImageView()
    let LabView = UIView()
    let name = UILabel()
    let quotalab = UILabel()
    let quota = UILabel()
    let rateslab = UILabel()
    let rates = UILabel()
    let descriptionlab = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        img.frame = CGRect(x: kWithRelIPhone6(width: 10), y: kHeightRelIPhone6(height: 8), width: kWithRelIPhone6(width: 50), height: kHeightRelIPhone6(height:50))
        img.image  = UIImage(named:"AppIcon")
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        self.addSubview(img)

        let lineLeft:CGFloat = img.frame.right + kWithRelIPhone6(width: 15)
        let lineMargin:CGFloat = kHeightRelIPhone6(height: 8)
        
        LabView.frame = CGRect(x: lineLeft, y: 0, width: kWithRelIPhone6(width:SCREEN_WIDTH - img.frame.width), height: kHeightRelIPhone6(height:70))
        self.addSubview(LabView)
        name.frame = CGRect(x: 0, y: lineMargin, width: kWithRelIPhone6(width: 100), height: kHeightRelIPhone6(height:10))
        name.font = UIFont.systemFont(ofSize: 14)
        name.textAlignment = .left
        quotalab.frame = CGRect(x: 0, y: name.frame.bottom, width: kWithRelIPhone6(width: 30), height: kHeightRelIPhone6(height:10))
        quotalab.font = UIFont.systemFont(ofSize: 13)
        quotalab.textAlignment = .left
        quotalab.text = "额度"
        let quotalabtext:String = quotalab.text!//获取label的text
        let quotalabattributes = [kCTFontAttributeName: quotalab.font!]//计算label的字体
        quotalab.frame = labelSize(text: quotalabtext, attributes: quotalabattributes)//调用计算label宽高的方法
        quotalab.mj_origin = CGPoint(x: 0, y:name.frame.bottom+lineMargin)

        quota.frame = CGRect(x: quotalab.frame.right, y: name.frame.bottom+lineMargin , width: kWithRelIPhone6(width: 100), height: kHeightRelIPhone6(height:10))
        quota.textColor = UIColor.red
        quota.textAlignment = .left
        quota.text = "Wait loading..."
        quota.font = UIFont.systemFont(ofSize: 13)
        let quotatext:String = quota.text!//获取label的text
        let quotaattributes = [kCTFontAttributeName: quota.font!]//计算label的字体
        quota.frame = labelSize(text: quotatext, attributes: quotaattributes)//调用计算label宽高的方法
        quota.mj_origin = CGPoint(x: quotalab.frame.right, y:name.frame.bottom+lineMargin)
        
        
        rateslab.frame = CGRect(x: quota.frame.right, y: name.frame.bottom, width: kWithRelIPhone6(width: 30), height: kHeightRelIPhone6(height:10))
        rateslab.font = UIFont.systemFont(ofSize: 13)
        rateslab.textAlignment = .left
        rateslab.text = "费率"
        let rateslabtext:String = quotalab.text!//获取label的text
        let rateslabattributes = [kCTFontAttributeName: rateslab.font!]//计算label的字体
        rateslab.frame = labelSize(text: rateslabtext, attributes: rateslabattributes)//调用计算label宽高的方法
        rateslab.mj_origin = CGPoint(x: quota.frame.right+lineMargin*6, y:name.frame.bottom+lineMargin)
        
        rates.frame = CGRect(x: rateslab.frame.right , y: name.frame.bottom , width: kWithRelIPhone6(width: 50), height: kHeightRelIPhone6(height:10))
        rates.textColor = UIColor.red
        rates.textAlignment = .left
        rates.font = UIFont.systemFont(ofSize: 13)
        let ratestext:String = quota.text!//获取label的text
        let ratesattributes = [kCTFontAttributeName: rates.font!]//计算label的字体
        rates.frame = labelSize(text: ratestext, attributes: ratesattributes)//调用计算label宽高的方法
        rates.mj_origin = CGPoint(x: rateslab.frame.right, y:name.frame.bottom+lineMargin)
        
        descriptionlab.frame = CGRect(x: 0, y: rates.frame.bottom + lineMargin, width: kWithRelIPhone6(width: LabView.frame.width), height: kHeightRelIPhone6(height:10))
        descriptionlab.textAlignment = .left
        descriptionlab.font = UIFont.systemFont(ofSize: 13)
        
        LabView.addSubview(name)
        LabView.addSubview(quotalab)
        LabView.addSubview(quota)
        LabView.addSubview(rateslab)
        LabView.addSubview(rates)
        LabView.addSubview(descriptionlab)

//        let sepalator = UIView()
//        sepalator.frame = CGRect(x: 0, y: kHeightRelIPhone6(height:70) - 1, width: frame.width, height: 1)
//        sepalator.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
//        self.addSubview(sepalator)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

















