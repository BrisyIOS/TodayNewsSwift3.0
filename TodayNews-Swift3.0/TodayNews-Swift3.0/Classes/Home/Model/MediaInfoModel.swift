//
//  MediaInfoModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class MediaInfoModel: NSObject {
    
    var avatar_url: String?
    var name: String?
    var media_id: Int?
    var user_verified: Int?
    
    
    // MARK: - 字典转模型
    class func modelWithDic(dic: [String: Any]?) -> MediaInfoModel? {
        
        guard let dic = dic else {
            return nil;
        }
        let mediaInfoModel = MediaInfoModel();
        mediaInfoModel.avatar_url = dic["avatar_url"] as? String ?? "";
        mediaInfoModel.name = dic["name"] as? String ?? "";
        mediaInfoModel.media_id = dic["media_id"] as? Int ?? 0;
        mediaInfoModel.user_verified = dic["user_verified"] as? Int ?? 0;
        return mediaInfoModel;
    }

}
