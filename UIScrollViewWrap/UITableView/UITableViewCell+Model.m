//
//  UITableViewCell+Model.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UITableViewCell+Model.h"
#import "NSObject+SIQuickAssociated.h"

/// TitleView的内容
NSString *const kCellTitle = @"title" ;
/// DetailView的内容
NSString *const kCellDetail = @"detail" ;
/// ImageView的Image
NSString *const kCellImage = @"image" ;

/// AccessoryView
NSString *const kCellAccessoryView = @"accessoryView" ;
/// AccessoryType
NSString *const kCellAccessoryType = @"accessoryType" ;

/// title字体颜色
NSString *const kCellTitleColor = @"titleColor" ;
/// title字体
NSString *const kCellTitleFont = @"titleFont" ;
/// detail字体颜色
NSString *const kCellDetailColor = @"detailColor" ;
/// detail字体
NSString *const kCellDetailFont = @"detailFont" ;

/// 点击事件
NSString *const kCellSelected = @"selected" ;

#pragma mark --- 关联对象Key
static char modelKey ;
static char selectedActionKey ;
static char indexPathKey ;
static char containVcKey ;
static char superTableViewKey ;

@implementation UITableViewCell (Model)

#pragma mark --- 关联对象
- (void)setSelectedAction:(SelectedBlock)selectedAction {
    [self si_quickAssociateValue:selectedAction withKey:&selectedActionKey] ;
}

- (SelectedBlock)selectedAction {
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

- (void)setSuperTableView:(UITableView *)superTableView {
     [self si_quickWeaklyAssociateValue:superTableView withKey:&superTableViewKey] ;
}

- (UITableView *)superTableView {
    return [self si_quickGetAssociatedValueForKey:&superTableViewKey] ;
}

#pragma mark --- 模型操作
// 默认模型格式化方法
- (void)setModel:(id)model {
    [self si_quickAssociateValue:model withKey:&modelKey] ;
    if(model) {
        // 如果只有字符串,仅仅对Title赋值
        if ([model isKindOfClass:[NSString class]]) {
            self.textLabel.text = model ;
        }else if ([model isKindOfClass:[NSDictionary class]]){
            NSDictionary *modelDic = model ;
            // 处理Title
            id title = [modelDic objectForKey:kCellTitle] ;
            if ([title isKindOfClass:[NSString class]]) {
                self.textLabel.text = title ;
            }
            
            // 处理Detail
            id detail = [modelDic objectForKey:kCellDetail] ;
            if ([detail isKindOfClass:[NSString class]]) {
                self.detailTextLabel.text = detail ;
            }
            
            // 处理图片
            id image = [modelDic objectForKey:kCellImage] ;
            if(image){
                if([image isKindOfClass:[NSString class]]){
                    self.imageView.image = [UIImage imageNamed:image] ;
                }else if ([image isKindOfClass:[UIImage class]]){
                    self.imageView.image = image ;
                }
            }
            
            // accessoryView
            id accessoryView = [modelDic objectForKey:kCellAccessoryView] ;
            if ([accessoryView isKindOfClass:[UIView class]]) {
                self.accessoryView = accessoryView ;
            }
            
            // accessoryType
            id accessoryType = [modelDic objectForKey:kCellAccessoryType] ;
            if([accessoryType isKindOfClass:[NSNumber class]]) {
                NSInteger type = [accessoryType integerValue] ;
                self.accessoryType = type ;
            }
            
            // titleColor
            id titleColor = [modelDic objectForKey:kCellTitleColor] ;
            if([titleColor isKindOfClass:[UIColor class]]){
                self.textLabel.textColor = titleColor ;
            }
            
            // titleFont
            id titleFont = [modelDic objectForKey:kCellTitleFont] ;
            if ([titleFont isKindOfClass:[UIFont class]]){
                self.textLabel.font = titleFont ;
            }
            
            // detailColor
            id detailColor = [modelDic objectForKey:kCellDetailColor] ;
            if([detailColor isKindOfClass:[UIColor class]]){
                self.detailTextLabel.textColor = detailColor ;
            }
            
            // detailFont
            id detailFont = [modelDic objectForKey:kCellDetailFont] ;
            if([detailFont isKindOfClass:[UIFont class]]){
                self.detailTextLabel.font = detailFont ;
            }
            
            // SelectedBlock
            SelectedBlock block = [modelDic objectForKey:kCellSelected] ;
            if (block) {
                self.selectedAction = block ;
            }
        }
    }
}

- (id)model {
    return [self si_quickGetAssociatedValueForKey:&modelKey] ;
}

- (CGFloat)cellHeightInTableView:(UITableView *)tableView withModel:(id)model {
    return 44.0 ;
}

@end
