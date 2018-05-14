//
//  LoanFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit
import Toaster

class LoanFragmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var _selectedDataSource1Ary: [AnyObject]?
    var _selectedDataSource2Ary: [AnyObject]?
    var conditionFilterView: QZConditionFilterView?
    var tableView = UITableView()
    var dataArr = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        dataArr = ["1","2","3","4","5","6","7","8","9","10"]
        // FilterBlock 选择下拉菜单选项触发
        conditionFilterView = QZConditionFilterView(filterBlock: {(_ isFilter: Bool, _ dataSource1Ary: [Any]?, _ dataSource2Ary: [Any]?) -> Void in
            // 1.isFilter = YES 代表是用户下拉选择了某一项
            // 2.dataSource1Ary 选择后第一组选择的数据  2 3一次类推
            // 3.如果你的项目没有清空筛选条件的功能，可以无视else 我们的app有清空之前的条件，重置，所以才有else的逻辑
            if isFilter {
                //网络加载请求 存储请求参数
                self._selectedDataSource1Ary = dataSource1Ary as [AnyObject]?
                self._selectedDataSource2Ary = dataSource2Ary as [AnyObject]?
            } else {
                // 不是筛选，全部赋初值（在这个工程其实是没用的，因为tableView是选中后必选的，即一旦选中就没有空的情况，但是如果可以清空筛选条件的时候就有必要 *重新* reset data）
                self._selectedDataSource1Ary = ["金额不限"] as [AnyObject]
                self._selectedDataSource2Ary = ["期限不限"] as [AnyObject]
            }
            // 开始网络请求
            self.startRequest()
        })
    
        
        
        conditionFilterView?.y += ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height)
        // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
        _selectedDataSource1Ary = ["金额不限"] as [AnyObject]
        _selectedDataSource2Ary = ["期限不限"] as [AnyObject]
        // 传入数据源，对应三个tableView顺序
        conditionFilterView?.dataAry1 = ["金额不限","1千以下","1-3千","3-5千","5千-1万","1-3万","3万以上"]
        conditionFilterView?.dataAry2 = ["期限不限","1个月内","1-3个月","3-6个月","6-12个月","12个月以上"]
        // 初次设置默认显示数据(标题)，内部会调用block 进行第一次数据加载
        conditionFilterView?.bindChoseArrayDataSource1(_selectedDataSource1Ary, dataSource2: _selectedDataSource2Ary)
        self.view.addSubview(conditionFilterView!)
//        self.view.insertSubview(conditionFilterView!, at: 1)
        tableView = UITableView(frame: CGRect(x:0, y:(self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height + 40 ,width: UIScreen.main.bounds.width, height:self.view.bounds.size.height  -   (self.tabBarController?.tabBar.frame.size.height)! - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height - 40), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        //禁止拖拽
        tableView.bounces = false
        //隐藏滚动条
        tableView.showsVerticalScrollIndicator = false
        

//        self.view.insertSubview(tableView, belowSubview: conditionFilterView!)
        self.view.addSubview(tableView)
    }
    
    func startRequest() {
        var source1: String? = nil
        if let anObject = _selectedDataSource1Ary?.first {
            source1 = "\(anObject)"
        }
        var source2: String? = nil
        if let anObject = _selectedDataSource2Ary?.first {
            source2 = "\(anObject)"
        }
    
        var _: [NSObject : AnyObject] = conditionFilterView!.keyValueDic! as [NSObject : AnyObject]
        // 可以用字符串在dic换成对应英文key
//        Toast(text: "\n\(String(describing: source1))  \n\(String(describing: source2))\n").show()
        print("\n第一个条件:\(String(describing: source1))\n  第二个条件:\(String(describing: source2))\n")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell";
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        cell.textLabel?.textAlignment = NSTextAlignment.center //文字居中
        cell.textLabel?.text = String(dataArr[indexPath.row] as! String)
        cell.detailTextLabel?.text = "test\(dataArr[indexPath.row])"
        
        
        
        return cell
    }
    
    
    //cell点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let alertController = UIAlertController(title: "提示!",
             message: "你选中了【\(indexPath.row + 1)】",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    //删除功能的实现
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler: {_,_ in
//            ((action: UITableViewRowAction,indexPath: NSIndexPath) -> Void).self
            self.dataArr.removeObject(at: indexPath.row)
                        tableView.reloadData()
        })
        
        return [deleteAction]
    }
    
}
