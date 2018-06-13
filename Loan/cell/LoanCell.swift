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
        
        img.frame = CGRect(x: 15, y: 15, width: kWithRelIPhone6(width: 40), height: kHeightRelIPhone6(height:40))
        img.image  = UIImage(named:"AppIcon")
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        self.addSubview(img)

        let lineLeft:CGFloat = img.frame.right + 15
        let lineMargin:CGFloat = 10
        
        LabView.frame = CGRect(x: lineLeft, y: 0, width: kWithRelIPhone6(width:SCREEN_WIDTH - img.frame.width), height: kHeightRelIPhone6(height:70))
        self.addSubview(LabView)
        name.frame = CGRect(x: 0, y: lineMargin, width: kWithRelIPhone6(width: 100), height: kHeightRelIPhone6(height:10))
        name.font = UIFont.boldSystemFont(ofSize: 15)
        name.textAlignment = .left
        quotalab.frame = CGRect(x: 0, y: name.frame.bottom + lineMargin, width: kWithRelIPhone6(width: 30), height: kHeightRelIPhone6(height:10))
        quotalab.font = UIFont.italicSystemFont(ofSize: 13)
        quotalab.textAlignment = .left
        quotalab.text = "额度"
        quota.frame = CGRect(x: quotalab.frame.right, y: name.frame.bottom + lineMargin, width: kWithRelIPhone6(width: 80), height: kHeightRelIPhone6(height:10))
        quota.textColor = UIColor.red
        quota.textAlignment = .left
        quota.font = UIFont.boldSystemFont(ofSize: 13)
        
        rateslab.frame = CGRect(x: quota.frame.right+lineMargin*6, y: name.frame.bottom + lineMargin, width: kWithRelIPhone6(width: 30), height: kHeightRelIPhone6(height:10))
        rateslab.font = UIFont.italicSystemFont(ofSize: 13)
        rateslab.textAlignment = .left
        rateslab.text = "费率"
        rates.frame = CGRect(x: rateslab.frame.right , y: name.frame.bottom + lineMargin, width: kWithRelIPhone6(width: 50), height: kHeightRelIPhone6(height:10))
        rates.textColor = UIColor.red
        rates.textAlignment = .left
        rates.font = UIFont.boldSystemFont(ofSize: 13)
        
        descriptionlab.frame = CGRect(x: 0, y: rates.frame.bottom + lineMargin, width: kWithRelIPhone6(width: LabView.frame.width), height: kHeightRelIPhone6(height:10))
        descriptionlab.textAlignment = .left
        descriptionlab.font = UIFont.italicSystemFont(ofSize: 13)
        
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

















