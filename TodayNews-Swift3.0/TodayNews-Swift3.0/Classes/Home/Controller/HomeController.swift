//
//  HomeController.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import AFNetworking

class HomeController: UIViewController, UIScrollViewDelegate {
    
    private lazy var homeTopView: HomeTopView = HomeTopView();
    
    private var oldIndex: Int = 0;
    
    // scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.delegate = self;
        scrollView.isPagingEnabled = true;
        return scrollView;
    }();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏不透明
        navigationController?.navigationBar.isTranslucent = false;
        
        homeTopView.backgroundColor = UIColor.clear;
        homeTopView.frame = CGRect(x: 0, y: realValue(10), width: kScreenWidth, height: 30);
        homeTopView.homeTopCallBack = { [weak self]
            (model) in
            guard let weakSelf = self else {
                return;
            }
            
            UIView.animate(withDuration: 1, animations: { 
                
                weakSelf.scrollView.contentOffset = CGPoint(x: kScreenWidth * CGFloat(model.index), y: 0);
                
                }, completion: { (finished) in
                    
                    let currentVc = weakSelf.childViewControllers[model.index] as? HomeListController;
                    currentVc?.homeTopModel = model;
            });
        
        }
        navigationController?.navigationBar.addSubview(homeTopView);
        
        // 添加scrollView
        view.addSubview(scrollView);
        
        // 发送网络请求
        let urlString = "https://lf.snssdk.com/article/category/get_subscribed/v1/?iid=" + iid + "&aid=" + aid;
        getHomeTopTitleArray(urlString: urlString);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - scrollView 刚开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 保存旧的索引
        oldIndex = Int(scrollView.contentOffset.x / kScreenWidth);
    }
    
    // MARK: - scrollview 滚动结束的时候调用此方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let index = Int(scrollView.contentOffset.x / kScreenWidth);
        let currentVc = childViewControllers[index];
        let currentVcX = scrollView.contentOffset.x;
        let currentVcY = realValue(0);
        let currentVcW = kScreenWidth;
        let currentVcH = view.bounds.height;
        currentVc.view.frame = CGRect(x: currentVcX, y: currentVcY, width: currentVcW, height: currentVcH);
        scrollView.addSubview(currentVc.view);
        
        
        // 计算新的索引
        let newIndex = index;
        if newIndex != oldIndex {
            homeTopView.changeTitlePosition(index: newIndex);
        }
    }
 
    
    // MARK: - 发送网络请求，获取标题列表
    func getHomeTopTitleArray(urlString: String) -> Void {
        
        HttpManager.shareInstance.request(.GET, urlString: urlString, parameters: nil) { [weak self] (result, error) in
            
            guard let weakSelf = self else {
                return;
            }
            
            guard let result = result else {
                return;
            }
            let resultDic = result as?[String: Any];
            let dataDic = resultDic?["data"] as?[String: Any];
            let dataArray = dataDic?["data"] as? [[String: Any]];
   
            // 添加推荐
            let homeTopModel = HomeTopModel();
            homeTopModel.name = "推荐";
            homeTopModel.isSelected = true;
           weakSelf.homeTopView.homeTopModelArray.append(homeTopModel);
            
            let newDataArray = dataArray ?? [];
            for (index, tempDic) in newDataArray.enumerated() {
                
                let model = HomeTopModel.modelWidthDic(dic: tempDic);
                model.index = index;
                weakSelf.homeTopView.homeTopModelArray.append(model);
            }
            
            for model in weakSelf.homeTopView.homeTopModelArray {
                
                // 创建视图控制器
                let homeListVc = HomeListController();
                homeListVc.homeTopModel = model;
                weakSelf.addChildViewController(homeListVc);
            }
            
            // 设置scrollView的contentSize
            let count = weakSelf.homeTopView.homeTopModelArray.count;
            let kScrollViewW = kScreenWidth * CGFloat(count);
            let kScrollViewH = realValue(0);
            weakSelf.scrollView.contentSize = CGSize(width: kScrollViewW, height: kScrollViewH);
        
            // 主动调用滚动结束的方法，添加视图内容
            weakSelf.scrollViewDidEndDecelerating(weakSelf.scrollView);
            // 刷新数据
            weakSelf.homeTopView.collectionView.reloadData();
        }
    }
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置scrollView的frame
        let scrollViewX = realValue(0);
        let scrollViewY = realValue(0);
        let scrollViewW = width;
        let scrollViewH = height;
        scrollView.frame = CGRect(x: scrollViewX, y: scrollViewY, width: scrollViewW, height: scrollViewH);
    }
}

