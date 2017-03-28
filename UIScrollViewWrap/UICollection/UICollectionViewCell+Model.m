//
//  UICollectionViewCell+Model.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UICollectionViewCell+Model.h"
#import "NSObject+SIQuickAssociated.h"

NSString *const kCollectionSelected = @"selected" ;

#pragma mark >>>>> 关联对象Key  <<<<<
static char modelKey ;
static char selectedActionKey ;
static char indexPathKey ;
static char containVcKey ;
static char superCollectionViewKey ;

@implementation UICollectionViewCell (Model)

#pragma mark >>>>>>> 关联对象  <<<<<<<
- (void)setSelectedAction:(SelectBlock)selectedAction {
    [self si_quickAssociateValue:selectedAction withKey:&selectedActionKey] ;
}

- (SelectBlock)selectedAction {
    return [self si_quickGetAssociatedValueForKey:&selectedActionKey] ;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [self si_quickAssociateValue:indexPath withKey:&indexPath] ;
}

- (NSIndexPath *)indexPath {
    return [self si_quickGetAssociatedValueForKey:&indexPathKey] ;
}


- (void)setContainVc:(UIViewController *)containVc {
    [self si_quickWeaklyAssociateValue:containVc withKey:&containVcKey] ;
}

- (UIViewController *)containVc {
    return [self si_quickGetAssociatedValueForKey:&containVcKey];
}

- (void)setSuperCollectionView:(UICollectionView *)superCollectionView {
    [self si_quickWeaklyAssociateValue:superCollectionView withKey:&superCollectionViewKey] ;
}

- (UICollectionView *)superCollectionView {
    return [self si_quickGetAssociatedValueForKey:&superCollectionViewKey] ;
}

#pragma mark >>>>>>>>> 模型操作  <<<<<<<<
- (void)setModel:(id)model {
    [self si_quickAssociateValue:model withKey:&modelKey] ;
    if ([model isKindOfClass:[NSDictionary class]]) {
        id block = [model objectForKey:kCollectionSelected] ;
        self.selectedAction = block ;
    }
}

- (id)model {
    return [self si_quickGetAssociatedValueForKey:&modelKey] ;
}

- (CGSize)cellSizeInCollectionView:(UICollectionView *)collectionView withModel:(id)model {
    return CGSizeMake(50, 50) ;
}

@end
