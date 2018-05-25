//
//  SampleCell.swift
//  PullToBounce
//
//  Created by Takuya Okamoto on 2015/08/12.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit

class SampleCell: UITableViewCell {
    
    let color = UIColor.lightBlue

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let iconMock = UIView()
        iconMock.backgroundColor = color
        iconMock.frame = CGRect(x: 16, y: 16, width: kWithRelIPhone6(width: 60), height: kHeightRelIPhone6(height:60))
        iconMock.layer.cornerRadius = 10
        self.addSubview(iconMock)

        let lineLeft:CGFloat = iconMock.frame.right + 16
        let lineMargin:CGFloat = 12
        
        let line1 = CGRect(x: lineLeft, y: 12 + lineMargin, width: kWithRelIPhone6(width: 100), height: kHeightRelIPhone6(height:6))
        let line2 = CGRect(x: lineLeft, y: line1.bottom + lineMargin, width: kWithRelIPhone6(width: 160), height: kHeightRelIPhone6(height:5))
        let line3 = CGRect(x: lineLeft, y: line2.bottom + lineMargin, width: kWithRelIPhone6(width: 180), height: kHeightRelIPhone6(height:5))
        addLine(line1)
        addLine(line2)
        addLine(line3)
        
        let sepalator = UIView()
        sepalator.frame = CGRect(x: 0, y: kHeightRelIPhone6(height:90) - 1, width: frame.width, height: 1)
        sepalator.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        self.addSubview(sepalator)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLine(_ frame:CGRect) {
        let line = UIView(frame:frame)
        line.layer.cornerRadius = frame.height / 2
        line.backgroundColor = color
        self.addSubview(line)
    }
}

















