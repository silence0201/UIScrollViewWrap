//
//  CustomCollectionViewCell.m
//  UIScrollViewWrapDemo
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "UICollectionViewCell+Model.h"

@implementation CustomCollectionViewCell{
    UILabel *_label ;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:_label];
    }
    return self;
}

- (void)setModel:(id)model {
    _label.text = model ;
}

- (CGSize)cellSizeInCollectionView:(UICollectionView *)collectionView withModel:(id)model {
    return CGSizeMake(80, 80) ;
}



@end
