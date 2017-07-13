//
//  EqualMarginController.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-28.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "EqualMarginController.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EqualMarginController ()

@end

@implementation EqualMarginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WS(ws);
    
    
    //屏幕中间放一个边长200 * 200的红色View
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //再对一个View布局之前, 一定要将这个View add到一个superView上
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.equalTo(ws.view);
    }];
    
    
    //在红色View里面放三个正方形View, 等间距为10
    NSInteger padding = 10;
    UIView *yellowView1 = [[UIView alloc] init];
    yellowView1.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView1];
    
    UIView *yellowView2 = [[UIView alloc] init];
    yellowView2.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView2];
    
    UIView *yellowView3 = [[UIView alloc] init];
    yellowView3.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView3];
    
    [@[yellowView1, yellowView2, yellowView3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding * 2 leadSpacing:padding tailSpacing:padding];
    
    [@[yellowView1, yellowView2, yellowView3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView).offset(10);
        make.height.mas_equalTo(yellowView3.mas_width);
    }];
    
    
    //在红色View里面放三个正方形蓝色View, 宽度均为30, 间隙一样大
    NSMutableArray *blueViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *blueView = [[UIView alloc] init];
        blueView.backgroundColor = [UIColor blueColor];
        [redView addSubview:blueView];
        [blueViews addObject:blueView];
    }
    CGFloat padding2 = (300 - 3 * 30) / 4;
    [blueViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:padding2 tailSpacing:padding2];
    [blueViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(redView);
        UIView *blueView = (UIView *)blueViews[0];
        make.height.mas_equalTo(blueView.mas_width);
    }];
    
    
    //在红色View里面放三个大小不一样的绿色正方形, 间隙等大, masonry并没提供相关方法
    NSMutableArray *greenViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *greenView = [[UIView alloc] init];
        greenView.backgroundColor = [UIColor greenColor];
        [redView addSubview:greenView];
        [greenViews addObject:greenView];
        [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(redView).offset(-10);
            make.width.mas_equalTo(i*20 + 20);
            make.height.mas_equalTo(greenView.mas_width);
        }];
    }
//    [redView distributeSpacingHorizontallyWith:greenViews];
    
    
}

//

//2个或2个以上的控件等间隔排序
/**
 *  多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
 *
 *  @param axisType        轴线方向
 *  @param fixedSpacing    间隔大小
 *  @param leadSpacing     头部间隔
 *  @param tailSpacing     尾部间隔
 */
/*
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
                    withFixedSpacing:(CGFloat)fixedSpacing l
eadSpacing:(CGFloat)leadSpacing
tailSpacing:(CGFloat)tailSpacing;
*/
/**
 *  多个固定大小的控件的等间隔排列,变化的是间隔的空隙
 *
 *  @param axisType        轴线方向
 *  @param fixedItemLength 每个控件的固定长度或者宽度值
 *  @param leadSpacing     头部间隔
 *  @param tailSpacing     尾部间隔
 */
/*
- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
                 withFixedItemLength:(CGFloat)fixedItemLength
                         leadSpacing:(CGFloat)leadSpacing
                         tailSpacing:(CGFloat)tailSpacing;
*/
//使用方法很简单，因为它是NSArray的类扩展：

//  创建水平排列图标 arr中放置了2个或连个以上的初始化后的控件
//  alongAxis 轴线方向   固定间隔     头部间隔      尾部间隔
/*
[arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
[arr makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(@60);
    make.height.equalTo(@60);
}];
*/


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
