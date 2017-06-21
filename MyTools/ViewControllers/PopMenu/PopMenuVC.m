//
//  PopMenuVC.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/20.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "PopMenuVC.h"
//#import "Toolbar.h"
#import "PopMeneData.h"
#import "CategoryCell.h"

typedef NS_ENUM(NSInteger,ExpandType) {
    ExpandTypeFirst, // 一级目录
    ExpandTypeSecond,// 二级目录
};

@interface PopMenuVC ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, strong)CAGradientLayer * gradient;// 渐变层

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataSource;
/** 展开层级 */
@property (nonatomic, assign) ExpandType expandType;
/** 由于是模拟数据，所以得记录选择要展开的二级目录的key，若是从网络请求下来的数据就不必如此了 */
@property (nonatomic, strong) NSString *expandedItem;

@end

@implementation PopMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     思路： 模拟的一个数据源，一级目录为最最外层的key，二级目录为key对应的value
           因为这里使用一个tableview做，所以点击分类后记录并刷新表格以达到目的
     
           ☆☆☆☆☆ 表的数据和UI都是通过展开目录层次来判断的 ☆☆☆☆☆
     */
    self.dataSource = [PopMeneData dataSource];
    self.expandType = ExpandTypeFirst;
    self.tableView.frame = CGRectMake(0, 64.f, self.view.width, self.view.height);
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.expandType == ExpandTypeFirst) {
        // 一级目录 的 “所有分类“是一个section ， 加上数据的个数
        return 1 + [self.dataSource count];
    }  else {
        // 二级目录 的 “返回上一级“ 加上 已选中的 section = 2
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.expandType == ExpandTypeFirst) {
        return 1;
    }  else {
        if (section == 0) {
            return 1;
        } else {
            NSInteger itemCount = 0;
            for (NSDictionary *dic in self.dataSource) {
                NSArray *items = [dic valueForKey:self.expandedItem];
                if ([items count]) {
                    itemCount =  [items count];
                }
            }
            return itemCount;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSString *title;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (self.expandType == ExpandTypeFirst) {
        if (section == 0) {
            title = @"所有分类";
        } else {
            NSDictionary *dic = self.dataSource[section - 1];
            title = [[dic allKeys] firstObject];
        }
    } else {
        if (section == 0) {
            title = @"返回上一级";
        } else {
            for (NSDictionary *dic in self.dataSource) {
                NSArray *items = [dic valueForKey:self.expandedItem];
                if ([items count]) {
                    title =  items[row];
                }
            }
            title = title;
        }
    }
    cell.title = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    if (self.expandType == ExpandTypeFirst) {
        if (section == 0) {
            NSLog(@"点击--所有分类");
        } else {
            self.expandedItem = [[self.dataSource[section - 1] allKeys] firstObject];
            self.expandType = ExpandTypeSecond;
            [self.tableView reloadData];
        }
    } else {
        if (section == 0) {
            NSLog(@"点击--返回上一级");
            self.expandType = ExpandTypeFirst;
            [self.tableView reloadData];
        } else {
            CategoryCell *cell = (CategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSString *selectedItem = cell.title;
            // 这里做一个数据回调（代理或者block皆可），回去刷新列表
            NSLog(@"最终选择了：%@",selectedItem);
        }
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
    }
    return _tableView;
}




#pragma mark - 颜色渐变
//-(void) setUI{
//    // 设置背景渐变
//    //  创建 CAGradientLayer 对象
//    _gradient = [CAGradientLayer layer];
//    //  设置 gradientLayer 的 Frame
//    _gradient.frame = CGRectMake(0, 64.f,[UIScreen mainScreen].bounds.size.width, 220);
//    //  创建渐变色数组，需要转换为CGColor颜色
//    _gradient.colors = @[(id)[UIColor orangeColor].CGColor,
//                         (id)[UIColor whiteColor].CGColor];
//
//    //  设置三种颜色变化点，取值范围 0.0~1.0
//    _gradient.locations = @[@(0.1f) ,@(0.0f)];
//    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
//    _gradient.startPoint = CGPointMake(0, 0);
//    _gradient.endPoint = CGPointMake(0, 1);
//    //  添加渐变色到创建的 UIView 上去
//    [self.view.layer addSublayer:_gradient];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
