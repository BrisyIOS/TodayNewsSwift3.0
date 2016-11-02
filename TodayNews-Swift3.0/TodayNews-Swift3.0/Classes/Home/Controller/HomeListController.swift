//
//  HomeListController.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 设置cell标识
    private let homeOneImageCellID = "homeOneImageCellID";
    private let homeThreeImageCellID = "homeThreeImageCellID";
    private let homeLargeImageCellID = "homeLargeImageCellID";
    private let homeNoImageCellID = "homeNoImageCellID";
    
    var homeTopModel: HomeTopModel?;
    
    // 懒加载tableView 
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain);
        tableView.dataSource = self;
        tableView.delegate = self;
        return tableView;
    }();
    
    // 懒加载数组
    private lazy var homeListArray: [HomeListModel] = [HomeListModel]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加tableview 
        view.addSubview(tableView);
        tableView.estimatedRowHeight = 100;
    
        // 注册cell
        tableView.register(HomeOneImageCell.self, forCellReuseIdentifier: homeOneImageCellID);
        tableView.register(HomeThreeImageCell.self, forCellReuseIdentifier: homeThreeImageCellID);
        tableView.register(HomeLargeImageCell.self, forCellReuseIdentifier: homeLargeImageCellID);
        tableView.register(HomeNoImageCell.self, forCellReuseIdentifier: homeNoImageCellID);

        // 从服务器请求首页新闻列表数据
        let urlString = "http://lf.snssdk.com/api/news/feed/v39";
        let parameters: [String: Any] = ["iid": iid, "device_id": device_id, "category": homeTopModel?.category ?? ""];
        getHomeListFromServer(urlString: urlString, parameters: parameters);
 
    }
    
    // MARK: - 从服务器请求首页新闻列表数据
    func getHomeListFromServer(urlString: String, parameters: [String: Any]) -> Void {
        
        HttpManager.shareInstance.request(.GET, urlString: urlString, parameters: parameters) { [weak self] (result, error) in
            
            guard let weakSelf = self else {
                return;
            }
            let resultDic = result as? [String: Any];
            if let resultDic = resultDic {
                let dataArray = resultDic["data"] as? [[String: Any]];
                for dataDic in dataArray ?? [] {
                    let content = dataDic["content"] as? String ?? "";
                    let contentData = content.data(using: String.Encoding.utf8);
                    let contentDic = try! JSONSerialization.jsonObject(with: contentData!, options: .mutableContainers) as![String: Any];
                    let model = HomeListModel.modelWidthDic(dic: contentDic);
                    weakSelf.homeListArray.append(model);
                   
                }
                
                // 刷新数据
                weakSelf.tableView.reloadData();
            }
        }
    }
    
    // MARK: - 返回cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = homeListArray[indexPath.row];
        return HomeListModel.cellHeight(model: model);
    }
    
    // MARK: - 返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeListArray.count;
    }
    
    // MARK: - 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let homeListModel = homeListArray[indexPath.row];
        
        // 有3张图的情况
        if homeListModel.image_list?.count != 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: homeThreeImageCellID, for: indexPath) as? HomeThreeImageCell;
            cell?.homeListModel = homeListModel;
            return cell!;
        } else {
            
            if homeListModel.middle_image?.height != 0 {
                
                // 显示一张可以播放的大图
                if homeListModel.video_detail_info != nil || homeListModel.large_image_list?.count != 0 {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: homeLargeImageCellID, for: indexPath) as? HomeLargeImageCell;
                    cell?.homeListModel = homeListModel;
                    return cell!;
                } else {
                    // 在右边显示一张图
                    let cell = tableView.dequeueReusableCell(withIdentifier: homeOneImageCellID, for: indexPath) as? HomeOneImageCell;
                    cell?.homeListModel = homeListModel;
                    return cell!;
                }
            } else {
                
                // 没有图片
                let cell = tableView.dequeueReusableCell(withIdentifier: homeNoImageCellID, for: indexPath) as? HomeNoImageCell;
                cell?.homeListModel = homeListModel;
                return cell!;
            }
        }
    }
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        let tableViewX = realValue(0);
        let tableViewY = realValue(0);
        let tableViewW = width;
        let tableViewH = height - realValue(49);
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
}
