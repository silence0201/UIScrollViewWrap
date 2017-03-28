//
//  CellClassViewController.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "CellClassViewController.h"
#import "CustomTableViewCell.h"
#import "UITableViewWrap.h"

@interface CellClassViewController ()

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation CellClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
    
    self.tableView.tableViewCells = @[[UITableViewCell class],[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil]] ;
    
    
    NSMutableArray *array = [NSMutableArray array] ;
    for (NSInteger i = 0 ; i < 10 ; i++){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
        [dic setObject:@"我是标题" forKey:kCellTitle] ;
        [dic setObject:@"我是详情" forKey:kCellDetail] ;
        if(i % 2 == 0){
            [dic setObject:@(0) forKey:kCellArrayIndex] ;
            [dic setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:kCellAccessoryType] ;
            [dic setObject:^(NSIndexPath *indexPath){ NSLog(@"选中了%ld行",indexPath.row); }
                    forKey:kCellSelected] ;
        }else{
            [dic setObject:@(1) forKey:kCellArrayIndex] ;
        }
        [array addObject:dic] ;
    }
    
    
    self.tableView.models = array ;
    
    [self.view addSubview:self.tableView] ;
}


@end
