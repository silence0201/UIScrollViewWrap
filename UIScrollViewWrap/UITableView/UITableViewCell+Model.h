//
//  UITableViewCell+Model.h
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedBlock)(NSIndexPath *indexPath);


#pragma mark --- 模型Key

/// TitleView的内容
FOUNDATION_EXTERN NSString *const kCellTitle;
/// DetailView的内容
FOUNDATION_EXTERN NSString *const kCellDetail;
/// ImageView的Image,支持字符串和Image对象
FOUNDATION_EXTERN NSString *const kCellImage;

/// AccessoryView
FOUNDATION_EXTERN NSString *const kCellAccessoryView;
/// AccessoryType
FOUNDATION_EXTERN NSString *const kCellAccessoryType;

/// title字体颜色
FOUNDATION_EXTERN NSString *const kCellTitleColor;
/// title字体
FOUNDATION_EXTERN NSString *const kCellTitleFont;
/// detail字体颜色
FOUNDATION_EXTERN NSString *const kCellDetailColor;
/// detail字体
FOUNDATION_EXTERN NSString *const kCellDetailFont;

/// 点击事件
FOUNDATION_EXTERN NSString *const kCellSelected;


@interface UITableViewCell (Model)

#pragma mark --- 模型信息

/// 模型数据,可自定义,如果使用系统可根据模型Key构建字典对象或者直接传入字符串,自定义模型只需要重写setModel方法
@property(nonatomic,strong) id model;

/// 点击Cell回调Block
@property(nonatomic,strong) SelectedBlock selectedAction ;

/// 计算行高,默认为44.重写该方法实现自定义行高
- (CGFloat)cellHeightInTableView:(UITableView *)tableView withModel:(id)model ;

#pragma mark --- 常用数据
/// IndexPath信息
@property (nonatomic,strong) NSIndexPath *indexPath;

/// ViewController信息
@property (nonatomic,weak) UIViewController *containVc ;

/// TableView信息
@property (nonatomic,weak) UITableView *superTableView;

@end
