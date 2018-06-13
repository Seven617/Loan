//
//  CollectionViewCell.swift
//  ScrollItemView
//
//  Created by 马超 on 16/7/22.
//  Copyright © 2016年 qikeyun. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    var cusView: UIView!
    let img = UIImageView()
    let name = UILabel()
    
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
        img.frame = CGRect(x: 15, y: 0, width:kWithRelIPhone6(width: 50) , height: kHeightRelIPhone6(height: 50))
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        addSubview(img)
        
        name.frame = CGRect(x: 10, y: img.frame.maxY+10, width:  kWithRelIPhone6(width: 60), height: kHeightRelIPhone6(height: 10))
        name.font = UIFont.italicSystemFont(ofSize: 13)
        name.textAlignment = .center
        addSubview(name)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
    }

}
