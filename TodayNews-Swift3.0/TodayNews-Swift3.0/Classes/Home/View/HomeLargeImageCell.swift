//
//  HomeLargeImageCell.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeLargeImageCell: HomeListCommonCell {
    
    // 播放时长
    private lazy var video_durationLabel: UILabel = {
        let label = UILabel();
        label.textAlignment = .center;
        label.layer.cornerRadius = 10;
        label.textColor = UIColor.white;
        label.layer.masksToBounds = true;
        label.font = Font(size: 9);
        label.backgroundColor = RGB(red: 0, green: 0, blue: 0);
        label.alpha = 0.6;
        return label;
    }();
    
    // 播放按钮
    private lazy var playBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "new_play_video_60x60_"), for: .normal);
        return button;
    }();
    
    var homeListModel: HomeListModel? {
        didSet {
            // 取出可选类型中的数据
            guard let homeListModel = homeListModel else {
                return;
            }
            
            // 新闻标题 
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
            
            var largeImageURLString: String = "";
            // 视频
            if let videoDetailInfo = homeListModel.video_detail_info {
                if let detail_video_large_image = videoDetailInfo.detail_video_large_image {
                    largeImageURLString = detail_video_large_image.url ?? "";
                }
                // 播放时长
                if let duration = homeListModel.video_duration {
                    let minute = Int(duration / 60)
                    let second = duration % 60
                    video_durationLabel.text = String(format: "%02d:%02d", minute, second)
                }
                playBtn.isHidden = false;
                video_durationLabel.isHidden = false;
                
            } else {
                playBtn.isHidden = true;
                video_durationLabel.isHidden = true;
                if let large_image_list = homeListModel.large_image_list {
                    if let url = large_image_list.first?.url {
                        largeImageURLString = url;
                    }
                }
                
                if let gallary_image_count = homeListModel.gallary_image_count {
                    video_durationLabel.text = "\(gallary_image_count)图";
                }
            }
            
            // 大图
            largeImage.zx_setImageWithURL(largeImageURLString);
            
            // 更新子控件的frame
            layoutIfNeeded();
            setNeedsLayout();
        }
    };
    
    // 一张大图
    private lazy var largeImage: UIImageView = UIImageView();

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 添加大图
        contentView.addSubview(largeImage);
        
        largeImage.addSubview(video_durationLabel);
        
        largeImage.addSubview(playBtn);
        
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
        let titleLabelY = realValue(16);
        let titleLabelW = width - titleLabelX * CGFloat(2);
        let titleLabelH = homeListModel.titleLabelH;
        titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH);
        
        // 设置largeImage的frame
        let largeImageX = titleLabelX;
        let largeImageY = titleLabel.frame.maxY + realValue(11);
        let largeImageW = titleLabelW;
        let largeImageH = realValue(510/3);
        largeImage.frame = CGRect(x: largeImageX, y: largeImageY, width: largeImageW, height: largeImageH);
        
        // 设置avatarImageView 的frame
        let avatarImageViewX = titleLabelX;
        let avatarImageViewY = largeImage.frame.maxY + realValue(10);
        let avatarImageViewW = realValue(49/3);
        let avatarImageViewH = avatarImageViewW;
        avatarImageView.frame = CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewW, height: avatarImageViewH);
        
        // 设置nameLabel 的frame
        let nameLabelX = avatarImageView.frame.maxX + realValue(5);
        let nameLabelY = largeImage.frame.maxY + realValue(36/3);
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
        
        // 设置video_durationLabel 的frame
        let video_durationLabelX = largeImage.frame.width - realValue(171/3);
        let video_durationLabelY = largeImage.frame.height - realValue(81/3);
        let video_durationLabelW = realValue(149/3);
        let video_durationLabelH = realValue(60/3);
        video_durationLabel.frame = CGRect(x: video_durationLabelX, y: video_durationLabelY, width: video_durationLabelW, height: video_durationLabelH);
        
        // 设置playBtn 的frame
        playBtn.center = CGPoint(x: largeImageW/2, y: largeImageH/2);
        playBtn.bounds = CGRect(x: 0, y: 0, width: realValue(120/2), height: realValue(120/2));
        
        // 设置圆角
        let cornerRadii = CGSize(width: realValue(49/3/2), height: realValue(49/3/2));
        setRoundCorner(currentView: avatarImageView, cornerRadii: cornerRadii);
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
