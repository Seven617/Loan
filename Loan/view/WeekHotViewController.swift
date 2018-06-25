//
//  WeekHotViewController.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/15.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import UIKit
import MJRefresh

class WeekHotViewController: BaseViewController,SCCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    var bannerList : [classifyList] = []
    var weekHotList : [weekhotdata] = []
    var BannerView : SCCycleScrollView!
    var navView = UIView()
    var tableView:UITableView!
    //本周热门（文字）
    var weekHot = UIView()
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Gray
        initNavigationControlle()
        initView()
        initData()
    }
    
    func initView(){
        initBanner()
        initweekHotLab()
        initTableView()
    }
    
    func initData(){
        getBanner()
    }
    
    func initNavigationControlle(){
        // 自定义导航栏视图
        navView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: navH))
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
        titleLabel.text = "热门贷款"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(titleLabel)
    }
    
    @objc func getBanner(){
        bannerdata.request { (banner) in
            if let banner = banner{
                if let classifyList = banner.classifyList{
                    OperationQueue.main.addOperation {
                        self.bannerList = classifyList
                        var bottomImages:[String]=[]
                        for img in self.bannerList{
                            bottomImages.append(img.image)
                        }
                        self.BannerView.imageArray=bottomImages as [AnyObject]
                    }
                }
            }else {
                print("网络错误")
            }
        }
    }
    
    @objc func getWeekHot(){
        weekhotdata.request { (weekhot) in
            if let weekhot = weekhot{
                OperationQueue.main.addOperation {
                    self.weekHotList = weekhot
                    //结束刷新
                    self.tableView.mj_header.endRefreshing()
                    self.tableView.reloadData()
                }
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:
                    {
                        SYIToast.alert(withTitleBottom: "网络错误！")
                        //结束刷新
                        self.tableView.mj_header.endRefreshing()
                })
            }
        }
    }
    func initBanner() {
        let placeholderImage = UIImage(named: "loading")
        BannerView = SCCycleScrollView.cycleScrollView(frame: CGRect(x: 0, y:navH, width: SCREEN_WIDTH, height:kHeightRelIPhone6(height: 150)),delegate: self,placeholderImage: placeholderImage)
        BannerView.delegate = self
        BannerView.timeInterval = 3.5
        BannerView.imageArray = nil
        BannerView.pageControlBottomMargin = 5
        BannerView.pageControlRightMargin = (UIScreen.main.bounds.width - BannerView.pageControlSize.width) / 2.0
        self.view.addSubview(BannerView)
    }
    
    func cycleScrollView(_ cycleScrollView: SCCycleScrollView, didSelectItemAt index: Int) {
        if BannerView.imageArray == nil{
            
        }else{
            let web = WebViewController()
            let detil = DetilViewController()
            let classify = bannerList[index]
            if classify.targetType==2{
                detil.navtitle=classify.title
                detil.productId=Int(classify.targetContent)
                self.navigationController?.pushViewController(detil, animated: true)
            }else if classify.targetType==3{
                web.webtitle=classify.title
                web.url = classify.targetContent
                self.navigationController?.pushViewController(web, animated: true)
            }
        }
    }
    private func initweekHotLab(){
        weekHot = UIView(frame: CGRect(x:0, y:BannerView.frame.maxY+kHeightRelIPhone6(height: 10) ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 30)))
        let icon = UIImageView(frame: CGRect(x:10, y:10 ,width: kWithRelIPhone6(width: 15), height:kHeightRelIPhone6(height: 15)))
        icon.image=UIImage(named:"weekhot_icon")
        weekHot.addSubview(icon)
        
        let weekLab = UILabel(frame: CGRect(x:icon.frame.maxX+10, y:10 ,width: UIScreen.main.bounds.width, height:kHeightRelIPhone6(height: 15)))
        weekLab.text = "热门贷款"
        weekLab.textColor = UIColor.Font1st
        weekLab.font = UIFont.systemFont(ofSize: 14)
        weekHot.addSubview(weekLab)
        weekHot.backgroundColor = UIColor.white
        self.view.addSubview(weekHot)
    }
    func initTableView(){
        tableView = UITableView(frame: CGRect(x: 0, y: weekHot.frame.bottom, width: view.bounds.width, height: SCREEN_HEIGHT - kHeightRelIPhone6(height: 150) - kHeightRelIPhone6(height: 40) - kHeightRelIPhone6(height: navH)), style: UITableViewStyle.plain)
        tableView.register(LoanCell.self,forCellReuseIdentifier: "SampleCell")
        tableView.dataSource = self
        tableView.delegate = self
        //隐藏滚动条
        tableView.showsVerticalScrollIndicator = false
        //禁止拖动
        //tableView.bounces=false
        tableView.tableFooterView = UIView()
        tableView.ly_emptyView = MyDIYEmpty.diyNoData()
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        //下拉刷新相关设置
        header.lastUpdatedTimeLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(WeekNewViewController.headerRefresh))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        tableView.ly_startLoading()
    }
    //顶部下拉刷新
    @objc func headerRefresh(){
        getWeekHot()
    }
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekHotList.count
    }
    
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kHeightRelIPhone6(height:70)
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath) as! LoanCell
        let news = weekHotList[indexPath.row]
        let url = URL(string: news.logo)
        cell.img.kf.indicatorType = .activity
        cell.img.kf.setImage(with: url )
        cell.name.text = news.name
        cell.quota.text = ("\(news.minAmount.description!) - \(news.maxAmount.description!)")
        cell.rates.text = ("\(news.minRate.description!) %")
        cell.descriptionlab.text = news.comment
        return cell
    }
    
    
    //cell点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = weekHotList[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: false)
        let detil = DetilViewController()
        detil.productId=news.id
        detil.navtitle=news.name
        self.navigationController?.pushViewController(detil, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    @objc func backBtnClicked() {
        navigationController?.popViewController(animated: true)
    }
}
