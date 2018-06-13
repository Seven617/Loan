//
//  DetilViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/7.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  详情页

import UIKit

class DetilViewController: BaseViewController {
    var navView = UIView()
    var titleLabel = UILabel()
    var navtitle:String!
    var productId:Int!
    //关键提示
    var CommentString : String!="加载中"
    //所需材料
    var OtherInfoString : String!="加载中"
    // 申请条件
    var ApplyConditionString : String!="加载中"
    //产品介绍
    var DescriptionString : String!="加载中"
    //link连接
    var link:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
//        print("传过来的ProductId是:\(productId!)")
        getDetil()
        //关键提示
        getInfoLab()
    }
    func intiNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.lightGray
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        backBtn.setImage(UIImage(named: "back_black"), for: UIControlState.normal)
        navView.addSubview(backBtn)
        // 导航栏标题
        titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = navtitle
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    func getDetil(){
        detildata.request(id: productId) { (detil) in
            if let detil = detil {
                self.CommentString=detil.comment
                self.OtherInfoString=detil.otherInfo
                self.ApplyConditionString=detil.applyCondition
                self.DescriptionString=detil.description
                self.link=detil.link
                self.getInfoLab()
            }else{
                print("网络错误")
            }  
        }
    }
    //关键提示
    private func getInfoLab(){
        let OutView = UIView(frame: CGRect(x:0, y:navView.frame.maxY ,width: SCREEN_WIDTH, height:SCREEN_HEIGHT*0.7))
        let commentIcon = UIImageView(frame: CGRect(x:20, y:25 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        commentIcon.backgroundColor = UIColor.Main
        OutView.addSubview(commentIcon)
        
        let commentLab = UILabel(frame: CGRect(x:commentIcon.frame.maxX+10, y:25 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        commentLab.text = "关键提示"
        commentLab.textColor = UIColor.Font2nd
        commentLab.font = UIFont.boldSystemFont(ofSize: 13)
        OutView.addSubview(commentLab)
        OutView.backgroundColor = UIColor.white
        
        let Comment = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        Comment.text = CommentString
        Comment.numberOfLines=0;
//        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        Comment.textAlignment = NSTextAlignment.left
        Comment.adjustsFontSizeToFitWidth = true
        Comment.font = UIFont.boldSystemFont(ofSize: 15)
        
        let commenttext:String = Comment.text!//获取label的text
        let commentattributes = [kCTFontAttributeName: Comment.font!]//计算label的字体
        Comment.frame = labelSize(text: commenttext, attributes: commentattributes)//调用计算label宽高的方法
        Comment.origin = CGPoint(x: commentIcon.frame.maxX+10, y:commentIcon.frame.maxY+10)
        OutView.addSubview(Comment)
        
        let line1 = UIView(frame: CGRect(x: 0, y: Comment.frame.maxY+10, width: kWithRelIPhone6(width: SCREEN_WIDTH), height: kHeightRelIPhone6(height:1)))
        line1.backgroundColor=UIColor.Gray
        OutView.addSubview(line1)
        
        let otherInfoIcon = UIImageView(frame: CGRect(x:20, y:line1.frame.maxY+10 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        otherInfoIcon.backgroundColor = UIColor.Main
        OutView.addSubview(otherInfoIcon)
        
        let otherInfoLab = UILabel(frame: CGRect(x:otherInfoIcon.frame.maxX+10, y:line1.frame.maxY+10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        otherInfoLab.text = "所需材料"
        otherInfoLab.textColor = UIColor.Font2nd
        otherInfoLab.font = UIFont.boldSystemFont(ofSize: 13)
        OutView.addSubview(otherInfoLab)
        
        let OtherInfo = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        OtherInfo.text = OtherInfoString
        OtherInfo.textColor = UIColor.MainPress
        OtherInfo.numberOfLines=0;
        //        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        OtherInfo.textAlignment = NSTextAlignment.left
        OtherInfo.adjustsFontSizeToFitWidth = true
        OtherInfo.font = UIFont.boldSystemFont(ofSize: 15)
        
        let otherInfotext:String = OtherInfo.text!//获取label的text
        let otherInfoattributes = [kCTFontAttributeName: OtherInfo.font!]//计算label的字体
        OtherInfo.frame = labelSize(text: otherInfotext, attributes: otherInfoattributes)//调用计算label宽高的方法
        OtherInfo.origin = CGPoint(x: otherInfoIcon.frame.maxX+10, y:otherInfoIcon.frame.maxY+10)
        OutView.addSubview(OtherInfo)
        
        
        let line2 = UIView(frame: CGRect(x: 0, y: OtherInfo.frame.maxY+10, width: kWithRelIPhone6(width: SCREEN_WIDTH), height: kHeightRelIPhone6(height:1)))
        line2.backgroundColor=UIColor.Gray
        OutView.addSubview(line2)
        
        let applyConditionIcon = UIImageView(frame: CGRect(x:20, y:line2.frame.maxY+10 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        applyConditionIcon.backgroundColor = UIColor.Main
        OutView.addSubview(applyConditionIcon)
        
        let applyConditionLab = UILabel(frame: CGRect(x:applyConditionIcon.frame.maxX+10, y:line2.frame.maxY+10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        applyConditionLab.text = "申请条件"
        applyConditionLab.textColor = UIColor.Font2nd
        applyConditionLab.font = UIFont.boldSystemFont(ofSize: 13)
        OutView.addSubview(applyConditionLab)
        
        let ApplyCondition = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        ApplyCondition.text = ApplyConditionString
        ApplyCondition.numberOfLines=0;
        //        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        ApplyCondition.textAlignment = NSTextAlignment.left
        ApplyCondition.adjustsFontSizeToFitWidth = true
        ApplyCondition.font = UIFont.boldSystemFont(ofSize: 15)
        
        let applyConditiontext:String = ApplyCondition.text!//获取label的text
        let applyConditionattributes = [kCTFontAttributeName: ApplyCondition.font!]//计算label的字体
        ApplyCondition.frame = labelSize(text: applyConditiontext, attributes: applyConditionattributes)//调用计算label宽高的方法
        ApplyCondition.origin = CGPoint(x: applyConditionIcon.frame.maxX+10, y:applyConditionIcon.frame.maxY+10)
        OutView.addSubview(ApplyCondition)
        
        let line3 = UIView(frame: CGRect(x: 0, y: ApplyCondition.frame.maxY+10, width: kWithRelIPhone6(width: SCREEN_WIDTH), height: kHeightRelIPhone6(height:1)))
        line3.backgroundColor=UIColor.Gray
        OutView.addSubview(line3)
        
        
        let descriptionIcon = UIImageView(frame: CGRect(x:20, y:line3.frame.maxY+10 ,width: 5, height:kHeightRelIPhone6(height: 20)))
        descriptionIcon.backgroundColor = UIColor.Main
        OutView.addSubview(descriptionIcon)
        
        let descriptionLab = UILabel(frame: CGRect(x:descriptionIcon.frame.maxX+10, y:line3.frame.maxY+10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        descriptionLab.text = "产品介绍"
        descriptionLab.textColor = UIColor.Font2nd
        descriptionLab.font = UIFont.boldSystemFont(ofSize: 13)
        OutView.addSubview(descriptionLab)
        
        let Description = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        Description.text = DescriptionString
        Description.numberOfLines=0;
        //        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        Description.textAlignment = NSTextAlignment.left
        Description.adjustsFontSizeToFitWidth = true
        Description.font = UIFont.boldSystemFont(ofSize: 15)
        
        let descriptiontext:String = Description.text!//获取label的text
        let descriptionattributes = [kCTFontAttributeName: Description.font!]//计算label的字体
        Description.frame = labelSize(text: descriptiontext, attributes: descriptionattributes)//调用计算label宽高的方法
        Description.origin = CGPoint(x: descriptionIcon.frame.maxX+10, y:descriptionIcon.frame.maxY+10)
        OutView.addSubview(Description)
        
        OutView.backgroundColor = UIColor.white
        self.view.addSubview(OutView)
        
        let goH5Btn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.8, height: kHeightRelIPhone6(height: 40))))
        goH5Btn.center = CGPoint(x: SCREEN_WIDTH / 2,
                                 y: SCREEN_HEIGHT*0.9)
        goH5Btn.setTitle("立即贷款", for:.normal)
        goH5Btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        goH5Btn.backgroundColor = UIColor.Main
        goH5Btn.addTarget(self,action:#selector(gotoh5),for:.touchUpInside)
        goH5Btn.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        goH5Btn.layer.cornerRadius = 20.0
        goH5Btn.clipsToBounds = true
        self.view.addSubview(goH5Btn)
    }
    
    @objc func gotoh5(){
        let web = WebViewController()
        web.url=link
        web.webtitle=navtitle
        self.navigationController?.pushViewController(web, animated: true)
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
    
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil {
            UIApplication.shared.statusBarStyle = .lightContent
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
}
