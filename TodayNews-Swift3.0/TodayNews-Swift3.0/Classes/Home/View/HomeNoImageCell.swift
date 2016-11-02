//
//  HomeNoImageCell.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeNoImageCell: HomeListCommonCell {
    
    var homeListModel: HomeListModel? {
        didSet {
            // 取出可选类型中的数据
            guard let homeListModel = homeListModel else {
                return;
            }
            
            // 给titleLabel 赋值
            if let title = homeListModel.title {
                titleLabel.text = title;
                homeListModel.titleLabelH = calculateLabelHeight(text: title, labelW: kScreenWidth - CGFloat(2) * 15, fontSize: 17);
            }
            
            // 时间
            if let publish_time = homeListModel.publish_time {
                timeLabel.text = changeTimestampToPublicTime(timestamp: publish_time);
                homeListModel.timeLabelW = calculateWidth(title: timeLabel.text!, fontSize: 12);
            }
            
            // 头像
            if let source_avatar = homeListModel.source_avatar {
                if let source = homeListModel.source {
                    nameLabel.text = source;
                    homeListModel.nameLabelW = calculateWidth(title: source, fontSize: 12);
                }
                avatarImageView.zx_setImageWithURL(source_avatar);
            }
            
            if let mediaInfo = homeListModel.media_info {
                nameLabel.text = mediaInfo.name;
                avatarImageView.zx_setImageWithURL(mediaInfo.avatar_url);
            }
            
            // 评论
            if let comment = homeListModel.comment_count {
                commentLabel.text = (comment >= 10000) ? "\(comment/10000)万评论" : "\(comment)评论";
                homeListModel.commentLabelW = calculateWidth(title: commentLabel.text!, fontSize: 12);
            }
            
            // 更新frame
            layoutIfNeeded();
            setNeedsLayout();
        }
    };
    

    // MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        guard let homeListModel = homeListModel else {
            return;
        }
        
        let width = bounds.size.width;
        
        // 设置titleLabel  的frame
        let titleLabelX = realValue(15);
        let titleLabelY = realValue(50/3);
        let titleLabelW = width - titleLabelX * CGFloat(2);
        let titleLabelH = homeListModel.titleLabelH;
        titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH);
        
        // 设置avatarImageView 的frame
        let avatarImageViewX = titleLabelX;
        let avatarImageViewY = titleLabel.frame.maxY + realValue(10);
        let avatarImageViewW = realValue(49/3);
        let avatarImageViewH = avatarImageViewW;
        avatarImageView.frame = CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewW, height: avatarImageViewH);
        
        // 设置nameLabel 的frame
        let nameLabelX = avatarImageView.frame.maxX + realValue(5);
        let nameLabelY = titleLabel.frame.maxY + realValue(36/3);
        let nameLabelW = homeListModel.nameLabelW;
        let nameLabelH = realValue(12);
        nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelY, width: nameLabelW, height: nameLabelH);
        
        // 设置commentLabel 的frame
        let commentLabelX = nameLabel.frame.maxX + realValue(5);
        let commentLabelY = nameLabelY;
        let commentLabelW = homeListModel.commentLabelW;
        let commentLabelH = nameLabelH;
        commentLabel.frame = CGRect(x: commentLabelX, y: commentLabelY, width: commentLabelW, height: commentLabelH);
        
        // 设置timeLabel 的frame
        let timeLabelX = commentLabel.frame.maxX + realValue(5);
        let timeLabelY = nameLabelY;
        let timeLabelW = homeListModel.timeLabelW;
        let timeLabelH = nameLabelH;
        timeLabel.frame = CGRect(x: timeLabelX, y: timeLabelY, width: timeLabelW, height: timeLabelH);
        
        // 设置stickLabel 的frame
        let stickLabelX = timeLabel.frame.maxX + realValue(5);
        let stickLabelY = nameLabelY;
        let stickLabelW = homeListModel.stickLabelW;
        let stickLabelH = nameLabelH;
        stickLabel.frame = CGRect(x: stickLabelX, y: stickLabelY, width: stickLabelW, height: stickLabelH);
        
        // 设置圆角
        let cornerRadii = CGSize(width: realValue(49/3/2), height: realValue(49/3/2));
        setRoundCorner(currentView: avatarImageView, cornerRadii: cornerRadii);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
