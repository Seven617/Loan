//
//  UserInfoViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/21.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var address = "未设置"
    var idcard = "未设置"
    var name = "Seven617"
    var province = ""
    var city = ""
    var area = ""
    var navView = UIView()
    var tableView:UITableView?
    var editable:Bool = false
    var rightBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initTableView()
        // Do any additional setup after loading the view.
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
        
        // 创建右边按钮
        rightBtn = RightButton(target: self, action: #selector(goEditting))
        rightBtn.x = SCREEN_WIDTH - 60
        rightBtn.centerY = topY + (navH - topY) / 2.0
        rightBtn.setTitle("编辑",for:.normal)//普通状态下文字
        rightBtn.setTitleColor(UIColor.blue, for: .normal) //普通状态下文字的颜色
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        navView.addSubview(rightBtn)
    }
    //设置可编辑状态
    @objc func goEditting(){
        if(editable == false){
            editable = true
            rightBtn.setTitle("保存",for:.normal)//普通状态下文字
            rightBtn.setTitleColor(UIColor.green, for: .normal) //普通状态下文字的颜色
        }else{
            editable = false
            rightBtn.setTitle("编辑",for:.normal)//普通状态下文字
            rightBtn.setTitleColor(UIColor.blue, for: .normal) //普通状态下文字的颜色
            //这里做个人信息回传服务器
        }
    }
    func initTableView(){
        //创建表视图
        tableView = UITableView(frame: CGRect(x:0, y:navView.frame.maxY, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height), style:.grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        //        tableView!.bounces = false
        self.automaticallyAdjustsScrollViewInsets = false
        tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 20))
        // 设置header
        tableView!.tableHeaderView = header
        view.addSubview(self.tableView!)
    }
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            if(indexPath.row == 0){
                cell.textLabel?.text = "手机号"
                cell.detailTextLabel?.text = "188****0800"
                cell.isUserInteractionEnabled = false
            }else if(indexPath.row == 1){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textLabel?.text = "姓名"
                cell.detailTextLabel?.text = name
            }else if(indexPath.row == 2){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textLabel?.text = "身份证"
                cell.detailTextLabel?.text = idcard
            }else if(indexPath.row == 3){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                cell.textLabel?.text = "现居地址"
                cell.detailTextLabel?.text = address
            }
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if(editable){
            if(indexPath.row == 1){
                let upName:UpdateNameViewController = UpdateNameViewController()
                upName.str = name
                upName.testClosure = nameClosure;
                navigationController?.pushViewController(upName, animated: true)
            }else if(indexPath.row == 2){
                let idCadr:IDCardViewController = IDCardViewController()
                idCadr.str = idcard
                idCadr.testClosure = idCardClosure;
                navigationController?.pushViewController(idCadr, animated: true)
            }else if(indexPath.row == 3){
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                CZHAddressPickerView.areaPickerView(withProvince: province, city: city, area: area, areaBlock: {(_ province: String?, _ city: String?, _ area: String?) -> Void in
                    self.province = province!
                    self.city = city!
                    self.area = area!
                    let area = "\(province ?? "")\(city ?? "")\(area ?? "")"
                    print(area)
                    DispatchQueue.main.async {
                        self.address = area
                        tableView.reloadRows(at: [indexPath], with: .none)
                    }
                })
            }
        }
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
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    @objc func backBtnClicked() {
        print("H1自定义返回按钮点击")
        navigationController?.popViewController(animated: true)
    }
}

