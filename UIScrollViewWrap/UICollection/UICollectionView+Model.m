//
//  UICollectionView+Model.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UICollectionView+Model.h"
#import "NSObject+SIQuickAssociated.h"

/// 分组的Model信息
NSString *const kCollectionGroupModels = @"collectionGroupModels" ;

static NSString *collectionCellId = @"collectionCellId" ;

#pragma mark >>>>>>>>> 关联对象Key  <<<<<<<<<
static char sDelegateKey ;
static char sDataSourceKey ;
static char modelskey ;
static char sectionEnableKey ;
static char sectionIndexTitlesKey ;
static char collectionCellKey ;
static char clearSelectedKey ;
static char containVcKey ;

@interface UICollectionView (Delegate)<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation UICollectionView (Model)
#pragma mark >>>>>>>>>> 关联对象  <<<<<<<<<<<<<

// 代理
- (void)setSDelegate:(id<SICollectionViewDelegate>)sDelegate {
    [self si_quickWeaklyAssociateValue:sDelegate withKey:&sDelegateKey] ;
}

- (id<SICollectionViewDelegate>)sDelegate {
    return [self si_quickGetAssociatedValueForKey:&sDelegateKey] ;
}

- (void)setSDataSource:(id<SICollectionViewDataSource>)sDataSource {
    [self si_quickWeaklyAssociateValue:sDataSource withKey:&sDataSourceKey] ;
}

- (id<SICollectionViewDataSource>)sDataSource {
    return [self si_quickGetAssociatedValueForKey:&sDataSourceKey] ;
}

// 是否开启分组
- (void)setSectionEnable:(BOOL)sectionEnable {
    [self si_quickWeaklyAssociateValue:@(sectionEnable) withKey:&sectionEnableKey] ;
}

- (BOOL)sectionEnable {
    return [[self si_quickGetAssociatedValueForKey:&sectionEnableKey] boolValue] ;
}

// IndexTitle
- (void)setSectionIndexTitles:(NSArray<NSString *> *)sectionIndexTitles {
    [self si_quickAssociateValue:sectionIndexTitles withKey:&sectionIndexTitlesKey] ;
}

- (NSArray<NSString *> *)sectionIndexTitles {
    return [self si_quickGetAssociatedValueForKey:&sectionIndexTitlesKey] ;
}

// 是否开启ClearSelected样式
- (void)setClearSelected:(BOOL)clearSelected {
    [self si_quickWeaklyAssociateValue:@(clearSelected) withKey:&clearSelectedKey] ;
}

- (BOOL)clearSelected {
    return [[self si_quickGetAssociatedValueForKey:&clearSelectedKey] boolValue] ;
}

// ContainerViewController
- (void)setContainVc:(UIViewController *)containVc {
    [self si_quickWeaklyAssociateValue:containVc withKey:&containVcKey] ;
}

- (UIViewController *)containVc {
    return [self si_quickGetAssociatedValueForKey:&containVcKey] ;
}

// 注册CollectionCell
- (void)setCollectionCell:(id)collectionCell {
    [self si_quickAssociateValue:collectionCell withKey:&collectionCellKey] ;
    if(collectionCell) {
        if([collectionCell isKindOfClass:[UINib class]]) {
            [self registerNib:collectionCell forCellWithReuseIdentifier:collectionCellId] ;
        }else{
            [self registerClass:collectionCell forCellWithReuseIdentifier:collectionCellId] ;
        }
    }
}

- (id)collectionCell {
    return [self si_quickGetAssociatedValueForKey:&collectionCellKey] ;
}

// 设置数据源
- (void)setModels:(NSMutableArray *)models {
    NSMutableArray *array = models;
    if([models isMemberOfClass:[NSArray class]]){
        array = models.mutableCopy;
    }
    [self si_quickAssociateValue:models withKey:&modelskey] ;
    self.dataSource = self;
    self.delegate = self;
}

- (NSMutableArray *)models {
    NSMutableArray *array = [self si_quickGetAssociatedValueForKey:&modelskey] ;
    if (!array) {
        array = [NSMutableArray array];
        self.models = array;
    }
    return array;
}
@end

@implementation UICollectionView(Delegate)



@end
