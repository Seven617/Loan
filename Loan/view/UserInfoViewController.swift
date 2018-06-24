//
//  UserInfoViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/21.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit
import MBProgressHUD

class UserInfoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var address:String?
    var idcard:String?
    var name:String?
    var province:String?
    var city:String?
    var area:String?
    var navView = UIView()
    var tableView:UITableView?
    var saveBtn = UIButton()
    var userid = UserDefaults.standard.string(forKey: "userId")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initData()
        initTableView()
        
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
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "个人资料"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
        
        saveBtn = UIButton(frame: (CGRect(x: 0, y: 0, width: SCREEN_WIDTH*0.8, height: kHeightRelIPhone6(height: 40))))
        saveBtn.center = CGPoint(x: SCREEN_WIDTH / 2,
                                     y: SCREEN_HEIGHT/2)
        saveBtn.setTitle("保存当前信息", for:.normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        saveBtn.backgroundColor = UIColor.Main
        saveBtn.addTarget(self,action:#selector(saveInfo),for:.touchUpInside)
        saveBtn.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        saveBtn.layer.cornerRadius = 20.0
        saveBtn.clipsToBounds = true
        view.addSubview(saveBtn)
    }
    
    @objc func saveInfo(){
        print(userid!)
//        print(self.name!)
//        print(self.idcard!)
        MBProgressHUD.showAdded(to: view, animated: true)
        if (self.name==nil){
            SYIToast.alert(withTitleBottom: "姓名不能为空！")
            MBProgressHUD.hide(for: self.view, animated: true)
        }else if (self.idcard==nil){
            SYIToast.alert(withTitleBottom: "身份证不能为空！")
            MBProgressHUD.hide(for: self.view, animated: true)
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute:
                {
                    InfoSaveIndexResponse.request(userId: self.userid!, name: self.name!, idCard: self.idcard!) { (saveinfo) in
                        if let saveinfo=saveinfo{
                            if saveinfo==1{
                                MBProgressHUD.hide(for: self.view, animated: true)
                                SYIToast.alert(withTitleBottom: "信息保存成功!")
                                self.navigationController?.popViewController(animated: true)
                            }else{
                                MBProgressHUD.hide(for: self.view, animated: true)
                                SYIToast.alert(withTitleBottom: "信息保存失败!")
                            }
                        }
                    }
            })
        }
    }
    
    func initData(){
        if (userid != nil){
            userinfodata.request(userId: userid!) { (userinfo) in
                if let userinfo=userinfo{
                    DispatchQueue.main.async {
                        self.name=userinfo.name
                        self.idcard=userinfo.idCard
                        //self.address=userinfo.locationCityName ?? "未设置"
                        self.tableView?.reloadData()
                    }
                }
            }
        }
    }
    
    func initTableView(){
        //创建表视图
        tableView = UITableView(frame: CGRect(x:0, y:navView.frame.maxY, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height*0.3), style:.grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        //        tableView!.bounces = false
        tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: kHeightRelIPhone6(height:20)))
        // 设置header
        tableView!.tableHeaderView = header
        view.addSubview(self.tableView!)
    }
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  kHeightRelIPhone6(height:50);
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            if(indexPath.row == 0){
                let defaults = UserDefaults.standard
                let mobile = defaults.string(forKey: "mobile")
                cell.textLabel?.text = "手机号"
                cell.detailTextLabel?.text = mobile
                cell.isUserInteractionEnabled = false
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            }else if(indexPath.row == 1){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textLabel?.text = "姓名"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                cell.detailTextLabel?.text = name ?? "未设置"
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            }else if(indexPath.row == 2){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textLabel?.text = "身份证"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                cell.detailTextLabel?.text = idcard ?? "未设置"
                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            }
//            else if(indexPath.row == 3){
//                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//                cell.textLabel?.text = "现居地址"
//                cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
//                cell.detailTextLabel?.text = address
//                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
//            }
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if(indexPath.row == 1){
            let upName = UpdateNameViewController()
            upName.str = name
            upName.testClosure = nameClosure;
            navigationController?.pushViewController(upName, animated: true)
        }else if(indexPath.row == 2){
            let idCadr = IDCardViewController()
            idCadr.str = idcard
            idCadr.testClosure = idCardClosure;
            navigationController?.pushViewController(idCadr, animated: true)
        }
//            else if(indexPath.row == 3){
//                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//                CZHAddressPickerView.areaPickerView(withProvince: province, city: city, area: area, areaBlock: {(_ province: String?, _ city: String?, _ area: String?) -> Void in
//                    self.province = province!
//                    self.city = city!
//                    self.area = area!
//                    let area = "\(province ?? "")\(city ?? "")\(area ?? "")"
//                    print(area)
//                    DispatchQueue.main.async {
//                        self.address = area
//                        tableView.reloadRows(at: [indexPath], with: .none)
//                    }
//                })
//            }
    }
    //定义一个带字符串参数的闭包
    func nameClosure(testStr:String)->Void{
        DispatchQueue.main.async {
            self.name = testStr
            let indexPath = NSIndexPath(row: 1, section:0)
            self.tableView?.reloadRows(at: [indexPath as IndexPath], with: .none)
        }
    }
    //定义一个带字符串参数的闭包
    func idCardClosure(testStr:String)->Void{
        DispatchQueue.main.async {
            self.idcard = testStr
            let indexPath = NSIndexPath(row: 2, section:0)
            self.tableView?.reloadRows(at: [indexPath as IndexPath], with: .none)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

