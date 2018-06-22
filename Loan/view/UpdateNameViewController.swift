//
//  UpdateNameViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/22.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

typealias sendValueClosure=(_ string:String)->Void

class UpdateNameViewController: BaseViewController,UITextFieldDelegate {
    var str:String?
    var nameField:UITextField!
    var SaveNameBtn:UIButton!
    //声明一个闭包
    var testClosure:sendValueClosure?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initView()
    }
    func intiNavigationControlle(){
        // 自定义导航栏视图
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.lightGray
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        backBtn.setImage(UIImage(named: "back_black"), for: UIControlState.normal)
        navView.addSubview(backBtn)
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "修改昵称"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    func initView(){
        //创建一个文本显示lab
        nameField = UITextField(frame:CGRect(x:0,y: navH+20,width: SCREEN_WIDTH,height: 50));
        nameField.backgroundColor = UIColor.white
        nameField.textAlignment = .left
        nameField.placeholder = "请输入姓名"
        nameField.borderStyle = UITextBorderStyle.none
        nameField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        nameField.text = str
        nameField.delegate = self
//        nameField.addTarget(self,action:#selector(clearname), for: .editingChanged)
        view.addSubview(nameField);
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        nameField.leftView = paddingView
        nameField.leftViewMode = .always
        
        //创建一个保存按钮
        SaveNameBtn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.5, height: 40)))
        SaveNameBtn.center = CGPoint(x: SCREEN_WIDTH / 2,y: nameField.frame.maxY + 50)
        SaveNameBtn.setTitle("保存", for:.normal)
        SaveNameBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        SaveNameBtn.backgroundColor = UIColor.Main
        SaveNameBtn.addTarget(self,action:#selector(saveBtnClicked),for:.touchUpInside)
        SaveNameBtn.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        SaveNameBtn.setTitleColor(UIColor.gray, for: .disabled) //禁用状态下文字的颜色
        SaveNameBtn.layer.cornerRadius = 20.0
        SaveNameBtn.clipsToBounds = true
        view.addSubview(SaveNameBtn)
    }
    // 利用代理方法控制字符数量
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else{
            return true
        }
        let textLength = text.count + string.count - range.length
        return textLength<=8
    }
//    @objc func clearname(textField: UITextField) {
//        if(nameField.text == str){
//            print("不能点击")
//        }else{
//            print("可以点击")
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveBtnClicked() {
        /**
         先判断闭包是否存在，然后再调用
         */
        if (testClosure != nil){
            testClosure!(nameField.text!)
        }
        navigationController?.popViewController(animated: true)
    }
}

