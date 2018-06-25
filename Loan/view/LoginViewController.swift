//
//  LoginViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  登录

import UIKit
import MBProgressHUD

class LoginViewController: BaseViewController,UITextFieldDelegate {
    var navView = UIView()
    var mobilePhoneEdt = UITextField()
    var passwordEdt = UITextField()
    var getcodeBtn = UIButton()
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            getcodeBtn.setTitle("\(newValue)秒后重新获取", for: .normal)
            
            if newValue <= 0 {
                getcodeBtn.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LoginViewController.updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 60
                getcodeBtn.backgroundColor = UIColor.gray
                getcodeBtn.setTitleColor(UIColor.white, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                getcodeBtn.backgroundColor = UIColor.clear
                getcodeBtn.setTitleColor(UIColor.Main, for: .normal)
            }
            getcodeBtn.isEnabled = !newValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        initNavigationControlle()
        initView()
    }
    
    func initNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.Gray
        view.addSubview(navView)
        
        // 导航栏返回按钮
        let backBtn = BackButton(target: self, action: #selector(touchDownWithButton))
        backBtn.x = 20
        backBtn.centerY = topY + (navH - topY) / 2.0
        backBtn.setImage(UIImage(named: "back_black"), for: UIControlState.normal)
        backBtn.tag=1
        navView.addSubview(backBtn)
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "登录"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    func initView(){
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: kWithRelIPhone6(width: 70), height: kHeightRelIPhone6(height: 70)))
        img.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y: navH + kHeightRelIPhone6(height: 100))
        img.image  = UIImage(named:"AppIcon")
        img.layer.cornerRadius = 15.0
        img.clipsToBounds = true
        self.view.addSubview(img)
        
        mobilePhoneEdt = UITextField(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-kHeightRelIPhone6(height: 80), height: kHeightRelIPhone6(height: 60)))
        mobilePhoneEdt.center = CGPoint(x: SCREEN_WIDTH / 2,
                             y:img.frame.bottom+kHeightRelIPhone6(height: 80))
        //无边框
        mobilePhoneEdt.borderStyle = .none
        //字体
        mobilePhoneEdt.font=UIFont.systemFont(ofSize: 16)
        // 设置提示文字
        mobilePhoneEdt.placeholder = "请输入手机号"
        mobilePhoneEdt.delegate = self
        mobilePhoneEdt.textAlignment = .left
        mobilePhoneEdt.contentVerticalAlignment = .center
        //编辑时出现清除按钮
        mobilePhoneEdt.clearButtonMode = .whileEditing
        //数字键盘
        mobilePhoneEdt.keyboardType = .numbersAndPunctuation
        mobilePhoneEdt.tag=1
        // 放弃第一响应者
        //mobilePhoneEdt.resignFirstResponder()
        //next表示继续下一步
        mobilePhoneEdt.returnKeyType = .next
        self.view.addSubview(mobilePhoneEdt)
        
        let line1=UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-kHeightRelIPhone6(height: 40), height: kHeightRelIPhone6(height: 1)))
        line1.center = CGPoint(x: SCREEN_WIDTH / 2,
                              y:mobilePhoneEdt.frame.bottom)
        line1.backgroundColor=UIColor.Line
        self.view.addSubview(line1)
        
        passwordEdt = UITextField(frame: CGRect(x: kHeightRelIPhone6(height: 40), y: line1.frame.bottom, width: kHeightRelIPhone6(height: 180), height: kHeightRelIPhone6(height: 60)))
        //无边框
        passwordEdt.borderStyle = .none
        //字体
        passwordEdt.font=UIFont.systemFont(ofSize: 16)
        // 设置提示文字
        passwordEdt.placeholder = "请输入验证码"
        // 水平居左
        passwordEdt.textAlignment = .left
        // 垂直对齐
        passwordEdt.contentVerticalAlignment = .center
        passwordEdt.clearButtonMode = .whileEditing
        //next表示继续下一步
        passwordEdt.returnKeyType = .done
        //数字键盘
        passwordEdt.keyboardType = .numbersAndPunctuation
        passwordEdt.delegate=self
        passwordEdt.tag=2
        self.view.addSubview(passwordEdt)
        
        getcodeBtn = UIButton(frame: CGRect(x: passwordEdt.frame.right+kWithRelIPhone6(width: 10), y: line1.frame.bottom+kHeightRelIPhone6(height: 15), width: kWithRelIPhone6(width: 120), height: kHeightRelIPhone6(height: 30)))
        getcodeBtn.setTitle("点击获取验证码", for:.normal)
        getcodeBtn.addTarget(self,action:#selector(touchDownWithButton),for:.touchUpInside)
        getcodeBtn.tag=2
        getcodeBtn.setTitleColor(UIColor.Main, for: .normal) //普通状态下文字的颜色
        getcodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        getcodeBtn.layer.cornerRadius = 5
        getcodeBtn.layer.masksToBounds = true
        getcodeBtn.layer.borderWidth = 1
        getcodeBtn.layer.borderColor = UIColor.Main.cgColor
        self.view.addSubview(getcodeBtn)
        
        let line2=UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-kHeightRelIPhone6(height: 40), height: kHeightRelIPhone6(height: 1)))
        line2.center = CGPoint(x: SCREEN_WIDTH / 2,
                               y:passwordEdt.frame.bottom)
        line2.backgroundColor=UIColor.Line
        self.view.addSubview(line2)
        
        
        let LoginInBtn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.8, height: kHeightRelIPhone6(height: 40))))
        LoginInBtn.center = CGPoint(x: SCREEN_WIDTH / 2,
                                     y: line2.frame.maxY + kHeightRelIPhone6(height: 100))
        LoginInBtn.setTitle("登录", for:.normal)
        LoginInBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        LoginInBtn.backgroundColor = UIColor.Main
        LoginInBtn.addTarget(self,action:#selector(touchDownWithButton),for:.touchUpInside)
        LoginInBtn.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        LoginInBtn.layer.cornerRadius = 20.0
        LoginInBtn.clipsToBounds = true
        LoginInBtn.tag=3
        view.addSubview(LoginInBtn)
        
        let str = NSMutableAttributedString(string: "点击“确定”表示您同意《快便贷用户使用协议》")
        //更改字体
        if let aSize = UIFont(name: "HelveticaNeue-Bold", size: 15) {
            str.addAttribute(kCTFontAttributeName as NSAttributedStringKey, value: aSize, range: NSRange(location: 11, length: 11))
            //修改颜色
            str.addAttribute(kCTForegroundColorAttributeName as NSAttributedStringKey, value: UIColor.Main, range: NSRange(location: 11, length: 11))
        }
        let leb = UILabel(frame: CGRect(x: 0, y: LoginInBtn.frame.bottom+kHeightRelIPhone6(height: 20), width: SCREEN_WIDTH, height: kHeightRelIPhone6(height: 20)))
        leb.font = UIFont.systemFont(ofSize: 13)
        leb.textAlignment = .center
        leb.textColor = UIColor.Font3rd
        let labelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelClick))
        leb.addGestureRecognizer(labelTapGestureRecognizer)
        leb.isUserInteractionEnabled = true
        leb.attributedText = str
        view.addSubview(leb)
        
    
    }
    
    @objc func labelClick(){
        let protocolVC=ProtocolViewController()
        self.navigationController?.pushViewController(protocolVC, animated: true)
    }
    
    // 利用代理方法控制字符数量
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else{
            return true
        }
        //限制只能输入数字，不能输入特殊字符
        let length = string.lengthOfBytes(using: String.Encoding.utf8)
        for loopIndex in 0..<length {
            let char = (string as NSString).character(at: loopIndex)
            if char < 48 {return false }
            if char > 57 {return false }
        }
        let textLength = text.count + string.count - range.length
        if(textField.tag==1){
            return textLength<=11
        }else if(textField.tag==2){
            return textLength<=6
        }
        return true
    }
    
    //收键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.tag==1){
            //1这里是一种收键盘的方法,逼格稍微高点
            passwordEdt.becomeFirstResponder()
        }else if(textField.tag==2){
            textField.resignFirstResponder()
        }
        //view.endEditing(true)//2这是另外一种收键盘的方法,比较通用
        return true
    }
    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func touchDownWithButton(button:UIButton) {
        if (button.tag==1) {
        navigationController?.popViewController(animated: true)
        }
        if (button.tag==2) {
            self.view.endEditing(true)
            if(mobilePhoneEdt.text?.isEmpty)!{
                SYIToast.alert(withTitleBottom: "手机号不能为空!")
            }else if(isTelNumber(num: mobilePhoneEdt.text! as NSString)){
                isCounting = true
                authdata.request(mobile: mobilePhoneEdt.text!) { (auth) in
                }
            }
            else{
                SYIToast.alert(withTitleBottom: "手机号码格式不正确!")
            }
        }
        if (button.tag==3) {
            if(mobilePhoneEdt.text?.isEmpty)!{
                SYIToast.alert(withTitleBottom: "手机号不能为空!")
            }else if(passwordEdt.text?.isEmpty)!{
                SYIToast.alert(withTitleBottom: "验证码不能为空!")
            }else if(isTelNumber(num: mobilePhoneEdt.text! as NSString)){
                let hud = MBProgressHUD.showAdded(to: view, animated: true)
                hud.isUserInteractionEnabled=false
                //设置提示文字
                hud.label.text = "登录中..."
                LoginIndexResponse.request(name: mobilePhoneEdt.text!, code: passwordEdt.text!) { (login) in
                    if let login = login{
                        if login == 1{
                            self.getToken()
                        }else if login == 0{
                            SYIToast.alert(withTitleBottom: "登录失败!请检查验证码是否正确！")
                            MBProgressHUD.hide(for: self.view, animated: true)
                        }
                    }else {
                        print("网络错误")
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                }
            }
            else{
                SYIToast.alert(withTitleBottom: "手机号码格式不正确!")
            }
        }
    }
    func isTelNumber(num:NSString)->Bool
    {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }

    // 收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func getToken(){
        let userDefault = UserDefaults.standard
        logindata.request(name: mobilePhoneEdt.text!, code: passwordEdt.text!) { (login) in
            if let login = login {
                DispatchQueue.main.async {
                    //String类型存
                    userDefault.set((login.userId)!, forKey: "userId")
                    userDefault.set((login.token)!, forKey: "token")
                    userDefault.set(self.mobilePhoneEdt.text, forKey: "mobile")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                print("网络错误")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
