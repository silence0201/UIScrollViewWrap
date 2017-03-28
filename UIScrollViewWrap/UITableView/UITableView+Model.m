//
//  UITableView+Model.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UITableView+Model.h"
#import "NSObject+SIQuickAssociated.h"
#import "UITableViewCell+Model.h"
#import "UITableView+FDTemplateLayoutCell.h"


/// Cell在TableViewCells中的索引
NSString *const kCellArrayIndex = @"cellIndex" ;

//**********分组需要的Key***********/
/// 分组的Model信息
NSString *const kGroupModels = @"groupModels" ;
/// 分组的header信息
NSString *const kGroupHeaderTitle = @"groupHeaderTitle" ;
/// 分组的fooder信息
NSString *const kGroupFooderTitle = @"groupFooderTitle" ;

#pragma mark >>>>>>>>> 关联对象Key  <<<<<<<<<
static char sDelegateKey ;
static char sDataSourceKey ;
static char modelskey ;
static char sectionEnableKey ;
static char sectionIndexTitlesKey ;
static char tableViewCellKey ;
static char tableViewCellsKey ;
static char autoLayoutKey ;
static char clearSelectedKey ;
static char tableViewCellStyleKey ;
static char containVcKey ;

static NSString *const cellIdentifier = @"CellID" ;

@interface UITableView (Delegate)<UITableViewDelegate,UITableViewDataSource>
@end

@implementation UITableView (Model)

#pragma mark >>>>>>>>>> 关联对象  <<<<<<<<<<<<<
// 设置代理
- (void)setSDelegate:(id<SITableViewDelegate>)sDelegate {
    [self si_quickWeaklyAssociateValue:sDelegate withKey:&sDelegateKey] ;
}
- (id<SITableViewDelegate>)sDelegate {
    return [self si_quickGetAssociatedValueForKey:&sDelegateKey] ;
}

// 设置数据源
- (void)setSDataSource:(id<SITableViewDataSource>)sDataSource {
    [self si_quickWeaklyAssociateValue:sDataSource withKey:&sDataSourceKey] ;
}
- (id<SITableViewDataSource>)sDataSource {
    return [self si_quickGetAssociatedValueForKey:&sDataSourceKey] ;
}

// 设置Vc
- (void)setContainVc:(UIViewController *)containVc {
    [self si_quickWeaklyAssociateValue:containVc withKey:&containVcKey] ;
}

- (UIViewController *)containVc {
    return [self si_quickGetAssociatedValueForKey:&containVcKey] ;
}

// 设置系统默认Cell的Style
- (void)setTableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle {
    [self si_quickWeaklyAssociateValue:@(tableViewCellStyle) withKey:&tableViewCellStyleKey] ;
}

- (UITableViewCellStyle)tableViewCellStyle {
    return [[self si_quickGetAssociatedValueForKey:&tableViewCellStyleKey] integerValue] ;
}

// 设置是否有选中自动清除的效果
- (void)setClearSelected:(BOOL)clearSelected {
    [self si_quickWeaklyAssociateValue:@(clearSelected) withKey:&clearSelectedKey] ;
}

- (BOOL)clearSelected {
    return [[self si_quickGetAssociatedValueForKey:&clearSelectedKey]boolValue] ;
}

// 设置是否进行自动计算高度
- (void)setAutoLayout:(BOOL)autoLayout {
    [self si_quickWeaklyAssociateValue:@(autoLayout) withKey:&autoLayoutKey] ;
}

- (BOOL)autoLayout {
    return [[self si_quickGetAssociatedValueForKey:&autoLayoutKey] boolValue] ;
}

// 设置是否开启分组
- (void)setSectionEnable:(BOOL)sectionEnable {
    [self si_quickWeaklyAssociateValue:@(sectionEnable) withKey:&sectionEnableKey] ;
}

- (BOOL)sectionEnable {
    return  [[self si_quickGetAssociatedValueForKey:&sectionEnableKey] boolValue] ;
}

// 设置分组右侧IndexTitle信息
- (void)setSectionIndexTitles:(NSArray<NSString *> *)sectionIndexTitles {
    [self si_quickAssociateValue:sectionIndexTitles withKey:&sectionIndexTitlesKey] ;
}

- (NSArray<NSString *> *)sectionIndexTitles {
    return [self si_quickGetAssociatedValueForKey:&sectionIndexTitlesKey] ;
}

#pragma mark >>>>>>> 注册CellIdentifier <<<<<<<
// 设置单个Cell信息
- (void)setTableViewCell:(id)tableViewCell {
    [self si_quickAssociateValue:tableViewCell withKey:&tableViewCellKey] ;
    // 生成Cell重用标识符
    NSString *cellId = [cellIdentifier stringByAppendingString:@"_0"] ;
    if ([tableViewCell isKindOfClass:[UINib class]]){
        [self registerNib:tableViewCell forCellReuseIdentifier:cellId] ;
    }else {
        [self registerClass:tableViewCell forCellReuseIdentifier:cellId] ;
    }
}

- (id)tableViewCell {
    return [self si_quickGetAssociatedValueForKey:&tableViewCellKey] ;
}

// 设置多个Cell的信息
- (void)setTableViewCells:(NSArray *)tableViewCells {
    [self si_quickAssociateValue:tableViewCells withKey:&tableViewCellsKey] ;
    for (NSInteger i = 0 ; i < tableViewCells.count ; i++) {
        // 生成Cell重用标识符
        NSString *cellId = [cellIdentifier stringByAppendingFormat:@"_%ld",i] ;
        id cell = tableViewCells[i] ;
        if ([cell isKindOfClass:[UINib class]]) {
            [self registerNib:cell forCellReuseIdentifier:cellId] ;
        }else{
            [self registerClass:cell forCellReuseIdentifier:cellId] ;
        }
    }
}

- (NSArray *)tableViewCells {
    return [self si_quickGetAssociatedValueForKey:&tableViewCellsKey] ;
}


#pragma mark >>>>>>>> 设置数据源 <<<<<<<<
// 设置数据源
- (void)setModels:(NSMutableArray *)models {
    NSMutableArray *array = models ;
    if([models isKindOfClass:[NSArray class]]){
        array = [NSMutableArray arrayWithArray:models] ;
    }
    self.dataSource = self ;
    self.delegate = self ;
    [self si_quickAssociateValue:array withKey:&modelskey] ;
}

- (NSMutableArray *)models {
    NSMutableArray *array = [self si_quickGetAssociatedValueForKey:&modelskey];
    if (array == nil) {
        array = [NSMutableArray array];
        self.models = array;
    }
    return array;
}

@end


@implementation UITableView (Delegate)

#pragma mark >>>>>>> UITableView DataSource  <<<<<<<<<<
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.sDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        return [self.sDataSource numberOfSectionsInTableView:tableView] ;
    }
    // 开启了分组
    if (tableView.sectionEnable){
        return tableView.models.count ;
    }
    return 1 ;
}

// 每组中有几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.sDataSource tableView:tableView numberOfRowsInSection:section] ;
    }
    if(tableView.sectionEnable){
        id models = tableView.models[section] ;
        // 如果二维模型是个数组
        if ([models isKindOfClass:[NSArray class]]){
            NSArray *array = (NSArray *)models ;
            return array.count ;
        }else if ([models isKindOfClass:[NSDictionary class]]){ // 包含title的字典模型
            NSArray *array = [models objectForKey:kGroupModels] ;
            return array.count ;
        }else{
            NSLog(@"***********请检查数据格式是否正确************") ;
            return 0 ;  // 不符合条件
        }
    }
    return tableView.models.count ;
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.sDataSource tableView:tableView cellForRowAtIndexPath:indexPath] ;
    }
    
    id model = [self modelForIndexPath:indexPath] ;
    NSInteger index = [self cellIndexForIndexPath:indexPath] ;
    
    if ([model isKindOfClass:[NSDictionary class]] && [model objectForKey:kCellArrayIndex]) {
        index = [[model objectForKey:kCellArrayIndex]integerValue] ;
    }
    NSString *cellId = [cellIdentifier stringByAppendingFormat:@"_%ld",index] ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId] ;
    
    if (!cell) {
        // 如果没有注册,默认根据CellStyle生成一个Cell
        cell = [[UITableViewCell alloc]initWithStyle:self.tableViewCellStyle reuseIdentifier:cellId] ;
    }
    
    // 信息传递
    cell.indexPath = indexPath ;
    cell.containVc = self.containVc ;
    cell.superTableView = self ;
    
    // 传入当前的数据源信息
    cell.model = model ;
    
    // 额外设置样式信息
    if ([self.sDataSource respondsToSelector:@selector(tableView:cellStyle:)]) {
        [self.sDataSource tableView:self cellStyle:cell] ;
    }
    
    return cell ;
}

// 头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([self.sDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        return [self.sDataSource tableView:tableView titleForHeaderInSection:section] ;
    }
    id model = self.models[section];
    if([model isKindOfClass:[NSDictionary class]]){
        id title = [model objectForKey:kGroupHeaderTitle] ;
        if ([title isKindOfClass:[NSString class]] ) {
            NSString *t = title ;
            return t.length > 0 ? t : nil ;
        }
    }

    return nil ;
}

// 尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if([self.sDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        return [self.sDataSource tableView:tableView titleForFooterInSection:section] ;
    }
    id model = self.models[section];
    if([model isKindOfClass:[NSDictionary class]]){
        id title = [model objectForKey:kGroupFooderTitle] ;
        if ([title isKindOfClass:[NSString class]] ) {
            NSString *t = title ;
            return t.length > 0 ? t : nil ;
        }
    }
    
    return nil ;
}

// 右侧索引标题
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.sDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.sDataSource sectionIndexTitlesForTableView:tableView] ;
    }
    return tableView.sectionIndexTitles ;
}

// 对应索引
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self.sDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]){
        return [self.sDataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index] ;
    }
    return index ;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]){
        return [self.sDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]){
        return [self.sDataSource tableView:tableView canEditRowAtIndexPath:indexPath] ;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]){
        return [self.sDataSource tableView:tableView canMoveRowAtIndexPath:indexPath] ;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if ([self.sDataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]){
        return [self.sDataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath] ;
    }
}




#pragma mark >>>>>>>>> UITableView Delegate  <<<<<<<<<<
// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView heightForRowAtIndexPath:indexPath] ;
    }
    id model = [self modelForIndexPath:indexPath] ;
    NSInteger index = [self cellIndexForIndexPath:indexPath] ;
    if([model isKindOfClass:[NSDictionary class]] && [model objectForKey:kCellArrayIndex]) {
        index = [[model objectForKey:kCellArrayIndex] integerValue] ;
    }
    NSString *cellId = [cellIdentifier stringByAppendingFormat:@"_%ld",index] ;
    
    // 自动计算高度
    if(self.autoLayout) {
        return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
            cell.fd_enforceFrameLayout = NO ;
            cell.model = model ;
        }] ;
    }
    
    // 计算交给Cell处理
    CGFloat height = 44.0f ; // 默认返回44
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId] ;
    if (cell) {
        height = [cell cellHeightInTableView:tableView withModel:model] ;
    }
    return height ;
}

// 头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if([self.sDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.sDelegate tableView:tableView heightForHeaderInSection:section] ;
    }
    return -1.0f ;
}

// 脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if([self.sDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
        return [self.sDelegate tableView:tableView heightForFooterInSection:section] ;
    }
    return -1.0f ;
}

// 组的头View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if([self.sDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.sDelegate tableView:self viewForHeaderInSection:section] ;
    }
    return nil ;
}


// 组的尾View
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.sDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.sDelegate tableView:self viewForFooterInSection:section] ;
    }
    return nil ;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath] ;
    }
    return 0.0f ;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath] ;
    }
    return nil ;
}

#pragma mark <<<<<<<<<<< Selected Delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.sDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView willSelectRowAtIndexPath:indexPath] ;
    }
    return indexPath ;
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        return [self.sDelegate tableView:self didSelectRowAtIndexPath:indexPath] ;
    }
    if (self.clearSelected) {
        [self deselectRowAtIndexPath:indexPath animated:YES] ;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
    if (cell.selectedAction) {
        cell.selectedAction(indexPath) ;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.sDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath] ;
    }
    return indexPath ;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        return [self.sDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath] ;
    }
}

#pragma mark <<<<<<<<<<< Edit Delegate
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.sDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath] ;
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        return [self.sDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath] ;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.sDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath] ;
    }
    return UITableViewCellEditingStyleNone ;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.sDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath] ;
    }
    return nil ;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.sDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath] ;
    }
    return NO ;
}

#pragma mark <<<<<<<<<<< Display Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([self.sDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]){
        return [self.sDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if([self.sDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]){
        return [self.sDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath  {
    if([self.sDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]){
        return [self.sDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section  {
    if([self.sDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]){
        return [self.sDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section  {
    if([self.sDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]){
        return [self.sDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

#pragma mark >>>>>>>> Scrollview Delegate  <<<<<<<<

- (void)scrollViewDidScroll:(UITableView *)tableView{
    if([self.sDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [self.sDelegate scrollViewDidScroll:tableView];
    }
}
- (void)scrollViewWillBeginDragging:(UITableView *)tableView {
    if([self.sDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [self.sDelegate scrollViewWillBeginDragging:tableView];
    }
}
- (void)scrollViewWillEndDragging:(UITableView *)tableView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    if([self.sDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]){
        [self.sDelegate scrollViewWillEndDragging:tableView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UITableView *)tableView willDecelerate:(BOOL)decelerate {
    if([self.sDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        [self.sDelegate scrollViewDidEndDragging:tableView willDecelerate:decelerate];
    }
}
- (void)scrollViewWillBeginDecelerating:(UITableView *)tableView {
    if([self.sDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]){
        [self.sDelegate scrollViewWillBeginDecelerating:tableView];
    }
}
- (void)scrollViewDidEndDecelerating:(UITableView *)tableView{
    if([self.sDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
        [self.sDelegate scrollViewDidEndDecelerating:tableView];
    }
}

#pragma mark >>>>>>>>>>>>> Private
- (id)modelForIndexPath:(NSIndexPath *)indexPath {
    if (self.models.count == 0)  return nil ;
    id model = nil ;
    if (self.sectionEnable) {
        id groupModel = self.models[indexPath.section] ;
        if([groupModel isKindOfClass:[NSArray class]]){ // 不带标题
            model = groupModel[indexPath.row] ;
        }else if([groupModel isKindOfClass:[NSDictionary class]]){ // 带标题的字典
            NSArray *array = [groupModel objectForKey:kGroupModels] ;
            if ([array isKindOfClass:[NSArray class]]) {
                model = array[indexPath.row] ;
            }
        }
    }else{
        model = self.models[indexPath.row] ;
    }
    return model ;
}

- (NSInteger)cellIndexForIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewCells) {
        if([self.sDataSource respondsToSelector:@selector(tableView:cellArrayIndexForIndexPath:)]){
            return [self.sDataSource tableView:self cellArrayIndexForIndexPath:indexPath] ;
        }else {
            id model = [self modelForIndexPath:indexPath] ;
            if ([model isKindOfClass:[NSDictionary class]]) {
                NSInteger index = [[model objectForKey:kCellArrayIndex] integerValue] ;
                if (index >= self.tableViewCells.count) {
                    index = 0 ;
                }
                return index ;
            }
        }
    }
    return 0 ;
}
@end
