//
//  HomeListController.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import MJRefresh

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
    
    override func loadView() {
        super.loadView();
        
        print("loadview");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true;
        // 添加tableview 
        view.addSubview(tableView);
        tableView.estimatedRowHeight = 100;
        tableView.tableFooterView = UIView();
    
        // 注册cell
        tableView.register(HomeOneImageCell.self, forCellReuseIdentifier: homeOneImageCellID);
        tableView.register(HomeThreeImageCell.self, forCellReuseIdentifier: homeThreeImageCellID);
        tableView.register(HomeLargeImageCell.self, forCellReuseIdentifier: homeLargeImageCellID);
        tableView.register(HomeNoImageCell.self, forCellReuseIdentifier: homeNoImageCellID);
        
        // 下拉刷新
        var pullTime: TimeInterval = 0;
        let header = MJRefreshNormalHeader();
        header.refreshingBlock = { [weak self] _ in
            guard let weakSelf = self else {
                return;
            }
            pullTime = Date().timeIntervalSince1970;
            
            // 从服务器请求首页新闻列表数据
            let urlString = "http://lf.snssdk.com/api/news/feed/v39";
            let parameters: [String: Any] = ["iid": iid, "device_id": device_id, "category": weakSelf.homeTopModel?.category ?? ""];
            weakSelf.getHomeListFromServer(urlString: urlString, parameters: parameters);
        }
        // 设置header
        tableView.mj_header = header;
        // 开始刷新
        header.beginRefreshing();
        
        // 上啦加载更多
        let footer = MJRefreshAutoNormalFooter();
        footer.refreshingBlock = { [weak self]
            _ in
            guard let weakSelf = self else {
                return;
            }
            // 加载更多
            let url = "http://lf.snssdk.com/api/news/feed/v39/";
            let parameters: [String: Any] = ["device_id": device_id, "iid": iid, "last_refresh_sub_entrance_interval": pullTime];
            HttpManager.shareInstance.request(.GET, urlString: url, parameters: parameters, finished: { (result, error) in
                // 如果error 不为空，打印error，并直接返回
                if let error = error {
                    print(error);
                    return;
                }
                // 如果没有数据，直接返回
                guard let result = result else {
                    return;
                }
                // 如果有数据，对返回的数据做JSON解析
                let resultDic = result as? [String: Any];
                if let resultDic = resultDic {
                    let dataArray = resultDic["data"] as? [[String: Any]];
                    for dataDic in dataArray ?? [] {
                        let content = dataDic["content"] as? String ?? "";
                        let contentData = content.data(using: String.Encoding.utf8);
                        do {
                            let contentDic = try JSONSerialization.jsonObject(with: contentData!, options: .mutableContainers) as? [String: Any]  ?? [:];
                            // 将字典转化为模型
                            let model = HomeListModel.modelWidthDic(dic: contentDic);
                            if model.template_md5 != "" {
                                continue;
                            }
                            // 将模型装入数组中
                            weakSelf.homeListArray.append(model);
                        } catch {
                            // 异常处理
                            print("JSON解析异常");
                        }
                    }
                    
                    // 刷新数据
                    weakSelf.tableView.reloadData();
                    // 停止刷新
                    weakSelf.tableView.mj_header.endRefreshing();
                }
            })
        }
        // 设置footer
        tableView.mj_footer = footer;
        
    }
    
    // MARK: - 从服务器请求首页新闻列表数据
    func getHomeListFromServer(urlString: String, parameters: [String: Any]) -> Void {
      
        HttpManager.shareInstance.request(.GET, urlString: urlString, parameters: parameters) { [weak self] (result, error) in
            
            // 如果error不为空，直接返回
            if let error = error {
                print(error);
                return;
            }
            // 释放self捕获的引用，并做安全处理
            guard let weakSelf = self else {
                return;
            }
            // 如果没有数据，直接返回
            guard let result = result else {
                return;
            }
            // 有数据， 对数据进行JSON解析
            let resultDic = result as? [String: Any];
            if let resultDic = resultDic {
                let dataArray = resultDic["data"] as? [[String: Any]];
                for dataDic in dataArray ?? [] {
                    let content = dataDic["content"] as? String ?? "";
                    let contentData = content.data(using: String.Encoding.utf8);
                    do {
                        let contentDic = try JSONSerialization.jsonObject(with: contentData!, options: .mutableContainers) as? [String: Any]  ?? [:];
                        // 将字典转化为模型
                        let model = HomeListModel.modelWidthDic(dic: contentDic);
                        if model.template_md5 != "" {
                            continue;
                        }
                        // 将模型装入数组中
                        weakSelf.homeListArray.append(model);
                    } catch {
                        // 异常处理
                        print("JSON解析异常");
                    }
                }
                
                // 刷新数据
                weakSelf.tableView.reloadData();
                // 停止刷新
                weakSelf.tableView.mj_header.endRefreshing();
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
    
    // MARK: - 选中cell进入详情页面
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false);
        
        let homeDetailVc = HomeDetailController();
        let homeListModel = homeListArray[indexPath.row];
        homeDetailVc.homeListModel = homeListModel;
        navigationController?.pushViewController(homeDetailVc, animated: true);
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
