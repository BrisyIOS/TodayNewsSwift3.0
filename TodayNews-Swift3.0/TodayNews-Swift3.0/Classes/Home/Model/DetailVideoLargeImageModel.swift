//
//  DetailVideoLargeImageModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class DetailVideoLargeImageModel: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list = [[String: Any]]()
    
    // MARK: - 字典转模型
    class func modelWithDic(dic: [String: Any]?) -> DetailVideoLargeImageModel? {
        
        guard let dic = dic else {
            return nil;
        }
        
        let model = DetailVideoLargeImageModel();
        model.height = dic["height"] as? Int ?? 0;
        model.width = dic["width"] as? Int ?? 0;
        model.url = dic["url"] as? String ?? "";
        model.url_list = dic["url_list"] as? [[String: Any]] ?? [[:]];
        return model;
    }
    
}
