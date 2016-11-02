//
//  HomeTopView.swift
//  TodayNews-Swift3.0
//
//  Created by zhangxu on 2016/10/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class HomeTopView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // cell标识
    private let homeTopCellIdentifier = "homeTopCellIdentifier";
    
    // 懒加载collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: realValue(40), height: realValue(30));
        layout.scrollDirection = .horizontal;
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor = UIColor.clear;
        return collectionView;
    }();
    
    // 懒加载右边的添加按钮
    private lazy var rightBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "add_channel_titlbar_16x16_"), for: .normal);
        return button;
    }();
    
    // 懒加载数据
    lazy var homeTopModelArray: [HomeTopModel] = [HomeTopModel]();
    
    // 闭包回调
    var homeTopCallBack: ((_ model: HomeTopModel) -> ())?
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 添加表格
        addSubview(collectionView);
        
        // 添加右边的添加按钮
        addSubview(rightBtn);
        
        // 注册cell
        collectionView.register(HomeTopCell.self, forCellWithReuseIdentifier: homeTopCellIdentifier);
        
    }
    
    // MARK: - 改变标题 的位置
    func changeTitlePosition(index: Int) -> Void {
        
        // 先将其他的置为false
        for tempModel in homeTopModelArray {
            tempModel.isSelected = false;
        }
        
        let model = homeTopModelArray[index];
        model.isSelected = true;
        collectionView.reloadData();
        
        if index >= 5 {
            let indexPath = IndexPath(row: index, section: 0);
            collectionView.scrollToItem(at: indexPath, at: .right, animated: true);
        }
    }
    
    // MARK: - 选中cell改变cell的高度
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 先将所有模型的isSelected设置为false
        for tempModel in homeTopModelArray {
            tempModel.isSelected = false;
        }
        // 取出可选类型中的闭包
        guard let homeTopCallBack = homeTopCallBack else {
            return;
        }
        // 取出模型
        let model = homeTopModelArray[indexPath.row];
        // 设置为选中状态
        model.isSelected = true;
        // 闭包传值
        homeTopCallBack(model);
        // 刷新表格
        collectionView.reloadData();
    }
    
    // MARK: - 返回cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let model = homeTopModelArray[indexPath.row];
        guard let name = model.name else {
            return .zero;
        }
        
        let width = calculateWidth(title: name, fontSize: 18) + realValue(8);
        let height = realValue(30);
        return CGSize(width: width, height: height);
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: - 返回行
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeTopModelArray.count;
    }
    
    // MARK: - 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeTopCellIdentifier, for: indexPath) as? HomeTopCell;
        let model = homeTopModelArray[indexPath.row];
        cell?.model = model;
        return cell!;
    }
    
    
    // MARK: - 设置子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let width = bounds.size.width;
        let height = bounds.size.height;
        
        let collectionViewX = realValue(0);
        let collectionViewY = realValue(0);
        let collectionViewW = width - realValue(42);
        let collectionViewH = height;
        collectionView.frame = CGRect(x: collectionViewX, y: collectionViewY, width: collectionViewW, height: collectionViewH);
        
        
        let rightBtnX = collectionView.frame.maxX + realValue(5);
        let rightBtnY = collectionViewY;
        let rightBtnW = realValue(32);
        let rightBtnH = rightBtnW;
        rightBtn.frame = CGRect(x: rightBtnX, y: rightBtnY, width: rightBtnW, height: rightBtnH);
        
    }
    
}
