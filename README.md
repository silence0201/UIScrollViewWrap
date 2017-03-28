# UIScrollViewWrap

基于`Model`数据对`UITableView`和`UICollectionView`进行简单封装

## 安装
### 1. 手动安装
下载项目,导入`UIScrollViewWrap`目录导入项目中.
> Common: 一个公用的关联对象的方法  
> UITableView: UITableView封装代码  
> UICollection: UICollection封装代码

如果需要`UITableView`的封装,只需导入`Common`和`UITableView`文件夹到项目中  
如果需要`UICollection `的封装,只需导入`Common`和`UICollection `文件夹到项目中

## 用法

1. 导入头文件

	```objective-c
	#import "UITableViewWrap.h"
	#import "UICollectionWrap.h"
	```

2. 构建数据源

	```objective-c
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
	```
	
3. 赋值数据源

	```objective-c
	self.tableView.models = array ;
	```
4. 如果使用代理,不要使用系统的,需要使用下面的代替

	```objective-c
	@property (nonatomic,weak) id<SITableViewDelegate> sDelegate ;
	@property (nonatomic,weak) id<SITableViewDataSource> sDataSource ;
	```
5. 自定集成了[`UITableView+FDTemplateLayoutCell`](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)实现了自动计算高度,只需要设置下面进行开启

	```objective-c
	/// 是否支持Cell自动计算高度,默认不支持
	@property (nonatomic,assign) BOOL autoLayout ;
	```

6. 更多使用方法查看`Demo`

## UIScrollViewWrap
UIScrollViewWrap is available under the MIT license. See the LICENSE file for more info.
