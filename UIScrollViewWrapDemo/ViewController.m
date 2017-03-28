//
//  ViewController.m
//  UIScrollViewWrapDemo
//
//  Created by Silence on 2017/3/27.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewWrap.h"

@interface ViewController ()

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
    
    NSMutableArray *array = [NSMutableArray array] ;
    for (NSInteger i = 0 ; i<20;i++){
        NSString *str = [NSString stringWithFormat:@"第%02ld条",i] ;
        [array addObject:str] ;
    }
    
    self.tableView.models = array ;
    [self.view addSubview:self.tableView] ;
    
}

@end
