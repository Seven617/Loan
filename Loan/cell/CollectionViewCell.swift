//
//  CollectionViewCell.swift
//  ScrollItemView
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    let img = UIImageView()
    let LabView = UIView()
    let name = UILabel()
    let quotalab = UILabel()
    let quota = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

      initialFromXib()
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    
    func initialFromXib() {
        img.frame = CGRect(x: 5, y: 0, width:kWithRelIPhone6(width: 50) , height: kHeightRelIPhone6(height: 50))
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        addSubview(img)
        
        let lineLeft:CGFloat = img.frame.right + 10
        let lineMargin:CGFloat = 10
        
        LabView.frame = CGRect(x: lineLeft, y: 0, width: kWithRelIPhone6(width:SCREEN_WIDTH - img.frame.width), height: kHeightRelIPhone6(height:50))
        addSubview(LabView)
        
        
        name.frame = CGRect(x: 0, y: lineMargin, width:  kWithRelIPhone6(width: 60), height: kHeightRelIPhone6(height: 10))
        name.font = UIFont.italicSystemFont(ofSize: 15)
        name.textAlignment = .left
        LabView.addSubview(name)
        
        quotalab.frame = CGRect(x: 0, y: name.frame.bottom + lineMargin, width: kWithRelIPhone6(width: 28), height: kHeightRelIPhone6(height:10))
        quotalab.font = UIFont.italicSystemFont(ofSize: 13)
        quotalab.textAlignment = .left
        quotalab.text = "额度"
        let quotalabtext:String = quotalab.text!//获取label的text
        let quotalabattributes = [kCTFontAttributeName: quotalab.font!]//计算label的字体
        quotalab.frame = labelSize(text: quotalabtext, attributes: quotalabattributes)//调用计算label宽高的方法
        quotalab.mj_origin = CGPoint(x: 0, y:name.frame.bottom + lineMargin)
        LabView.addSubview(quotalab)
        
        quota.frame = CGRect(x: quotalab.frame.right, y: name.frame.bottom + lineMargin, width: kWithRelIPhone6(width: 100), height: kHeightRelIPhone6(height:10))
        quota.textColor = UIColor.red
        quota.textAlignment = .center
        quota.text = "Wait loading..."
        quota.font = UIFont.boldSystemFont(ofSize: 13)
        let quotatext:String = quota.text!//获取label的text
        let quotaattributes = [kCTFontAttributeName: quota.font!]//计算label的字体
        quota.frame = labelSize(text: quotatext, attributes: quotaattributes)//调用计算label宽高的方法
        quota.mj_origin = CGPoint(x: quotalab.frame.right, y:name.frame.bottom + lineMargin)
        LabView.addSubview(quota)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
    }

}
