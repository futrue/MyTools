//
//  DropDownMenuVC.m
//  MyTools
//
//  Created by SGX on 17/1/17.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "DropDownMenuVC.h"
#import "YHDropDownMenu.h"

@interface DropDownMenuVC ()<YHDropDownMenuDataSource, YHDropDownMenuDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *citys;
@property (nonatomic, copy) NSArray *ages;
@property (nonatomic, copy) NSArray *genders;
@property (nonatomic, copy) NSArray *originalArray;
@property (nonatomic, copy) NSArray *results;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DropDownMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"navbar_title", @"the navigation bar title");
    self.citys = @[NSLocalizedString(@"city1", @"city1"),
                   NSLocalizedString(@"city2", @"city2"),
                   NSLocalizedString(@"city3", @"city3")];
    self.ages = @[NSLocalizedString(@"age", @"age"), @"20", @"30"];
    self.genders = @[NSLocalizedString(@"gender1", @"gender1"),
                     NSLocalizedString(@"gender2", @"gender2"),
                     NSLocalizedString(@"gender3", @"gender3")];
    NSInteger count = self.citys.count + self.ages.count + self.genders.count;
    for (int i = 0; i < count; i++) {
        
    }
    self.originalArray = @[[NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[1],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[1],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[2],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[1],self.ages[2],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[1],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[1],self.genders[2]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[2],self.genders[1]],
                           [NSString stringWithFormat:@"%@_%@_%@",self.citys[2],self.ages[2],self.genders[2]]];
    self.results = self.originalArray;
    
    YHDropDownMenu *menu = [[YHDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    self.tableView = ({
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, screenSize.width, screenSize.height - 104)];
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfColumnsInMenu:(YHDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(YHDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return 3;
}
- (BOOL)menu:(YHDropDownMenu *)menu animateOfRowsInColumn:(NSInteger)column
{
    switch (column) {
        case 0:
            return YES;
            break;
        case 1:
            return YES;
            break;
        case 2:
            return NO;
            break;
        case 3:
            return YES;
            break;
        default:
            return NO;
            break;
    }
    
}

- (NSString *)menu:(YHDropDownMenu *)menu ImageNameOfRowsInColumn:(NSInteger)column
{
    switch (column) {
        case 0:
            return  @"矩形-5@3x.png";
            break;
        case 1:
            return nil;
            break;
        case 2:
            return nil;
            break;
        case 3:
            return nil;
            break;
        default:
            return nil;
            break;
    }
    
}
- (NSString *)menu:(YHDropDownMenu *)menu titleForRowAtIndexPath:(YHIndexPath *)indexPath {
    switch (indexPath.column) {
        case 0: return self.citys[indexPath.row];
            break;
        case 1: return self.genders[indexPath.row];
            break;
        case 2: return self.ages[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(YHDropDownMenu *)menu didSelectRowAtIndexPath:(YHIndexPath *)indexPath {
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
    NSLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
    NSString *title = [menu titleForRowAtIndexPath:indexPath];
    
    static NSString *prediStr1 = @"SELF LIKE '*'",
    *prediStr2 = @"SELF LIKE '*'",
    *prediStr3 = @"SELF LIKE '*'";
    switch (indexPath.column) {
        case 0:{
            if (indexPath.row == 0) {
                prediStr1 = @"SELF LIKE '*'";
            } else {
                prediStr1 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                prediStr2 = @"SELF LIKE '*'";
            } else {
                prediStr2 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                prediStr3 = @"SELF LIKE '*'";
            } else {
                prediStr3 = [NSString stringWithFormat:@"SELF CONTAINS '%@'", title];
            }
        }
            
        default:
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ AND %@ AND %@",prediStr1,prediStr2,prediStr3]];
    
    self.results = [self.originalArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.results[indexPath.row];
    return cell;
}


@end
