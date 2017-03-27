//
//  UITableView+Model.h
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SITableViewDelegate <UITableViewDelegate>

@end

@protocol SITableViewDataSource <UITableViewDataSource>

@optional
/// 对应CellArray中的索引
- (NSInteger)tableView:(UITableView *)tableView cellArrayIndexForIndexPath:(NSIndexPath *)indexPath ;

/// 设置额外的样式
- (void)tableView:(UITableView *)tableView cellStyle:(UITableViewCell *)cell ;

@end

/// Cell在TableViewCells中的索引Key
FOUNDATION_EXTERN NSString *const kCellArrayIndex;

/// 分组的Model信息Key
FOUNDATION_EXTERN NSString *const kGroupModels;
/// 分组的header信息Key
FOUNDATION_EXTERN NSString *const kGroupHeaderTitle;
/// 分组的footer信息key
FOUNDATION_EXTERN NSString *const kGroupFooderTitle;

@interface UITableView (Model)

/// 代理系统代理
@property (nonatomic,weak) id<SITableViewDelegate> sDelegate ;
@property (nonatomic,weak) id<SITableViewDataSource> sDataSource ;

/// 数据源,如果需要分组还需要里面嵌套一层对应每组的字典信息
@property (nonatomic,strong) NSMutableArray *models ;
/// 是否开启分组
@property (nonatomic,assign) BOOL sectionEnable ;
/// 开启分组后,右侧IndexTitle信息
@property (nonatomic,strong) NSArray<NSString *> *sectionIndexTitles ;

/// 注册单个Cell,支持Class和Nib
@property (nonatomic,strong) id tableViewCell ;
/// 注册多个Cell
@property (nonatomic,strong) NSArray *tableViewCells ;

/// 是否支持Cell自动计算高度,默认不支持
@property (nonatomic,assign) BOOL autoLayout ;
/// 是否开启选中效果
@property (nonatomic,assign) BOOL clearSelected ;

/// 不设置Cell,,可以通过设置Style来初始化cell
@property (nonatomic,assign) UITableViewCellStyle tableViewCellStyle ;

/// ViewController
@property (nonatomic,weak) UIViewController *containVc ;

@end
