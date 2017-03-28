//
//  SystemStyleViewController.m
//  UIScrollViewWrapDemo
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SystemStyleViewController.h"
#import "UITableViewWrap.h"
#import "UIColor+Random.h"
#import "UIImage+Effect.h"

@interface SystemStyleViewController ()

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation SystemStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
    
    self.tableView.tableViewCellStyle = UITableViewCellStyleValue1 ;
    
    NSMutableArray *array = [NSMutableArray array] ;
    for (NSInteger i = 0 ; i < 10 ; i++){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
        [dic setObject:@"我是标题" forKey:kCellTitle] ;
        [dic setObject:@"我是详情" forKey:kCellDetail] ;
        [dic setObject:[UIColor randomColor] forKey:kCellTitleColor] ;
        [dic setObject:[UIColor randomColor] forKey:kCellDetailColor] ;
        [dic setObject:[UIFont systemFontOfSize:10] forKey:kCellDetailFont] ;
        if(i % 2 == 0){
            [dic setObject:@"Pic" forKey:kCellImage] ;
            [dic setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:kCellAccessoryType] ;
        }else{
            UIImage *image = [UIImage imageNamed:@"Pic"] ;
            [dic setObject:[image imageByBlurDark] forKey:kCellImage] ;
            [dic setObject:@(UITableViewCellAccessoryDetailButton) forKey:kCellAccessoryType] ;
        }
        [dic setObject:^(NSIndexPath *indexPath){ NSLog(@"选中了%ld行",indexPath.row); }
                forKey:kCellSelected] ;
        
        [array addObject:dic] ;
    }
    self.tableView.models = array ;
    
    self.tableView.clearSelected = YES ;
    [self.view addSubview:self.tableView] ;
    
}


@end
