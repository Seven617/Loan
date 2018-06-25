//
//  IDCardViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/22.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

typealias idCardClosure=(_ string:String)->Void
class IDCardViewController: BaseViewController,UITextFieldDelegate {
    var str:String?
    var idCardField:OttoTextField!
    var SaveNameBtn:UIButton!
    //声明一个闭包
    var testClosure:idCardClosure?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initView()
        // Do any additional setup after loading the view.
    }
    func intiNavigationControlle(){
        // 自定义导航栏视图
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.Gray
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        backBtn.setImage(UIImage(named: "back_black"), for: UIControlState.normal)
        navView.addSubview(backBtn)
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "修改身份证"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    func initView(){
        //创建一个文本显示lab
        idCardField = OttoTextField(frame:CGRect(x:0,y: navH+20,width: SCREEN_WIDTH,height: 50));
        idCardField.backgroundColor = UIColor.white
        idCardField.textAlignment = .left
        idCardField.placeholder = "请输入身份证号码"
        idCardField.borderStyle = UITextBorderStyle.none
        idCardField.keyboardType = .numberPad
        idCardField.numberKeyboardType = .certNo
        idCardField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        idCardField.text = str
        idCardField.delegate = self
        idCardField.inputAccessoryView = addToolbar()
        view.addSubview(idCardField);
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        idCardField.leftView = paddingView
        idCardField.leftViewMode = .always
        
        
        //创建一个保存按钮
        SaveNameBtn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.5, height: 40)))
        SaveNameBtn.center = CGPoint(x: SCREEN_WIDTH / 2,y: idCardField.frame.maxY + 50)
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
    func addToolbar() -> UIToolbar? {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 35))
        toolbar.tintColor = UIColor.blue
        toolbar.backgroundColor = UIColor.gray
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let bar = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(self.textFieldShouldReturn))
        toolbar.items =  [space, bar]
        return toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idCardField.resignFirstResponder()
        return true
    }
//    // 利用代理方法控制字符数量
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else{
//            return true
//        }
//        let textLength = text.count + string.count - range.length
//        return textLength<=18
//    }
    
    // 收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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
            testClosure!(idCardField.text!)
        }
        navigationController?.popViewController(animated: true)
    }
}
