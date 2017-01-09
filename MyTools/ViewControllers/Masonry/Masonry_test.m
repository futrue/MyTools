//
//  Masonry_test.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Masonry_test.h"

#import "BasicController.h"
#import "EqualMarginController.h"
#import "UpdateConstraintsController.h"
#import "ScrollViewController.h"
#import "TableViewController.h"

@interface Masonry_test ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation Masonry_test

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"HowToUseMasonry";
    
    NSMutableArray *itemArray = [NSMutableArray array];
    [itemArray addObject:@"基本使用"];
    [itemArray addObject:@"等间隙排布"];
    [itemArray addObject:@"更新约束动画"];
    [itemArray addObject:@"ScrollView"];
    [itemArray addObject:@"TableView"];
    
    self.titleArray = [itemArray copy];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            BasicController *basicVC = [BasicController new];
            basicVC.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:basicVC animated:YES];
        }
            break;
        case 1:
        {
            EqualMarginController *equalVC = [EqualMarginController new];
            equalVC.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:equalVC animated:YES];
        }
            break;
        case 2:
        {
            UpdateConstraintsController *updateVC = [UpdateConstraintsController new];
            updateVC.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:updateVC animated:YES];
        }
            break;
        case 3:
        {
            ScrollViewController *scrollViewVC = [ScrollViewController new];
            scrollViewVC.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:scrollViewVC animated:YES];
        }
            break;
        case 4:
        {
            TableViewController *tableViewVC = [TableViewController new];
            tableViewVC.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:tableViewVC animated:YES];
        }
            break;
        default:
            break;
    }
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
