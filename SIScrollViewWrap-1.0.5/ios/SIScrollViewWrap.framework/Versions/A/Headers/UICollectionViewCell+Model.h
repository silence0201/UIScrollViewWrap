//
//  UICollectionViewCell+Model.h
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark >>>>>>>>> 模型Key  <<<<<<<<<<
/// 点击事件
FOUNDATION_EXTERN NSString *const kCollectionSelected;

typedef void(^SelectBlock)(NSIndexPath *indexPath);
@interface UICollectionViewCell (Model)

#pragma mark >>>>>>>> 模型信息  <<<<<<<<

/// 模型数据,可自定义,如果使用系统可根据模型Key构建字典对象或者直接传入字符串,自定义模型只需要重写setModel方法
@property(nonatomic,strong) id model;

/// 点击Cell回调Block
@property(nonatomic,strong) SelectBlock selectedAction ;

#pragma mark >>>>>>>> 常用数据  <<<<<<<<<
/// IndexPath信息
@property (nonatomic,strong) NSIndexPath *indexPath;

/// ViewController信息
@property (nonatomic,weak) UIViewController *containVc ;

/// TableView信息
@property (nonatomic,weak) UICollectionView *superCollectionView;

@end
