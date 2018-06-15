//
//  MineFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  MineFragment

import UIKit

class MineFragmentVC: BaseViewController , UITableViewDelegate, UITableViewDataSource{
  
    var tableView:UITableView?
    var allnames:Dictionary<Int, [String]>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "用户ID"]),
            1:[String]([
                "联系客服",
                "关于我们"])
        ];

        //print(self.allnames as Any)
        //创建表视图
        tableView = UITableView(frame: CGRect(x:0, y:navH, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height), style:.grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        //禁止拖拽
        //self.tableView!.bounces = false
        //创建一个重用的单元格
        tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        tableView?.backgroundColor = UIColor.Gray
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height:kHeightRelIPhone6(height: 20)))
        // 设置header
        tableView!.tableHeaderView = header
        view.addSubview(self.tableView!)
    }
    func intiNavigationControlle(){
        
        // 自定义导航栏视图
        let navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.Main
        view.addSubview(navView)
        
        // 创建右边按钮
        let rightBtn = RightButton(target: self, action: #selector(goSetting))
        rightBtn.x = SCREEN_WIDTH - 60
        rightBtn.centerY = topY + (navH - topY) / 2.0
        rightBtn.setImage((UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal) as Any as! UIImage), for: .normal)
        navView.addSubview(rightBtn)
        
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "我的"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    //跳转到设置界面
    @objc func goSetting(){
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }

    //在本例中，有2个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return (allnames?.count)!;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.allnames?[section]
        return data!.count
    }
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let secno = indexPath.section
        if(secno == 0)
        {
            return kHeightRelIPhone6(height: 80);
        }else{
            return kHeightRelIPhone6(height: 50);
        }
        
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            //同一形式的单元格重复使用，在声明时已注册
            let secno = indexPath.section
            let data = self.allnames?[secno]
            if(secno == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                for: indexPath as IndexPath) as UITableViewCell
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                let image = UIImage(named:"touxiang")
                cell.imageView?.layer.cornerRadius = 30.0
                cell.imageView?.clipsToBounds = true
                cell.imageView?.image = image
                cell.textLabel?.text = "Seven617"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
//                cell.textLabel?.text = data![indexPath.row]
                return cell
            }else
            {
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                             for: indexPath as IndexPath) as UITableViewCell
                    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                    let image = UIImage(named:"kefu")
                    cell.imageView?.image = image
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                    cell.textLabel?.text = data![indexPath.row]
                    return cell
                }else{
                    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                    let image = UIImage(named:"aboutus")
                    cell.imageView?.image = image
                    cell.textLabel?.text = data![indexPath.row]
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
                    cell.detailTextLabel?.text = "快来了解一下快便贷"
                    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
                    return cell
                }
            }
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        if(itemString == "用户ID")
        {
            navigationController?.pushViewController(UserInfoViewController(), animated: true)
        }else if(itemString == "联系客服"){
            navigationController?.pushViewController(CustomerServiceViewController(), animated: true)
        }else if(itemString == "关于我们"){
            navigationController?.pushViewController(AboutUsViewController(), animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
