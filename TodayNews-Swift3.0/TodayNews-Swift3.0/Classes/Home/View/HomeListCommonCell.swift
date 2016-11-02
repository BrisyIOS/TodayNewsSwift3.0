//
//  HomeListCommonCell.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/27.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeListCommonCell: UITableViewCell {
    
    /// 新闻标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = Font(size: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black;
        return titleLabel
    }()
    
    /// 用户名头像
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
    }()
    
    /// 用户名
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = Font(size: 12);
        nameLabel.textColor = UIColor.lightGray;
        return nameLabel
    }()
    
    /// 评论
    lazy var commentLabel: UILabel = {
        let comentLabel = UILabel()
        comentLabel.font = Font(size: 12);
        comentLabel.textColor = UIColor.lightGray;
        return comentLabel
    }()
    
    /// 时间
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = Font(size: 12);
        timeLabel.textColor = UIColor.lightGray;
        return timeLabel
    }()
    
    /// 置顶，热，广告，视频
    lazy var stickLabel: UIButton = {
        let stickLabel = UIButton()
        stickLabel.isHidden = true
        stickLabel.layer.cornerRadius = 3
        stickLabel.sizeToFit()
        stickLabel.isUserInteractionEnabled = false
        stickLabel.titleLabel!.font = Font(size: 12);
        stickLabel.setTitleColor(RGB(red: 241, green: 91, blue: 94), for: .normal);
        stickLabel.layer.borderColor = RGB(red: 241, green: 91, blue: 94).cgColor;
        stickLabel.layer.borderWidth = 0.5
        return stickLabel
    }()
    
    /// 举报按钮
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage.imageWithName(name: "add_textpage_17x12_"), for: .normal);
        closeButton.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside);
        return closeButton
    }()
    
    /// 举报按钮点击
    func closeBtnClick() {
        
    }
    
    // MARK: - 初始化方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 新闻标题
        contentView.addSubview(titleLabel);
        
        // 用户名头像
        contentView.addSubview(avatarImageView);
        
        // 用户名
        contentView.addSubview(nameLabel);
        
        // 评论
        contentView.addSubview(commentLabel);
        
        // 时间
        contentView.addSubview(timeLabel);
        
       

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
