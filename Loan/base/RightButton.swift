//
//  RightButton.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/17.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class RightButton: UIButton {
    
    init(target: Any, action: Selector) {
        super.init(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        commonInit(target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(target: Any, action: Selector) {
        
        self.adjustsImageWhenHighlighted = false
//        self.setTitle("", for: UIControlState.normal)
//        self.setBackgroundImage(UIImage(named: "setting"), for: UIControlState.normal)
//        self.setBackgroundImage(UIImage(named: "setting"), for: UIControlState.highlighted)
//        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:-(self.width > 20 ? self.width - 20 : self.width))
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
