//
//  VideoDetailInfoModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class VideoDetailInfoModel: NSObject {
    
    var direct_play: Int?
    var group_flags: Int?
    var show_pgc_subscribe: Int?
    var video_id: String?
    var video_preloading_flag: Bool?
    var video_type: Int?
    var video_watch_count: Int?
    var video_watching_count: Int?
    var detail_video_large_image: DetailVideoLargeImageModel?

    
    // MARK: - 字典转模型
    class func modelWithDic(dic: [String: Any]) -> VideoDetailInfoModel? {
        
        let model = VideoDetailInfoModel();
        model.video_watching_count = dic["video_watching_count"] as? Int ?? 0;
        model.video_watch_count = dic["video_watch_count"] as? Int;
        model.video_type = dic["video_type"] as? Int ?? 0;
        model.video_preloading_flag = dic["video_preloading_flag"] as? Bool;
        model.video_id = dic["video_id"] as? String ?? "";
        model.direct_play = dic["direct_play"] as? Int ?? 0;
        model.group_flags = dic["group_flags"] as? Int ?? 0;
        model.show_pgc_subscribe = dic["show_pgc_subscribe"] as? Int ?? 0;
        model.detail_video_large_image = dic["detail_video_large_image"] as? DetailVideoLargeImageModel;
        return model;
        
    }
 
}
