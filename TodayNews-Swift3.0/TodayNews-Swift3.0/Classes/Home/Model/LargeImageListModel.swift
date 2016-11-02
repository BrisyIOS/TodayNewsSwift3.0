//
//  LargeImageListModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class LargeImageListModel: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list: [[String: Any]]?

    
    // MARK: - 字典转模型
    class func modelWithArray(array: [[String: Any]]?) -> [LargeImageListModel]? {
        
        var largeImageList = [LargeImageListModel]();
        for dic in array ?? [[:]] {
            
            let model = LargeImageListModel();
            model.height = dic["height"] as? Int ?? 0;
            model.width = dic["width"] as? Int ?? 0;
            model.url = dic["url"] as? String ?? "";
            model.url_list = dic["url_list"] as? [[String: Any]] ?? [[:]];
            largeImageList.append(model);
        }
        
        return largeImageList;
    }


}
