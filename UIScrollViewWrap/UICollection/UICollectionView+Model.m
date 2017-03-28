//
//  UICollectionView+Model.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UICollectionView+Model.h"
#import "NSObject+SIQuickAssociated.h"
#import "UICollectionViewCell+Model.h"

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

#pragma mark >>>>> UICollectionView DataSource  <<<<<<<
// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.sDataSource respondsToSelector:@selector(numberOfItemsInSection:)]){
        return [self.sDataSource numberOfSectionsInCollectionView:collectionView] ;
    }
    if(self.sectionEnable) {
        return self.models.count ;
    }
    return 1 ;
}
// 每组有多少条
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([self.sDataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]){
        return [self.sDataSource collectionView:collectionView numberOfItemsInSection:section] ;
    }
    if(self.sectionEnable && self.models.count > 0) {
        id model = self.models[section] ;
        // 不包括额外的信息
        if([model isKindOfClass:[NSArray class]]){
            NSArray *array = model ;
            return array.count ;
        }else if([model isKindOfClass:[NSDictionary class]]){
            NSArray *array = [model objectForKey:kCollectionGroupModels] ;
            return array.count ;
        }
        return 0 ;
    }
    // 没有分组
    return self.models.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sDataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]){
        return [self.sDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath] ;
    }
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath] ;
    cell.indexPath = indexPath ;
    cell.containVc = self.containVc ;
    cell.superCollectionView = self ;
    cell.model = [self modelForIndexPath:indexPath] ;
    
    return cell ;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([self.sDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.sDataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath] ;
    }
    return nil ;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDataSource respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)]) {
        return [self.sDataSource collectionView:collectionView canMoveItemAtIndexPath:indexPath] ;
    }
    return NO ;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if ([self.sDataSource respondsToSelector:@selector(collectionView:moveItemAtIndexPath:toIndexPath:)]) {
        return [self.sDataSource collectionView:collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath] ;
    }
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self.sDataSource respondsToSelector:@selector(collectionView:indexPathForIndexTitle:atIndex:)]) {
        [self.sDataSource collectionView:collectionView indexPathForIndexTitle:title atIndex:index] ;
    }
    return nil ;
}

- (NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView{
    if([self.sDataSource respondsToSelector:@selector(indexTitlesForCollectionView:)]){
        return [self.sDataSource indexTitlesForCollectionView:collectionView] ;
    }
    
    if (self.sectionIndexTitles) {
        return self.sectionIndexTitles ;
    }
    return nil ;
}

#pragma mark >>>>> UICollectionView Delegate  <<<<<<<
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clearSelected) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES] ;
    }
    if ([self.sDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]){
        return [self collectionView:collectionView didSelectItemAtIndexPath:indexPath] ;
    }
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath] ;
    if(cell.selectedAction){
        cell.selectedAction(indexPath) ;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)]) {
        return [self.sDelegate collectionView:collectionView didDeselectItemAtIndexPath:indexPath] ;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.sDelegate respondsToSelector:@selector(collectionView:shouldHighlightItemAtIndexPath:)]){
        return  [self.sDelegate collectionView:collectionView shouldHighlightItemAtIndexPath:indexPath] ;
    }
    return YES ;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.sDelegate respondsToSelector:@selector(collectionView:didHighlightItemAtIndexPath:)]){
        return [self.sDelegate collectionView:collectionView didHighlightItemAtIndexPath:indexPath] ;
    }
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.sDelegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.itemSize;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.sDelegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.sDelegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.sDelegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [self.sDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if ([self.sDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        return [self.sDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
    return CGSizeZero;
}

- (void)scrollViewDidEndDragging:(UICollectionView *)collectionView willDecelerate:(BOOL)decelerate{
    if([collectionView.sDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        [collectionView.sDelegate scrollViewDidEndDragging:collectionView willDecelerate:decelerate];
    }
}
- (void)scrollViewDidScroll:(UICollectionView *)collectionView {
    if([collectionView.sDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [collectionView.sDelegate scrollViewDidScroll:collectionView];
    }
}

#pragma mark >>>>>>>>>>>>> Private
- (id)modelForIndexPath:(NSIndexPath *)indexPath {
    if (self.models.count == 0)  return nil ;
    id model = nil ;
    // 设置数据源
    if(self.sectionEnable) {
        id item = self.models[indexPath.section] ;
        // 不带其他额外信息
        if([item isKindOfClass:[NSArray class]]){
            model = item[indexPath.row] ;
        }else if ([item isKindOfClass:[NSDictionary class]]){
            NSArray *array = [item objectForKey:kCollectionGroupModels] ;
            if ([array isKindOfClass:[NSArray class]]) {
                model = array[indexPath.row] ;
            }
        }
    }else{
        model = self.models[indexPath.row] ;
    }
    return model ;
}
@end
