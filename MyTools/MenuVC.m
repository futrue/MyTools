//
//  MenuVC.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "MenuVC.h"

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
#import "CAAnimation_test.h"
#import "Alert_test.h"
#import "PhotosPreviewVC.h"
#import "YYLabel_testVC.h"
#import "StackView_test.h"
#import "Masonry_test.h"
#import "Date_testVC.h"
#import "Wave&DropDown.h"
#import "SystemActions_test.h"
#import "CustomButton_test.h"
#import "CustomButton_test2.h"
#import "Slider_testVC.h"
#import "DropDownMenuVC.h"
#import "DropDownMenuVC2.h"
#import "WaterWaveVC.h"
#import "SQLite_test.h"
#import "Contact_test.h"
#import "LyricLabelVC.h"
#import "RatingVC.h"
#import "GroupNetwork_testVC.h"
#import "Layoutsubviews_test.h"
#import "TestViewController.h"
#import "PopMenuVC.h"
#import "ClipImageVC.h"
#import "ExpandTest.h"
#import "KVC_Test.h"
#import "TableViewTransformVC.h"
#import "AttributedLabel_test.h"
#import "BezierPath_Test.h"
#import "UIViewTouchVC.h"

@interface MenuVC ()<UISearchResultsUpdating,UISearchControllerDelegate>


/**
  与 SearchVC 结合用
 */
@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, strong) NSMutableArray *filteredCities;
@property (nonatomic, strong) NSArray *items;

@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroups];
    self.title = @"目录";
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
}

// 在viewWillDisappear中要将UISearchController移除, 否则切换到下一个View中, 搜索框仍然会有短暂的存在.
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchVC.active) {
        self.searchVC.active = NO;
        [self.searchVC.searchBar removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        if (self.searchVC.active) {
            return 1;
        } else {
            return self.groups.count;
        }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchVC.active) {
        return  [super tableView:tableView numberOfRowsInSection:section];//self.items.count;
    } else {
        return self.filteredCities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 根据UISearchController的active属性来判断cell中的内容
    if (!self.searchVC.active) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = self.filteredCities[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchVC.active) {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        // 创建跳转控制器
        NSString *destClass = self.filteredCities[indexPath.row];
        UIViewController *vc = [[NSClassFromString(destClass) alloc] init];
        if (vc == nil) {
            return;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filteredCities removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchVC.searchBar.text];
    self.filteredCities = [[self.items filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)refresh {
    [self.groups removeAllObjects];
    [self addGroups];
    [self.tableView reloadData];
}

- (void)addGroups {
    [self setUpFastEntryGroup];
    [self setUpViewLayoutGroup];
    [self setUpAnimatonsGroup];
    [self setUpSpecialsGroup];
    [self setUpToolsGroup];
    [self setUpSkillsGroup];
    [self setUpOthersGroup];
}

- (void)setUpFastEntryGroup {
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    SettingItem *item = [SettingItem itemWithTitle:@"TestViewController"];
    item.destVcClass = [TestViewController class];
    item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [group.items addObject:item];
    group.footerHeight = 50.f;
    [self.groups addObject:group];
}

- (void)setUpViewLayoutGroup
{
    // 创建组模型
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.headerTitle = @"视图布局类";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:NSStringFromClass([Layoutsubviews_test class])];
    [array addObject:NSStringFromClass([TableViewTransformVC class])];
    [array addObject:NSStringFromClass([Quantz2D_VC class])];
    [array addObject:NSStringFromClass([StackView_test class])];
    [array addObject:NSStringFromClass([Masonry_test class])];
    [array addObject:NSStringFromClass([UIView_Convert class])];
    [array addObject:NSStringFromClass([BezierPath_Test class])];

    for (int i = 0; i < array.count; i ++) {
        // 创建行模型
        SettingItem *item = [SettingItem itemWithTitle:array[i]];
        item.destVcClass = NSClassFromString(array[i]);
        item.operation = ^(NSIndexPath *indexPath){
            NSLog(@"section : %li row:%li",indexPath.section,indexPath.row);
        };
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}

- (void)setUpAnimatonsGroup
{
    // 创建组模型
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.headerTitle = @"视图动画类";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:NSStringFromClass([CoreAnimation_test class])];
    [array addObject:NSStringFromClass([CAAnimation_test class])];
    for (int i = 0; i < array.count; i ++) {
        // 创建行模型
        SettingItem *item = [SettingItem itemWithTitle:array[i]];
        item.destVcClass = NSClassFromString(array[i]);
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}

- (void)setUpSpecialsGroup
{
    // 创建组模型
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.headerTitle = @"视图特效类";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:NSStringFromClass([VisualEffectVC class])];
    [array addObject:NSStringFromClass([WaterWaveVC class])];
    [array addObject:NSStringFromClass([Wave_DropDown class])];
    [array addObject:NSStringFromClass([RatingVC class])];
    [array addObject:NSStringFromClass([CustomButton_test class])];
    [array addObject:NSStringFromClass([CustomButton_test2 class])];
    [array addObject:NSStringFromClass([LyricLabelVC class])];
    [array addObject:NSStringFromClass([CityPickerVC class])];
    [array addObject:NSStringFromClass([CollectionView_test class])];
    [array addObject:NSStringFromClass([RandomFllowersVC class])];
    [array addObject:NSStringFromClass([HoleGuide_test class])];
    [array addObject:NSStringFromClass([Alert_test class])];

    for (int i = 0; i < array.count; i ++) {
        // 创建行模型
        SettingItem *item = [SettingItem itemWithTitle:array[i]];
        item.destVcClass = NSClassFromString(array[i]);
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}

- (void)setUpToolsGroup
{
    // 创建组模型
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.headerTitle = @"便捷工具类";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:NSStringFromClass([Slider_testVC class])];
    [array addObject:NSStringFromClass([DropDownMenuVC class])];
    [array addObject:NSStringFromClass([DropDownMenuVC2 class])];
    [array addObject:NSStringFromClass([Contact_test class])];
    [array addObject:NSStringFromClass([PhotosPreviewVC class])];
    [array addObject:NSStringFromClass([PopMenuVC class])];
    [array addObject:NSStringFromClass([ClipImageVC class])];
    for (int i = 0; i < array.count; i ++) {
        // 创建行模型
        SettingItem *item = [SettingItem itemWithTitle:array[i]];
        item.destVcClass = NSClassFromString(array[i]);
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}

- (void)setUpSkillsGroup
{
    // 创建组模型
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.headerTitle = @"技能提升类";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:NSStringFromClass([CaculatorController class])];
    [array addObject:NSStringFromClass([SQLite_test class])];
    [array addObject:NSStringFromClass([Date_testVC class])];
    [array addObject:NSStringFromClass([KVC_Test class])];
    [array addObject:NSStringFromClass([UIViewTouchVC class])];
    [array addObject:NSStringFromClass([RegularExpressionVC class])];
    for (int i = 0; i < array.count; i ++) {
        // 创建行模型
        SettingItem *item = [SettingItem itemWithTitle:array[i]];
        item.destVcClass = NSClassFromString(array[i]);
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}

- (void)setUpOthersGroup
{
    // 创建组模型
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = [NSMutableArray array];
    group.headerTitle = @"其他 | 三方";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:NSStringFromClass([GroupNetwork_testVC class])];
    [array addObject:NSStringFromClass([ExpandTest class])];
    [array addObject:NSStringFromClass([AttributedLabel_test class])];
    [array addObject:NSStringFromClass([YYLabel_testVC class])];
    [array addObject:NSStringFromClass([SystemActions_test class])];
    [array addObject:NSStringFromClass([SearchVC class])];
    
    for (int i = 0; i < array.count; i ++) {
        // 创建行模型
        SettingItem *item = [SettingItem itemWithTitle:array[i]];
        item.destVcClass = NSClassFromString(array[i]);
        [group.items addObject:item];
    }
    [self.groups addObject:group];
}


/*
//增加单元格圆角边格
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        CGFloat cornerRadius = 10.f;
        
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        
        
        
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        NSLog(@"滚动到了顶部");
        // 滚动到了顶部
    }
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        NSLog(@"滚动到了底部");
        // 滚动到了底部
    }
}
*/

#pragma mark - Lazy
- (NSArray *)items {
    if (!_items) {
        NSMutableArray *array = @[].mutableCopy;
        for (SettingGroup *group in self.groups) {
            for (SettingItem *item in group.items) {
                [array addObject:[item.destVcClass className]];
            }
        }
        _items = array;
    }
    return _items;
}

- (UISearchController *)searchVC {
    if (!_searchVC) {
        //        _searchVC = [[UISearchController alloc] initWithSearchResultsController:self];// 不能写self，否则会crash
        //        _searchVC = [[UISearchController alloc] init]; // 直接init不行，这样没有searchBar
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        _searchVC.searchResultsUpdater = self;
        _searchVC.delegate = self;
        _searchVC.dimsBackgroundDuringPresentation = NO;
        [_searchVC.searchBar sizeToFit];
        // searchBar 下面的排序按钮
//        _searchVC.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"BOY",@"GIRL",@"ALL",nil];
        
        //        _searchVC.searchBar.backgroundColor = UIColorFromHex(0xdcdcdc);
        self.tableView.tableHeaderView = _searchVC.searchBar;
    }
    return _searchVC;
}

//测试UISearchController的执行过程

- (void)willPresentsearchVController:(UISearchController *)searchVController
{
    NSLog(@"willPresentsearchVController");
}

- (void)didPresentsearchVController:(UISearchController *)searchVController
{
    NSLog(@"didPresentsearchVController");
}

- (void)willDismisssearchVController:(UISearchController *)searchVController
{
    NSLog(@"willDismisssearchVController");
}

- (void)didDismisssearchVController:(UISearchController *)searchVController
{
    NSLog(@"didDismisssearchVController");
}

- (void)presentsearchVController:(UISearchController *)searchVController
{
    NSLog(@"presentsearchVController");
}

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
