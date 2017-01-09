//
//  ViewController.m
//  MyTools
//
//  Created by SGX on 17/1/4.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "ViewController.h"
#import "Quantz2D_VC.h"
#import "VisualEffectVC.h"
#import "CaculatorController.h"
#import "CityPickerVC.h"
#import "CollectionView_test.h"
#import "UIView_Convert.h"
#import "SearchVC.h"
#import "RegularExpressionVC.h"
#import "RandomFllowersVC.h"
#import "HoleGuide_test.h"
#import "CoreAnimation_test.h"
#import "Alert_test.h"
#import "PhotosPreviewVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (strong, nonatomic) UISearchController *searchVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgColor;
    self.dataSource = [NSMutableArray array];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:NSStringFromClass([Quantz2D_VC class])];
    [arr addObject:NSStringFromClass([VisualEffectVC class])];
    [arr addObject:NSStringFromClass([CaculatorController class])];
    [arr addObject:NSStringFromClass([CityPickerVC class])];
    [arr addObject:NSStringFromClass([CollectionView_test class])];
    [arr addObject:NSStringFromClass([UIView_Convert class])];
    [arr addObject:NSStringFromClass([SearchVC class])];
    [arr addObject:NSStringFromClass([RegularExpressionVC class])];
    [arr addObject:NSStringFromClass([RandomFllowersVC class])];
    [arr addObject:NSStringFromClass([HoleGuide_test class])];
    [arr addObject:NSStringFromClass([CoreAnimation_test class])];
    [arr addObject:NSStringFromClass([Alert_test class])];
    [arr addObject:NSStringFromClass([PhotosPreviewVC class])];

    [self.dataSource addObject:arr];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class  newVc = NSClassFromString(_dataSource[indexPath.section][indexPath.row]);
    UIViewController *vc = [[newVc alloc] init];
    vc.title = _dataSource[indexPath.section][indexPath.row];
    if (!vc) {
        NSLog(@"no no no");
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
