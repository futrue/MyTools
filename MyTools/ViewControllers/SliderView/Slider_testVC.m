//
//  Slider_testVC.m
//  MyTools
//
//  Created by SGX on 17/1/13.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Slider_testVC.h"
#import "GXScrollView.h"
#import "LXViewSelectorController.h"

@interface Slider_testVC ()
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray <UIView *>*subViews;
@property (nonatomic, strong) GXScrollView *scrollView;

@end

@implementation Slider_testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[GXScrollView alloc] init];
    self.scrollView.itemViews = self.subViews;
    self.scrollView.titleArray = self.titleArray;
    self.scrollView.frame = CGRectMake(0, 130, SCREEN_WIDTH, 300);
    self.scrollView.selectedIndex = 2;
    self.scrollView.midSpace = 50;
    [self.view addSubview:self.scrollView];
    
    [self gotoType2];
    
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"t-1",@"t-22",@"t-333"];
    }
    return _titleArray;
}

- (NSArray<UIView *> *)subViews {
    if (!_subViews) {
        UIView *view1 = [UIView new];
        view1.backgroundColor = [UIColor orangeColor];
        UIView *view2 = [UIView new];
        view2.backgroundColor = [UIColor yellowColor];
        UIView *view3 = [UIView new];
        view3.backgroundColor = [UIColor grayColor];
        
        _subViews = @[view1,view2,view3];
        
    }
    return _subViews;
}


- (void)gotoType2 {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"另一种" forState:UIControlStateNormal];
    addBtn.backgroundColor = RandomColor;
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake((self.view.bounds.size.width - 100)/2, self.view.bounds.size.height - 80, 100, 50);
    [addBtn addTarget:self action:@selector(type2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)type2 {
    //使用例子
    //准备要添加的控制器和标题数组
    NSMutableArray *vcArr = [NSMutableArray array];
    NSMutableArray *titleArr = [NSMutableArray array];
    for (int i =0; i<4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = RandomColor;
        [vcArr addObject:vc];
        [titleArr addObject:[NSString stringWithFormat:@"条目%d",i+1]];
    }
    
    //初始化并push
    LXViewSelectorController *vc = [[LXViewSelectorController alloc] initWithControllers:vcArr titles:titleArr];
    vc.title = @"视图选择器";
    [self.navigationController pushViewController:vc animated:YES];

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
