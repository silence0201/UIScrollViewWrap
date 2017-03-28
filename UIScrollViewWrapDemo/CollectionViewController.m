//
//  CollectionViewController.m
//  UIScrollViewWrapDemo
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "CollectionViewController.h"
#import "UICollectionWrap.h"
#import "CustomCollectionViewCell.h"

@interface CollectionViewController ()<SICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView ;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init] ;
    flow.itemSize = CGSizeMake(80, 80) ;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow] ;
    self.collectionView.collectionCell = [CustomCollectionViewCell class] ;
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    self.collectionView.sectionEnable = YES ;
    self.collectionView.sDelegate = self ;
    NSMutableArray *indexTuitle = [NSMutableArray array] ;
    NSMutableArray *array = [NSMutableArray array] ;
    for (NSInteger i = 0 ; i < 10 ; i++){
        NSString *str = [NSString stringWithFormat:@"%ld",i] ;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
        [dic setObject:@[@"第1条",@"第2条",@"第3条",@"第4条",@"第5条",@"第6条",@"第7条",@"第8条",@"第9条",@"第10条",@"第11条"] forKey:kCollectionGroupModels] ;
        [array addObject:dic] ;
        [indexTuitle addObject:str] ;
    }
    
    self.collectionView.models = array ;
    
    [self.view addSubview:self.collectionView] ;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 5, 15) ;
}

@end
