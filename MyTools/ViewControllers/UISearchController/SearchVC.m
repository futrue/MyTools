//
//  SearchVC.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()<UISearchResultsUpdating,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISearchController *searchC;
@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) NSMutableArray *allCities;
@property (nonatomic, strong) NSMutableArray *filteredCities;
@property (nonatomic, strong) NSArray *items;


@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LOL科普：地名大全";
    
    self.items = @[@"国服第一臭豆腐 No.1 Stinky Tofu CN.",
                   @"瓦洛兰 Valoran",
                   @"德玛西亚 Demacia",
                   @"诺克萨斯 Noxus",
                   @"艾欧尼亚 Ionia",
                   @"皮尔特沃夫 Piltover",
                   @"弗雷尔卓德 Freijord",
                   @"班德尔城 Bandle City",
                   @"战争学院 The Institute of War",
                   @"祖安 Zaun",
                   @"卡拉曼达 Kalamanda",
                   @"蓝焰岛 Blue Flame Island",
                   @"哀嚎沼泽 Howling Marsh",
                   @"艾卡西亚 Icathia",
                   @"铁脊山脉 Ironspike Mountains",
                   @"库莽古丛林 Kumungu",
                   @"洛克法 Lokfar",
                   @"摩根小道 Morgon Pass",
                   @"塔尔贡山脉 Mountain Targon",
                   @"瘟疫丛林 Plague Jungles",
                   @"盘蛇河 Serpentine River",
                   @"恕瑞玛沙漠 Shurima Desert",
                   @"厄尔提斯坦 Urtistan",
                   @"巫毒之地 Voodoo Lands",
                   @"水晶之痕 Crystal Scar",
                   @"咆哮深渊 Howling Abyss",
                   @"熔岩洞窟 Magma Chambers",
                   @"试炼之地 Proving Grounds",
                   @"召唤师峡谷 Summoner's Rift",
                   @"扭曲丛林 Twisted Treeline"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

// 在viewWillDisappear中要将UISearchController移除, 否则切换到下一个View中, 搜索框仍然会有短暂的存在.
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchC.active) {
        self.searchC.active = NO;
        [self.searchC.searchBar removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (self.searchC.active) {
//        return self.items.count;
////        return self.cityKeys.count;
//    } else {
//    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchC.active) {
//        NSString *key = self.cityKeys[section];
//        NSArray *citySection = self.cityDict[key];
        return self.items.count;
    } else {
        return self.filteredCities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // 根据UISearchController的active属性来判断cell中的内容
    if (!self.searchC.active) {
        cell.textLabel.text = [self.items objectAtIndex:indexPath.row];

//        NSString *key = self.cityKeys[indexPath.section];
//        cell.textLabel.text = [self.cityDict[key] objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = self.filteredCities[indexPath.row];
    }
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filteredCities removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchC.searchBar.text];
    self.filteredCities = [[self.items filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = nil;
    }
    return _tableView;
}

- (UISearchController *)searchC {
    if (!_searchC) {
//        _searchC = [[UISearchController alloc] initWithSearchResultsController:self];// 不能写self，否则会crash
//        _searchC = [[UISearchController alloc] init]; // 直接init不行，这样没有searchBar
        _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];

        _searchC.searchResultsUpdater = self;
        _searchC.delegate = self;
        _searchC.dimsBackgroundDuringPresentation = NO;
        [_searchC.searchBar sizeToFit];
        // searchBar 下面的排序按钮
//        _searchC.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"BOY",@"GIRL",@"ALL",nil];

//        _searchVC.searchBar.backgroundColor = UIColorFromHex(0xdcdcdc);
        self.tableView.tableHeaderView = _searchC.searchBar;
    }
    return _searchC;
}

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}

@end
