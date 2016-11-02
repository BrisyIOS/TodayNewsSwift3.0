//
//  HomeThreeImageCell.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeThreeImageCell: HomeListCommonCell {
    
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
            
            // 三张图
            if let image_list = homeListModel.image_list {
                if image_list.count != 0 {
                    for index in 0..<image_list.count {
                        let imageViewArray = [firstImage, secondImage, thirdImage];
                        let imageListModel = image_list[index];
                        var imageURL: String = "";
                        let url = imageListModel.url ?? "";
                        if url.hasSuffix(".webp") {
                            let range = url.range(of: ".webp")!;
                            imageURL = url.substring(to: range.lowerBound);
                        } else {
                            imageURL = url;
                        }
                        imageViewArray[index].zx_setImageWithURL(imageURL);
                    }
                }
            }
            
            // 更新子控件的frame
            layoutIfNeeded();
            setNeedsLayout();
            
        }
    };
 
    // 三张图
    lazy var firstImage: UIImageView = UIImageView();
    lazy var secondImage: UIImageView = UIImageView();
    lazy var thirdImage: UIImageView = UIImageView();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 添加第一张图品
        contentView.addSubview(firstImage);
        // 添加第二张图片
        contentView.addSubview(secondImage);
        // 添加第三张图片
        contentView.addSubview(thirdImage);
   
    }
    
    // 更新子控件的frame
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
        
        // 设置firstImage 的frame
        let firstImageX = titleLabelX;
        let firstImageY = titleLabel.frame.maxY + realValue(11);
        let firstImageW = realValue(372/3);
        let firstImageH = realValue(210/3);
        firstImage.frame = CGRect(x: firstImageX, y: firstImageY, width: firstImageW, height: firstImageH);
        
        // 设置secondImage 的frame
        let secondImageX = firstImage.frame.maxX + realValue(20/3);
        let secondImageY = firstImageY;
        let secondImageW = firstImageW;
        let secondImageH = firstImageH;
        secondImage.frame = CGRect(x: secondImageX, y: secondImageY, width: secondImageW, height: secondImageH);
        
        // 设置thirdImage 的frame
        let thirdImageX = secondImage.frame.maxX + realValue(20/3);
        let thirdImageY = firstImageY;
        let thirdImageW = firstImageW;
        let thirdImageH = firstImageH;
        thirdImage.frame = CGRect(x: thirdImageX, y: thirdImageY, width: thirdImageW, height: thirdImageH);
        
        // 设置avatarImageView 的frame
        let avatarImageViewX = titleLabelX;
        let avatarImageViewY = firstImage.frame.maxY + realValue(10);
        let avatarImageViewW = realValue(49/3);
        let avatarImageViewH = avatarImageViewW;
        avatarImageView.frame = CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewW, height: avatarImageViewH);
        
        // 设置nameLabel 的frame
        let nameLabelX = avatarImageView.frame.maxX + realValue(5);
        let nameLabelY = firstImage.frame.maxY + realValue(36/3);
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
