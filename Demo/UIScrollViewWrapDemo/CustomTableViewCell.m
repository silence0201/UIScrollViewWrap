//
//  CustomTableViewCell.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "UITableViewWrap.h"

@interface CustomTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(id)model {
    self.label.text = [model objectForKey:kCellTitle] ;
}

// 自定义高度
- (CGFloat)cellHeightInTableView:(UITableView *)tableView withModel:(id)model {
    return 70 ;
}

@end
