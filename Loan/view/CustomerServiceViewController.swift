//
//  CustomerServiceViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  客服界面

import UIKit

class CustomerServiceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView:UITableView?
    var line = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initView()
        initTableView()
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
        titleLabel.text = "联系客服"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
        
    }
    
    func initView(){
        let img = UIImageView(frame: CGRect(x: 20, y: navH+20, width: kWithRelIPhone6(width: 25), height: kHeightRelIPhone6(height: 25)))
        img.image  = UIImage(named:"kefu")
        img.layer.cornerRadius = 15.0
        img.clipsToBounds = true
        view.addSubview(img)
        
        let lab1 = UILabel(frame: CGRect(x: img.frame.maxX+10, y: navH+20, width: kWithRelIPhone6(width: 200), height: kHeightRelIPhone6(height: 25)))
        lab1.text = "客服帮助"
        lab1.textColor = UIColor.Font2nd
        view.addSubview(lab1)
        
        line = UIView(frame: CGRect(x: 0, y: lab1.frame.maxY+15, width: SCREEN_WIDTH, height: 1))
        line.backgroundColor = UIColor.Line
        view.addSubview(line)
    }
    
    func initTableView(){
        //创建表视图
        tableView = UITableView(frame: CGRect(x:0, y:line.frame.maxY+10, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height), style:.plain)
        tableView!.delegate = self
        tableView!.dataSource = self
//        tableView!.bounces = false
        self.automaticallyAdjustsScrollViewInsets = false
        tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        tableView!.separatorStyle = .none
        tableView?.backgroundColor = UIColor.clear
        view.addSubview(self.tableView!)
    }
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return kHeightRelIPhone6(height: 50);
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.backgroundColor = UIColor.clear
            if(indexPath.row == 0){
                cell.textLabel?.text = "服务时间"
                cell.detailTextLabel?.text = "9:00-17:00(工作日)"
            }else if(indexPath.row == 1){
                cell.textLabel?.text = "联系邮箱"
                cell.detailTextLabel?.text = "3124703964@qq.com"
            }else{
                cell.textLabel?.text = "客服QQ号:"
                cell.detailTextLabel?.text = "3124703964"
            }
            return cell
    }
    //选中效果
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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
