//
//  TabBarController.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/25.
//  Copyright © 2016年 zhangxu. All rights reserved.


import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置taBar的前景色
        tabBar.tintColor = UIColor.red;
        
        // 首页
        let homeVc = HomeController();
        addChildVc(vc: homeVc, title: "首页", imageName: "home_tabbar_night_22x22_", selectedImageName: "home_tabbar_press_22x22_");
        
        // 视频
        let videoVc = VideoController();
        addChildVc(vc: videoVc, title: "视频", imageName: "video_tabbar_night_22x22_", selectedImageName: "video_tabbar_press_22x22_");
        
        // 关注
        let concernVc = ConcernController();
        addChildVc(vc: concernVc, title: "关注", imageName: "newcare_tabbar_night_22x22_", selectedImageName: "newcare_tabbar_press_22x22_");
        
        // 我的
        let mineVc = MineController();
        addChildVc(vc: mineVc, title: "我的", imageName: "mine_tabbar_night_22x22_", selectedImageName: "mine_tabbar_press_22x22_");

    }
    
    // MARK: - 添加子控制器
    func addChildVc(vc: UIViewController, title: String, imageName: String, selectedImageName: String) -> Void {

        let nav = NavigationController(rootViewController: vc);
        nav.tabBarItem.title = title;
        nav.tabBarItem.image = UIImage.imageWithName(name: imageName);
        nav.tabBarItem.selectedImage = UIImage.imageWithName(name: selectedImageName);
        addChildViewController(nav);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
