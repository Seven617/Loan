//
//  LoanFragmentVC.swift
//  Loan
//
//  Created by 冷少白 on 2018/5/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//  LoanFragment

import UIKit
import MJRefresh
import Kingfisher
import MBProgressHUD

class LoanFragmentVC: BaseViewController,MoreDropDownMenuDataSource, MoreDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource {
    //贷款的数量
    var loanList : [querydata] = []
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    //自定义导航栏
    var navView = UIView()
    var menu = MoreDropDownMenu()
    var amount:[String]=["金额不限","1千以下","1-3千","3-5千","5千-1万","1-3万","3万以上"]
    var period:[String]=["期限不限","1个月内","1-3个月","3-6个月","6-12个月","12个月以上"]
    var tableView = UITableView()
    
    var periodmax=999
    var periodmin=0
    var amountmax=99999
    var amountmin=0
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        intiNavigationControlle()
        initMenu()
        initTableView()
        Query()
    }
    
    func intiNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
        navView.backgroundColor = UIColor.Main
        view.addSubview(navView)
        // 导航栏标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: navH - topY))
        titleLabel.text = "借贷"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    //顶部下拉刷新
    @objc func headerRefresh(){
        Query()
    }
    func initMenu(){
        menu = MoreDropDownMenu(origin: CGPoint(x: 0, y: navView.frame.maxY), andHeight: kHeightRelIPhone6(height:45))
        menu.delegate = self
        menu.dataSource = self
        view.addSubview(menu)
    }
    func numberOfColumns(in menu: MoreDropDownMenu?) -> Int {
        return 2
    }
    
    func menu(_ menu: MoreDropDownMenu?, numberOfRowsInColumn column: Int) -> Int {
        if column == 0 {
            return amount.count
        } else if column == 1 {
            return period.count
        } else {
            return 1
        }
    }
    func menu(_ menu: MoreDropDownMenu?, titleForRowAt indexPath: MoreIndexPath?) -> String? {
        if indexPath?.column == 0 {
            if let aRow = indexPath?.row {
                return amount[aRow] as String
            }
            return nil
        } else if indexPath?.column == 1 {
            if let aRow = indexPath?.row {
                return period[aRow] as String
            }
            return nil
        } else {
            return nil
        }
    }
    
    func menu(_ menu: MoreDropDownMenu?, arrayForRowAt indexPath: MoreIndexPath?) -> [Any]? {
        if indexPath?.column == 0 {
            return amount
        } else if indexPath?.column == 1 {
            return period
        } else {
            return nil
        }
    }
    func menu(_ menu: MoreDropDownMenu?, didSelectRowAt indexPath: MoreIndexPath?) {
        if indexPath?.item ?? 0 >= 0 {
            if let aColumn = indexPath?.column, let aRow = indexPath?.row, let anItem = indexPath?.item {
                print("点击了 \(aColumn) - \(aRow) - \(anItem) 项目")
            }
        } else {
            if let aColumn = indexPath?.column, let aRow = indexPath?.row {
                MBProgressHUD.showAdded(to: view, animated: true)
                let x:Int = aColumn
                let y:Int = aRow
                //print("点击了 \(aColumn) - \(aRow) 项目")
                if (x==0){
                    switch y {
                    case 0:
                        amountmax=99999
                        amountmin=0
                        break
                    case 1:
                        amountmax=999
                        amountmin=0
                        break
                    case 2:
                        amountmax=2999
                        amountmin=1000
                        break
                    case 3:
                        amountmax=4999
                        amountmin=3000
                        break
                    case 4:
                        amountmax=9999
                        amountmin=5000
                        break
                    case 5:
                        amountmax=29999
                        amountmin=10000
                        break
                    case 6:
                        amountmax=99999
                        amountmin=30000
                        break
                    default:
                        break
                    }
                }else if (x==1){
                    switch y {
                    case 0:
                        periodmax=99999
                        periodmin=0
                        break
                    case 1:
                        periodmax=29
                        periodmin=0
                        break
                    case 2:
                        periodmax=89
                        periodmin=30
                        break
                    case 3:
                        periodmax=180
                        periodmin=90
                        break
                    case 4:
                        periodmax=359
                        periodmin=180
                        break
                    case 5:
                        periodmax=999
                        periodmin=360
                        break
                    default:
                        break
                    }
                }
            }
            Query()
            //回滚到顶部
            tableView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    func initTableView(){
        tableView = UITableView(frame: CGRect(x:0, y:menu.frame.maxY+1 ,width: UIScreen.main.bounds.width, height:SCREEN_HEIGHT  -   (self.tabBarController?.tabBar.frame.size.height)! - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.size.height - kHeightRelIPhone6(height: 45)), style: UITableViewStyle.plain)
        tableView.register(LoanCell.self,forCellReuseIdentifier: "SampleCell")
        tableView.dataSource = self
        tableView.delegate = self
        //隐藏滚动条
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        //1.先设置样式
        tableView.ly_emptyView = MyDIYEmpty.diyNoData()
        //2.关闭自动显隐（此步可封装进自定义类中，相关调用就可省去这步）
        //        tableView.ly_emptyView.autoShowEmptyView = false
        self.view.addSubview(tableView)
        
        //下拉刷新相关设置
        header.lastUpdatedTimeLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(LoanFragmentVC.headerRefresh))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        tableView.ly_startLoading()
    }
    
    @objc func Query(){
        querydata.request(periodmax: periodmax, periodmin: periodmin, amountmax: amountmax, amountmin: amountmin) { (query) in
            if let query = query {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
                    {
                        self.loanList = query
                        //结束刷新
                        self.tableView.mj_header.endRefreshing()
                        self.tableView.reloadData()
                        self.tableView.ly_endLoading()
                        MBProgressHUD.hide(for: self.view, animated: true)
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
                    {
                        SYIToast.alert(withTitleBottom: "网络错误！")
                        //结束刷新
                        self.tableView.mj_header.endRefreshing()
                        
                })
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loanList.count;
    }
    
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kHeightRelIPhone6(height:70);
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath) as! LoanCell
        let news = loanList[indexPath.row]
        let url = URL(string: news.logo) 
        cell.img.kf.indicatorType = .activity
        cell.img.kf.setImage(with: url )
        cell.name.text = news.name
        cell.quota.text = ("\(news.minAmount.description!) - \(news.maxAmount.description!)")
        cell.rates.text = ("\(news.minRate.description!) %")
        let a:Int = news.rateUnit as! Int
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
        cell.rateslab.text = time!+"费率"
        cell.descriptionlab.text = news.comment
        return cell
    }
    
    
    //cell点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = loanList[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: false)
        //        let alertController = UIAlertController(title: "提示!",
        //             message: "你选中了【\(news.name!)】",preferredStyle: .alert)
        //        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        //        alertController.addAction(cancelAction)
        //        self.present(alertController, animated: true, completion: nil)
        let detil = DetilViewController()
        detil.productId=news.id
//        detil.navtitle=news.name
        self.navigationController?.pushViewController(detil, animated: true)
    }
    
}
