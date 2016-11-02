//
//  HomeTopCell.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeTopCell: UICollectionViewCell {
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel();
        label.textColor = RGB(red: 236, green: 198, blue: 198);
        label.font = Font(size: 18);
        label.textAlignment = .center;
        return label;
    }();
    
    var model: HomeTopModel? {
        didSet {
            // 取出可选类型中的数据
            guard let model = model else {
                return;
            }
            titleLabel.text = model.name;
            
            if model.isSelected == false {
                titleLabel.textColor = RGB(red: 236, green: 198, blue: 198);
            } else {
                titleLabel.textColor = UIColor.white;
            }
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 清除颜色
        backgroundColor = UIColor.clear
        
        addSubview(titleLabel);
        
    }
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        titleLabel.frame = bounds;
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
