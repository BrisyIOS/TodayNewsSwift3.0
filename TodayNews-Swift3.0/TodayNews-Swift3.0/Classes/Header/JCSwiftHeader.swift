//
//  JCSwiftHeader.swift
//  AlphaRestaurant
//
//  Created by zhangxu on 16/9/28.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import MJRefresh

// 信息
let iid = "5034850950";
let aid = "13";
let device_id = "6096495334";

// 屏幕宽度和高度
let kScreenWidth = UIScreen.main.bounds.size.width;
let kScreenHeight = UIScreen.main.bounds.size.height;

extension UIImage {
    
    class func imageWithName(name: String) -> UIImage? {
        
        let image = UIImage(named: name);
        return image;
    }
}

// 加载网络图片
extension UIImageView {
    
    // MARK: - 加载网络图片，有占位图
    func zx_setImageWithURL(_ urlString: String?, placeholderImage: UIImage?) -> Void {
        
        guard let urlString = urlString , let placeholderImage = placeholderImage else {
            return;
        }
        let url = URL(string: urlString)!;
        sd_setImage(with: url, placeholderImage: placeholderImage);
    }
    
    // MARK: - 加载网络图片，没有占位图
    func zx_setImageWithURL(_ urlString: String?) -> Void {
        guard let urlString = urlString else {
            return;
        }
        let url = URL(string: urlString);
        sd_setImage(with: url);
    }
}

// 创建时间格式、日期，比较耗性能，需要保证整个项目中只执行一次
let formatter = DateFormatter();
let calendar = Calendar.current;
extension Date {
    
    var dateDescription: String {
        
        // 今天
        if calendar.isDateInToday(self) {
            
            let delta = -Int(self.timeIntervalSinceNow);
            if delta < 60 {
                return "刚刚";
            }
            
            if delta < 3600 {
                return "\(delta/60)分钟前"
            }
            
            return "\(delta/3600)小时前"
     
        }
        // 昨天
        var fmt = " HH:mm"
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt;
        } else {
            fmt = "MM-dd" + fmt;
            let year = calendar.component(.year, from: self);
            let currentYear = calendar.component(.year, from: Date());
            if year != currentYear {
                fmt = "yyyy-" + fmt;
            }
        }
        // 时间格式
        formatter.dateFormat = fmt;
        
        return formatter.string(from: self);
    }
}


// 根据指定宽度和字体大小，计算label高度
func calculateLabelHeight(text: String, labelW: CGFloat, fontSize: CGFloat) -> CGFloat {
    
    var attributes = [String: Any]();
    attributes[NSFontAttributeName] = Font(size: fontSize);
    let rect = (text as NSString).boundingRect(with: CGSize(width: labelW, height: 10000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil);
    return rect.size.height;
}

// 将时间戳转为时间
func changeTimestampToPublicTime(timestamp: Int) -> String {
    let newTimestamp = TimeInterval(timestamp);
    let date = Date(timeIntervalSince1970: newTimestamp);
    return date.dateDescription;
};


// 根据文字返回宽度
func calculateWidth(title: String, fontSize: CGFloat) -> CGFloat {
    
    var attribute = [String: AnyObject]();
    attribute[NSFontAttributeName] = Font(size: fontSize);
    let width = title.size(attributes: attribute).width;
    return width;
}

// RGB
func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    
    let color = UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1);
    return color;
}

// 16进制色码
func RGBWithHexColor(hexColor: Int) -> UIColor {
    
    let red = ((hexColor & 0xFF0000) >> 16);
    let green = ((hexColor & 0xFF00) >> 8);
    let blue = (hexColor & 0xFF);
    let color = RGB(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue));
    return color;
}

// 设置字体大小
func Font(size: CGFloat) -> UIFont {
    
    let font = UIFont.systemFont(ofSize: realValue(size));
    return font;
}


// 设置粗体
func BoldFont(size: CGFloat) -> UIFont {
    
    let font = UIFont.boldSystemFont(ofSize: realValue(size));
    return font;
}


// 适配
let is_iPhone5 = (UIScreen.main.bounds.size == CGSize(width: 320, height: 568)) ? true : false;
let is_iPhone6 = (UIScreen.main.bounds.size == CGSize(width: 375, height: 667)) ? true : false;
let is_iPhone6Plus = (UIScreen.main.bounds.size == CGSize(width: 414, height: 736)) ? true : false;


// 真实值
func realValue(_ value: CGFloat) -> CGFloat {
    
    var realValue: CGFloat = 0;
    realValue = value / 414 * kScreenWidth;
    return realValue;
}

// 设置圆角
func setRoundCorner(currentView: UIView, cornerRadii: CGSize) -> Void {
    
    // 设置圆角
    let bezierPath = UIBezierPath.init(roundedRect: currentView.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: cornerRadii);
    let shapeLayer = CAShapeLayer();
    // 设置大小
    shapeLayer.frame = currentView.bounds;
    // 设置圆形样子
    shapeLayer.path = bezierPath.cgPath;
    currentView.layer.mask = shapeLayer;
}


