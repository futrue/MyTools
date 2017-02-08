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
    [self.dataSource addObject:arr];
    
    NSMutableArray *arr2 = [NSMutableArray array];
    [arr2 addObject:NSStringFromClass([PhotosPreviewVC class])];
    [arr2 addObject:NSStringFromClass([CoreAnimation_test class])];
    [arr2 addObject:NSStringFromClass([CAAnimation_test class])];
    [arr2 addObject:NSStringFromClass([Alert_test class])];
    [arr2 addObject:NSStringFromClass([YYLabel_testVC class])];
    [arr2 addObject:NSStringFromClass([StackView_test class])];
    [arr2 addObject:NSStringFromClass([Masonry_test class])];
    [arr2 addObject:NSStringFromClass([Date_testVC class])];
    [arr2 addObject:NSStringFromClass([Wave_DropDown class])];
    [arr2 addObject:NSStringFromClass([SystemActions_test class])];
    [self.dataSource addObject:arr2];
    
    NSMutableArray *arr3 = [NSMutableArray array];
    [arr3 addObject:NSStringFromClass([Slider_testVC class])];
    [arr3 addObject:NSStringFromClass([DropDownMenuVC class])];
    [arr3 addObject:NSStringFromClass([DropDownMenuVC2 class])];
    [arr3 addObject:NSStringFromClass([WaterWaveVC class])];
    [arr3 addObject:NSStringFromClass([SQLite_test class])];
    [arr3 addObject:NSStringFromClass([CustomButton_test class])];
    [arr3 addObject:NSStringFromClass([CustomButton_test2 class])];
    [arr3 addObject:NSStringFromClass([Contact_test class])];
    [arr3 addObject:NSStringFromClass([LyricLabelVC class])];
    [arr3 addObject:NSStringFromClass([RatingVC class])];
    [self.dataSource addObject:arr3];
    
    NSMutableArray *arr4 = [NSMutableArray array];
    [arr4 addObject:NSStringFromClass([Slider_testVC class])];
    [self.dataSource addObject:arr4];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
    if ([_dataSource[indexPath.section][indexPath.row] isEqualToString:@"PhotosPreviewVC"]) {
        NSLog(@"有crash");
        return;
    }
    vc.view.backgroundColor = COLOR_BACKGROUND;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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

@end
