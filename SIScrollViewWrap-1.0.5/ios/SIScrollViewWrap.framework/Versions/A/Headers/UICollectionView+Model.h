//
//  UICollectionView+Model.h
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SICollectionViewDelegate <UICollectionViewDelegateFlowLayout>
@end

@protocol SICollectionViewDataSource <UICollectionViewDataSource>
@end

/// 分组的Model信息Key
FOUNDATION_EXTERN NSString *const kCollectionGroupModels;

@interface UICollectionView (Model)

/// 代理系统代理
@property (nonatomic,weak) id<SICollectionViewDelegate> sDelegate ;
@property (nonatomic,weak) id<SICollectionViewDataSource> sDataSource ;

/// 数据源,如果需要分组还需要里面嵌套一层对应每组的字典信息
@property (nonatomic,strong) NSMutableArray *models ;
/// 是否开启分组
@property (nonatomic,assign) BOOL sectionEnable ;

/// 注册单个Cell,支持Class和Nib
@property (nonatomic,strong) id collectionCell ;

/// 是否开启选中效果
@property (nonatomic,assign) BOOL clearSelected ;

/// ViewController
@property (nonatomic,weak) UIViewController *containVc ;

@end
