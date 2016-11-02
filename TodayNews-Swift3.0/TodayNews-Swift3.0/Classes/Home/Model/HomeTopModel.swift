//
//  HomeTopModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeTopModel: NSObject {
    
    var category: String?;
    var concern_id: String?;
    var default_add: Int?;
    var flags: Int?;
    var icon_url: String?;
    var name: String?;
    var tip_new: Int?;
    var type: Int?;
    var web_url: String?;
    var isSelected: Bool = false;
    var index: Int = 0;
    
    // 字典转模型
    class func modelWidthDic(dic: [String: Any]) -> HomeTopModel {
        
        let model = HomeTopModel();
        model.category = dic["category"] as? String ?? "";
        model.concern_id = dic["concern_id"] as? String ?? "";
        model.default_add = dic["default_add"] as? Int ?? 0;
        model.flags = dic["flags"] as? Int ?? 0;
        model.icon_url = dic["icon_url"] as? String ?? "";
        model.name = dic["name"] as? String ?? "";
        model.tip_new = dic["tip_new"] as? Int ?? 0;
        model.type = dic["type"] as? Int ?? 0;
        model.web_url = dic["web_url"] as? String ?? "";
        return model;
    }

}
