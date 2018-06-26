//
//  DetilViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/7.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  详情页

import UIKit
import Kingfisher
import MBProgressHUD

class DetilViewController: BaseViewController {
    var navView = UIView()
    var titleLabel = UILabel()
//    var navtitle:String!
    var nameLab:String?
    var productId:Int!
    var goH5Btn = UIButton()
    //关键提示
    var CommentString : String!="加载中"
    //所需材料
    var OtherInfoString : String!="加载中"
    // 申请条件
    var ApplyConditionString : String!="加载中"
    //产品介绍
    var DescriptionString : String!="加载中"
    //link连接
    var link:String!="加载中"
    //费率
    var detilrates:String!="加载中"
    //费率类型
    var rateUnit:String!="参考月费率"
    //额度
    var detilquota:String!="加载中"
    //logo
    var detillogo:String!="加载中"
    //跳转到下个界面的标志
    var nextVC : Int!
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
        ifLogin()
        getDetil()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        getInfoLab()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled=false
        //设置提示文字
        hud.label.text = "loading..."
        view.ly_startLoading()
    }
    func intiNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.Main
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        backBtn.setImage(UIImage(named: "back_white"), for: UIControlState.normal)
        navView.addSubview(backBtn)
        // 导航栏标题
        titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = nameLab
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    func ifLogin(){
        let defaults = UserDefaults.standard
        let userid = defaults.string(forKey: "userId")
        let token = defaults.string(forKey: "token")
//        print(userid)
        if (userid != nil)&&(token != nil){
            CheckTokenIndexResponse.request(token: token!, userId: userid!) { (checktoken) in
                if let checktoken = checktoken{
                    print(checktoken)
                    DispatchQueue.main.async {
                        if checktoken == 0{
                            self.nextVC=0
                        }else if checktoken == 1{
                            self.nextVC=1
                        }
                    }
                }
            }
        }else {
            nextVC=0
        }
    }
    
    func getDetil(){
        detildata.request(id: productId) { (detil) in
            if let detil = detil {
                self.nameLab=detil.name
                self.CommentString=detil.comment
                self.OtherInfoString=detil.otherInfo
                self.ApplyConditionString=detil.applyCondition
                self.DescriptionString=detil.description
                self.link=detil.link
                self.detillogo=detil.logo
                self.detilquota=("\((detil.minAmount as! Float)/1000) ~ \((detil.maxAmount as! Float)/1000)万")
                self.detilrates=("\(detil.minRate.description!) %")
                let a:Int = detil.rateUnit as! Int
                var time:String?=nil
                switch(a)
                {
                case 1 :
                    //要執行動作
                    time="年"
                    break
                case 2 :
                    //要執行動作
                    time="月"
                    break
                case 3 :
                    //要執行動作
                    time="日"
                    break
                case 4 :
                    //要執行動作
                    time="笔"
                    break
                default :
                    //要執行動作
                    break
                }
                self.rateUnit = "参考"+time!+"费率"
                MBProgressHUD.hide(for: self.view, animated: true)
                self.intiNavigationControlle()
                self.getInfoLab()
               
            }else{
                print("网络错误")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
        }
    }
    
    //关键提示
    private func getInfoLab(){
        
        let topHead=UIView(frame: CGRect(x:0, y:navView.frame.bottom,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 130)))
        topHead.backgroundColor=UIColor.Main
        self.view.addSubview(topHead)
        
        let img=UIImageView(frame: CGRect(x:SCREEN_WIDTH/6 - kWithRelIPhone6(width: 25), y: kHeightRelIPhone6(height: 10), width: kWithRelIPhone6(width: 60), height: kHeightRelIPhone6(height:60)))
        let url = URL(string: detillogo)
        img.kf.indicatorType = .activity
        let placeholderImage = UIImage(named: "AppIcon")
        img.kf.setImage(with: url ,placeholder: placeholderImage)
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        topHead.addSubview(img)
        
        let name = UILabel(frame: CGRect(x:img.frame.right+kWithRelIPhone6(width: 10), y:  kHeightRelIPhone6(height: (img.frame.height+10)/2), width: kWithRelIPhone6(width: 100), height: kHeightRelIPhone6(height:10)))
        name.font = UIFont.systemFont(ofSize: 18)
        name.textColor=UIColor.white
        name.textAlignment = .left
        name.text = nameLab ?? "loading..."
        let nametext:String = name.text!//获取label的text
        let nameattributes = [kCTFontAttributeName: name.font!]//计算label的字体
        name.frame = labelSize(text: nametext, attributes: nameattributes)//调用计算label宽高的方法
        name.mj_origin = CGPoint(x: img.frame.right+kWithRelIPhone6(width: 10), y:kHeightRelIPhone6(height: img.frame.height/2))
        topHead.addSubview(name)
        
        
        let quota = UILabel(frame: CGRect(x:0, y: img.frame.bottom + kHeightRelIPhone6(height: 10), width: SCREEN_WIDTH/2, height: kHeightRelIPhone6(height:15)))
        quota.font = UIFont.systemFont(ofSize: 14)
        quota.textColor=UIColor.white
        quota.textAlignment = .center
        quota.text = detilquota
        topHead.addSubview(quota)
        
        let quotalab = UILabel(frame: CGRect(x:0, y: quota.frame.bottom + kHeightRelIPhone6(height: 10), width: SCREEN_WIDTH/2, height: kHeightRelIPhone6(height:15)))
        quotalab.font = UIFont.systemFont(ofSize: 14)
        quotalab.textColor=UIColor.white
        quotalab.textAlignment = .center
        quotalab.text = "额度"
        topHead.addSubview(quotalab)
        
        let rates = UILabel(frame: CGRect(x:quota.frame.right, y: img.frame.bottom + kHeightRelIPhone6(height: 10), width: SCREEN_WIDTH/2, height: kHeightRelIPhone6(height:15)))
        rates.font = UIFont.systemFont(ofSize: 14)
        rates.textColor=UIColor.white
        rates.textAlignment = .center
        rates.text = detilrates
        topHead.addSubview(rates)
        
        let rateslab = UILabel(frame: CGRect(x:quotalab.frame.right, y: rates.frame.bottom + kHeightRelIPhone6(height: 10), width: SCREEN_WIDTH/2, height: kHeightRelIPhone6(height:15)))
        rateslab.font = UIFont.systemFont(ofSize: 14)
        rateslab.textColor=UIColor.white
        rateslab.textAlignment = .center
        rateslab.text = rateUnit
        topHead.addSubview(rateslab)
        
        let OutView = UIView(frame: CGRect(x:0, y:topHead.frame.bottom ,width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 350)))
        
        let commentIcon = UIImageView(frame: CGRect(x:20, y:kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 5), height:kHeightRelIPhone6(height: 20)))
        commentIcon.backgroundColor = UIColor.Main
        OutView.addSubview(commentIcon)
        
        let commentLab = UILabel(frame: CGRect(x:commentIcon.frame.maxX+10, y:kHeightRelIPhone6(height: 10) ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        commentLab.text = "关键提示"
        commentLab.textColor = UIColor.Font2nd
        commentLab.font = UIFont.systemFont(ofSize: 14)
        OutView.addSubview(commentLab)
        OutView.backgroundColor = UIColor.white
        
        let Comment = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        Comment.text = CommentString
        Comment.numberOfLines=0;
//        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        Comment.textAlignment = NSTextAlignment.left
        Comment.adjustsFontSizeToFitWidth = true
        Comment.font = UIFont.systemFont(ofSize: 13)
        
        let commenttext:String = Comment.text!//获取label的text
        let commentattributes = [kCTFontAttributeName: Comment.font!]//计算label的字体
        Comment.frame = labelSize(text: commenttext, attributes: commentattributes)//调用计算label宽高的方法
        Comment.mj_origin = CGPoint(x: commentIcon.frame.maxX+10, y:commentIcon.frame.maxY+kHeightRelIPhone6(height: 10))
        OutView.addSubview(Comment)
        
        let line1 = UIView(frame: CGRect(x: 0, y: Comment.frame.maxY+kHeightRelIPhone6(height: 10), width: kWithRelIPhone6(width: SCREEN_WIDTH), height: kHeightRelIPhone6(height:1)))
        line1.backgroundColor=UIColor.Gray
        OutView.addSubview(line1)
        
        let otherInfoIcon = UIImageView(frame: CGRect(x:20, y:line1.frame.maxY+kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 5), height:kHeightRelIPhone6(height: 20)))
        otherInfoIcon.backgroundColor = UIColor.Main
        OutView.addSubview(otherInfoIcon)
        
        let otherInfoLab = UILabel(frame: CGRect(x:otherInfoIcon.frame.maxX+10, y:line1.frame.maxY+kHeightRelIPhone6(height: 10) ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        otherInfoLab.text = "所需材料"
        otherInfoLab.textColor = UIColor.Font2nd
        otherInfoLab.font = UIFont.systemFont(ofSize: 14)
        OutView.addSubview(otherInfoLab)
        
        let OtherInfo = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        OtherInfo.text = OtherInfoString
        OtherInfo.textColor = UIColor.MainPress
        OtherInfo.numberOfLines=0;
        //        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        OtherInfo.textAlignment = NSTextAlignment.left
        OtherInfo.adjustsFontSizeToFitWidth = true
        OtherInfo.font = UIFont.systemFont(ofSize: 13)
        
        let otherInfotext:String = OtherInfo.text!//获取label的text
        let otherInfoattributes = [kCTFontAttributeName: OtherInfo.font!]//计算label的字体
        OtherInfo.frame = labelSize(text: otherInfotext, attributes: otherInfoattributes)//调用计算label宽高的方法
        OtherInfo.mj_origin = CGPoint(x: otherInfoIcon.frame.maxX+10, y:otherInfoIcon.frame.maxY+kHeightRelIPhone6(height: 10))
        OutView.addSubview(OtherInfo)
        
        
        let line2 = UIView(frame: CGRect(x: 0, y: OtherInfo.frame.maxY+kHeightRelIPhone6(height: 10), width: kWithRelIPhone6(width: SCREEN_WIDTH), height: kHeightRelIPhone6(height:1)))
        line2.backgroundColor=UIColor.Gray
        OutView.addSubview(line2)
        
        let applyConditionIcon = UIImageView(frame: CGRect(x:20, y:line2.frame.maxY+kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 5), height:kHeightRelIPhone6(height: 20)))
        applyConditionIcon.backgroundColor = UIColor.Main
        OutView.addSubview(applyConditionIcon)
        
        let applyConditionLab = UILabel(frame: CGRect(x:applyConditionIcon.frame.maxX+10, y:line2.frame.maxY+kHeightRelIPhone6(height: 10) ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        applyConditionLab.text = "申请条件"
        applyConditionLab.textColor = UIColor.Font2nd
        applyConditionLab.font = UIFont.systemFont(ofSize: 14)
        OutView.addSubview(applyConditionLab)
        
        let ApplyCondition = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        ApplyCondition.text = ApplyConditionString
        ApplyCondition.numberOfLines=0;
        //        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        ApplyCondition.textAlignment = NSTextAlignment.left
        ApplyCondition.adjustsFontSizeToFitWidth = true
        ApplyCondition.font = UIFont.systemFont(ofSize: 13)
        
        let applyConditiontext:String = ApplyCondition.text!//获取label的text
        let applyConditionattributes = [kCTFontAttributeName: ApplyCondition.font!]//计算label的字体
        ApplyCondition.frame = labelSize(text: applyConditiontext, attributes: applyConditionattributes)//调用计算label宽高的方法
        ApplyCondition.mj_origin = CGPoint(x: applyConditionIcon.frame.maxX+10, y:applyConditionIcon.frame.maxY+kHeightRelIPhone6(height: 10))
        OutView.addSubview(ApplyCondition)
        
        let line3 = UIView(frame: CGRect(x: 0, y: ApplyCondition.frame.maxY+kHeightRelIPhone6(height: 10), width: kWithRelIPhone6(width: SCREEN_WIDTH), height: kHeightRelIPhone6(height:1)))
        line3.backgroundColor=UIColor.Gray
        OutView.addSubview(line3)
        
        
        let descriptionIcon = UIImageView(frame: CGRect(x:20, y:line3.frame.maxY+kHeightRelIPhone6(height: 10) ,width: kWithRelIPhone6(width: 5), height:kHeightRelIPhone6(height: 20)))
        descriptionIcon.backgroundColor = UIColor.Main
        OutView.addSubview(descriptionIcon)
        
        let descriptionLab = UILabel(frame: CGRect(x:descriptionIcon.frame.maxX+10, y:line3.frame.maxY+kHeightRelIPhone6(height: 10) ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 20)))
        descriptionLab.text = "产品介绍"
        descriptionLab.textColor = UIColor.Font2nd
        descriptionLab.font = UIFont.systemFont(ofSize: 14)
        OutView.addSubview(descriptionLab)
        
        let Description = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        Description.text = DescriptionString
        Description.numberOfLines=0;
        //        Comment.lineBreakMode = NSLineBreakMode.byCharWrapping  //自动折行
        Description.textAlignment = NSTextAlignment.left
        Description.adjustsFontSizeToFitWidth = true
        Description.font = UIFont.systemFont(ofSize: 13)
        
        let descriptiontext:String = Description.text!//获取label的text
        let descriptionattributes = [kCTFontAttributeName: Description.font!]//计算label的字体
        Description.frame = labelSize(text: descriptiontext, attributes: descriptionattributes)//调用计算label宽高的方法
        Description.mj_origin = CGPoint(x: descriptionIcon.frame.maxX+10, y:descriptionIcon.frame.maxY+kHeightRelIPhone6(height: 10))
        OutView.addSubview(Description)
        
        OutView.backgroundColor = UIColor.white
        self.view.addSubview(OutView)
        
        goH5Btn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.8, height: kHeightRelIPhone6(height: 40))))
        goH5Btn.center = CGPoint(x: SCREEN_WIDTH / 2,
                                 y: SCREEN_HEIGHT*0.9)
        goH5Btn.setTitle("立即贷款", for:.normal)
        goH5Btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        goH5Btn.backgroundColor = UIColor.Main
        goH5Btn.addTarget(self,action:#selector(gotoh5),for:.touchUpInside)
        goH5Btn.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        goH5Btn.layer.cornerRadius = 20.0
        goH5Btn.clipsToBounds = true
        self.view.addSubview(goH5Btn)
        
        // 初始化动画的持续时间，类型和子类型
        let transition = CATransition()
        transition.duration = 0
        transition.type = kCATransitionFade
        // 执行刚才添加好的动画
        self.view.layer.add(transition, forKey: nil)
    }
    
    @objc func gotoh5(){
        let loginVC=LoginViewController()
        let web = WebViewController()
        web.url=link
        web.webtitle=nameLab
        guard nextVC==0 else {
            self.navigationController?.pushViewController(web, animated: true)
            return
        }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}
