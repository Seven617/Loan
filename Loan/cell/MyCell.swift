//
//  MyCell.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    var cellImage:UIImageView!
    var cellTitle:UILabel!
    var cellText:UILabel!
    var cellDate:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // 重写init方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 创建图片:cellImage，并添加到cell上
        let imageX: CGFloat = 10
        let imageY: CGFloat = 10
        let imageWidth: CGFloat = 100
        let imageHeight: CGFloat = 100
        cellImage = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight))
        cellImage.backgroundColor = UIColor.red
        self.addSubview(cellImage)
        
        // 创建标题:cellTitle，并添加到cell上
        let titleX: CGFloat = cellImage.frame.maxX + 10
        let titleY: CGFloat = 10
        let titleWidth: CGFloat = self.frame.size.width - titleX
        let titleHeight: CGFloat = 20
        cellTitle = UILabel(frame: CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight))
        cellTitle.text = "cell的标题"
        cellTitle.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(cellTitle)
        
        // 创建内容:cellText，并添加到cell上
        let textX: CGFloat = cellTitle.frame.origin.x
        let textY: CGFloat = cellTitle.frame.maxY + 10
        let textWidth: CGFloat = titleWidth
        let textHeight: CGFloat = 50
        cellText = UILabel(frame: CGRect(x: textX, y: textY, width: textWidth, height: textHeight))
        cellText.text = "cell的内容xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        cellText.font = UIFont.systemFont(ofSize: 12)
        cellText.numberOfLines = 0
        self.addSubview(cellText)
        
        // 创建日期:cellDate，并添加到cell上
        let dateX: CGFloat = 10
        let dateY: CGFloat = cellImage.frame.maxY + 10
        let dateWidth: CGFloat = self.frame.size.width - dateX*2
        let dateHeight: CGFloat = 20
        cellDate = UILabel(frame: CGRect(x: dateX, y: dateY, width: dateWidth, height: dateHeight))
        cellDate.text = "日期:2016-06-30"
        cellDate.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(cellDate)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
