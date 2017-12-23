//
//  YPTopicViewController.swift
//  Dantan.
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit

let homeCellID = "YPHomeCell"

class YPTopicViewController: UITableViewController ,YPHOmeCellDelegate{

    var type = Int()
    
    var items = [YPHomeItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = YMGlobalColor()
        
        setupTableView()
        
        loadHomeData()
        
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY+kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        let nib = UINib(nibName: String(describing: YPHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
        }

    func loadHomeData() {
        weak var weakSelf = self
        YPNetworkingTool.shareNetworkTool.loadHomeInfo(id: type) { (homeItems) in
            self.items = homeItems;
            weakSelf!.tableView.reloadData()
        }
    }
    
   //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! YPHomeCell
        homeCell.selectionStyle = .none
        homeCell.delegate = self
        homeCell.homeItem = items[indexPath.row]
        return homeCell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YPDetailViewController()
        vc.homeItem = items[indexPath.row]
        vc.title = "攻略详情"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - YPHomeCellDelegate
    func homeCellFavoriteCickBtn(button: UIButton) {
        if !UserDefaults.standard.bool(forKey: isLogin) {
            let login = YPLoginViewController()
            login.title = "登录"
            let nav = YPNavigationViewController(rootViewController: login)
            self.present(nav, animated: true, completion: nil)
        }else {
        
        }
    }
}
