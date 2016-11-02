//
//  ImageListModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ImageListModel: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list: [[String: Any]]?
    
    class func modelWidthArray(array: [[String: Any]]?) -> [ImageListModel] {
        
        var imageListArray = [ImageListModel]();
        for dic in array ?? [[:]] {
            
            let imageListModel = ImageListModel();
            imageListModel.height = dic["height"] as? Int ?? 0;
            imageListModel.width = dic["width"] as? Int ?? 0;
            imageListModel.url = dic["url"] as? String ?? "";
            imageListModel.url_list = dic["url_list"] as? [[String: Any]] ?? [[:]];
            imageListArray.append(imageListModel);
        }
        
        return imageListArray;
    }

}
