//
//  HomeListModel.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeListModel: NSObject {
    
    var nameLabelW: CGFloat = 0;
    var commentLabelW: CGFloat = 0;
    var timeLabelW: CGFloat = 0;
    var stickLabelW: CGFloat = 0;
    var titleLabelH: CGFloat = 0;

    var abstract: String?
    var keywords: String?
    var title: String?
    var label: String?
    var article_alt_url: String?
    var article_url: String?
    var display_url: String?
    var share_url: String?
    var url: String?
    var item_id: Int?
    var tag_id: Int?
    var tag: String?
    var read_count: Int?
    var comment_count: Int?
    var repin_count: Int?
    var digg_count: Int?
    var publish_time: Int?
    var source: String?
    var source_avatar: String?
    var stick_label: String?
    var gallary_image_count: Int?
    var group_id: Int?
    var has_image: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    var has_video: Bool?
    var video_detail_info: VideoDetailInfoModel?
    var video_style: Int?
    var video_duration: Int?
    var video_id: Int?
    var filter_words: FilterWordModel?;
    var image_list: [ImageListModel]?;
    var middle_image: MiddleImageModel?;
    var large_image_list: [LargeImageListModel]?;
    var behot_time: Int?
    var cell_flag: Int?
    var bury_count: Int?
    var article_type: Int?
    var cursor: Int?
    var media_info: MediaInfoModel?
    
    // MARK: - 字典转模型
    class func modelWidthDic(dic: [String: Any]) -> HomeListModel {
        
        let model = HomeListModel();
        model.abstract = dic["abstract"] as? String ?? "";
        model.keywords = dic["keywords"] as? String ?? "";
        model.title = dic["title"] as? String ?? "";
        model.label = dic["label"] as? String ?? "";
        model.article_alt_url = dic["article_alt_url"] as? String ?? "";
        model.article_url = dic["article_url"] as? String ?? "";
        model.display_url = dic["display_url"] as? String ?? "";
        model.share_url = dic["share_url"] as? String ?? "";
        model.url = dic["url"] as? String ?? "";
        model.item_id = dic["item_id"] as? Int ?? 0;
        model.tag_id = dic["tag_id"] as? Int ?? 0;
        model.tag = dic["tag"] as? String ?? "";
        model.read_count = dic["read_count"] as? Int ?? 0;
        model.comment_count = dic["comment_count"] as? Int ?? 0;
        model.repin_count = dic["repin_count"] as? Int ?? 0;
        model.digg_count = dic["digg_count"] as? Int ?? 0;
        model.publish_time = dic["publish_time"] as? Int ?? 0;
        model.source = dic["source"] as? String ?? "";
        model.source_avatar = dic["source_avatar"] as? String ?? "";
        model.stick_label = dic["stick_label"] as? String ?? "";
        model.gallary_image_count = dic["gallary_image_count"] as? Int ?? 0;
        model.group_id = dic["group_id"] as? Int ?? 0;
        model.has_image = dic["has_image"] as? Bool;
        model.has_m3u8_video = dic["has_m3u8_video"] as? Bool;
        model.has_mp4_video = dic["has_mp4_video"] as? Bool;
        model.has_video = dic["has_video"] as? Bool;
        model.video_detail_info = dic["video_detail_info"] as? VideoDetailInfoModel;
        model.video_style = dic["video_style"] as? Int ?? 0;
        model.video_duration = dic["video_duration"] as? Int ?? 0;
        model.video_id = dic["video_id"] as? Int ?? 0;
        model.filter_words = FilterWordModel.modelWithDic(dic: dic["filter_words"] as? [String : Any])
        model.image_list = ImageListModel.modelWidthArray(array: dic["image_list"] as? [[String : Any]]);
        model.middle_image = MiddleImageModel.modelWidthDic(dic: dic["middle_image"] as? [String : Any]);
        model.large_image_list = LargeImageListModel.modelWithArray(array: dic["large_image_list"] as? [[String: Any]])
        model.behot_time = dic["behot_time"] as? Int ?? 0;
        model.cell_flag = dic["cell_flag"] as? Int ?? 0;
        model.bury_count = dic["bury_count"] as? Int ?? 0;
        model.article_type = dic["article_type"] as? Int ?? 0;
        model.cursor = dic["cursor"] as? Int ?? 0;
        model.media_info = MediaInfoModel.modelWithDic(dic: dic["media_info"] as? [String : Any]);
        return model;
    }
    
    // cell高度
    class func cellHeight(model: HomeListModel) -> CGFloat {
        
        var cellHeight: CGFloat = 0;
        // 有3张图的情况
        if model.image_list?.count != 0 {
            
            let labelW = kScreenWidth - CGFloat(2) * realValue(15);
            let labelH = calculateLabelHeight(text: model.title!, labelW: labelW, fontSize: 17);
            let imageH = realValue(210/3);
            cellHeight = realValue(50/3 + 11) + labelH + imageH + realValue(12 + 12 + 52/3);
            
        } else {
            
            if model.middle_image?.height != 0 {
                
                // 显示一张可以播放的大图
                if model.video_detail_info != nil || model.large_image_list?.count != 0 {
                    
                    let labelW = kScreenWidth - CGFloat(2) * realValue(15);
                    let labelH = calculateLabelHeight(text: model.title!, labelW: labelW, fontSize: 17);
                    let imageH = realValue(510/3);
                    cellHeight = realValue(50/3 + 11) + labelH + imageH + realValue(12 + 12 + 52/3);
                    
                } else {
                    // 在右边显示一张图
                    let imageH = realValue(210/3);
                    cellHeight = realValue(15) + imageH + realValue(15);
                }
            } else {
                
                // 没有图片
                let labelW = kScreenWidth - CGFloat(2) * realValue(15);
                let labelH = calculateLabelHeight(text: model.title!, labelW: labelW, fontSize: 17);
                cellHeight = realValue(50/3) + labelH + realValue(53/3 + 12 + 52/3);
            }
        }
        
        return cellHeight;
    }
   
}
