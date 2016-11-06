//
//  HomeDetailController.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/11/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import WebKit

class HomeDetailController: UIViewController {
    
    // webview
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration();
        let webView = WKWebView.init(frame: .zero, configuration: configuration);
        return webView;
    }();
    
    var homeListModel: HomeListModel?;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.imageWithName(name: "lefterbackicon_titlebar_night_28x28_"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back));
        
        // 添加webview
        view.addSubview(webView);
        
        if let homeListModel = homeListModel {
            let urlString = homeListModel.url ?? "";
            let url = URL(string: urlString);
            let request = URLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10);
            webView.load(request);
        }

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 返回
    func back() -> Void {
        
        navigationController?.popViewController(animated: true);
    }
    
    // MARK: - 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        webView.frame = view.bounds;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
