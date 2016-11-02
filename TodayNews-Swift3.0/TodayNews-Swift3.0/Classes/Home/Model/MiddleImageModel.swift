//
//  MiddleImageModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class MiddleImageModel: NSObject {
    
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list: [[String: Any]]?
    
    // 字典转模型
    class func modelWidthDic(dic: [String: Any]?) -> MiddleImageModel? {
        guard let dic = dic else {
            return nil;
        }
        let middleImageModel = MiddleImageModel();
        middleImageModel.height = dic["height"] as? Int ?? 0;
        middleImageModel.width = dic["width"] as? Int ?? 0;
        middleImageModel.url_list = dic["url_list"] as? [[String: Any]] ?? [[:]];
        let webpString = dic["url"] as? String ?? "";
        if webpString.hasSuffix(".webp") {
            let range: Range = webpString.range(of: ".webp")!;
            middleImageModel.url = webpString.substring(to: range.lowerBound);
        } else {
            middleImageModel.url = webpString;
        }
        return middleImageModel;
    }

}
