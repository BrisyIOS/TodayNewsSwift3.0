//
//  FilterWordModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class FilterWordModel: NSObject {
    
    var id: String?
    
    var is_selected: Bool?
    
    var name: String?

    
    // MARK: - 字典转模型
    class func modelWithDic(dic: [String: Any]?) -> FilterWordModel? {
        guard let dic = dic else {
            return nil;
        }
        let filterWordModel = FilterWordModel();
        filterWordModel.id = dic["id"] as? String ?? "";
        filterWordModel.is_selected = dic["is_selected"] as? Bool;
        filterWordModel.name = dic["name"] as? String ?? "";
        return filterWordModel;
    }

}
