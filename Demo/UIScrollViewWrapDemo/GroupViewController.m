//
//  GroupViewController.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "GroupViewController.h"
#import "UITableViewWrap.h"

@interface GroupViewController ()

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped] ;
    self.tableView.tableViewCellStyle = UITableViewCellStyleValue1 ;
    self.tableView.sectionEnable = YES ;
    self.tableView.clearSelected = YES ;
    
    NSMutableArray <NSString *> *titleIndex = [NSMutableArray array] ;
    
    NSMutableArray *array = [NSMutableArray array] ;
    for (NSInteger i = 0 ; i < 10 ; i ++){
        NSString *str = [NSString stringWithFormat:@"%ld",i] ;
        [titleIndex addObject:str] ;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
        NSString *titleHeader = [NSString stringWithFormat:@"第%ld组的头",i] ;
        NSString *titleFooder = [NSString stringWithFormat:@"第%ld组的尾",i] ;
        
        [dic setObject:titleHeader forKey:kGroupHeaderTitle] ;
        [dic setObject:titleFooder forKey:kGroupFooderTitle] ;
        
        NSMutableArray *models = [NSMutableArray array] ;
        
        for (NSInteger j = 0 ; j<10;j++){
            NSMutableDictionary *d = [NSMutableDictionary dictionary] ;
            [d setObject:[NSString stringWithFormat:@"%ld",j] forKey:kCellTitle] ;
            [d setObject:[NSString stringWithFormat:@"%ld",i] forKey:kCellDetail] ;
            [d setObject:@(UITableViewCellAccessoryDisclosureIndicator)forKey:kCellAccessoryType] ;
            [d setObject:^(NSIndexPath *indexPath){ NSLog(@"%ld--%ld",indexPath.section,indexPath.row); }
                  forKey:kCellSelected] ;
            [models addObject:d] ;
        }
        [dic setObject:models forKey:kGroupModels] ;
        
        [array addObject:dic] ;
    }
    self.tableView.models = array ;
    self.tableView.sectionIndexTitles = titleIndex ;
    
    [self.view addSubview:self.tableView] ;
}

@end
