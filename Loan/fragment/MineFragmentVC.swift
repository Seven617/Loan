//
//  MineFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  MineFragment

import UIKit
import Toaster

class MineFragmentVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var tableView:UITableView?
    var allnames:Dictionary<Int, [String]>?
    
    override func loadView() {
        super.loadView()
        let item = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //防止导航条跳转时变黑
        navigationController?.navigationBar.isTranslucent = false
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "用户ID"]),
            1:[String]([
                "联系客服",
                "关于我们"])
        ];
        //创建右边按钮
        let rightBtn = UIBarButtonItem(image: UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItemStyle.plain,
                                       target: self, action: #selector(goSetting))
        self.navigationItem.rightBarButtonItem = rightBtn
        print(self.allnames as Any)
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height), style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //禁止拖拽
        //self.tableView!.bounces = false
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
    }
    //跳转到设置界面
    @objc func goSetting(){
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: SettingViewController())))
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc!, animated: true)
        self.hidesBottomBarWhenPushed = false
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
            return 80;
        }else{
            return 50;
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
                let image = UIImage(named:"head")
                cell.imageView?.image = image
                cell.textLabel?.text = "Seven617"
//                cell.textLabel?.text = data![indexPath.row]
                return cell
            }else
            {
                let adcell = tableView.dequeueReusableCell(
                    withIdentifier: identify, for: indexPath)
                adcell.accessoryType = .disclosureIndicator
                adcell.textLabel?.text = data![indexPath.row]
                adcell.setSelected(false, animated: false)
                return adcell
            }
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.tableView!.deselectRow(at: indexPath, animated: true)
//        let itemString = self.allnames![indexPath.section]![indexPath.row]
//        let alertController = UIAlertController(title: "提示!",message: "你选中了【\(itemString)】",
//            preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        if(itemString == "用户ID")
        {
            Toast(text: "你选中了【\(itemString)】").show()
        }else if(itemString == "联系客服"){
            let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: CustomerServiceViewController())))
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc!, animated: true)
            self.hidesBottomBarWhenPushed = false
        }else if(itemString == "关于我们"){
            let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: AboutUsViewController())))
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc!, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
