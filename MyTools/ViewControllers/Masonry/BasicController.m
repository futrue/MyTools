//
//  BasicController.m
//  HowToUseMasonry
//
//  Created by sharejoy on 16-05-28.
//  Copyright © 2016年 shangbin. All rights reserved.
//

#import "BasicController.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self) weakSelf = self;
//解释: __weak 指定一个弱引用指针,  __typeof(&*self) self的类型,  weakSelf 变量名,  = self 赋值


@interface BasicController ()
@property (nonatomic, strong) UIView *grayView;
@end

@implementation BasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self test1];

    [self test2];
    
    [self specialAnimate];
}

- (void)test1 {
    WS(ws);  //避免循环引用
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).offset(64 + 50);
        make.left.equalTo(ws.view).offset(50);
        make.right.equalTo(ws.view).offset(-50);
    }];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = [UIColor greenColor];
    [redView addSubview:greenView];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(redView);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor yellowColor];
    label.numberOfLines = 0;
    label.text = @"三扥黄森老将老将赛疯狂森囧带肯老将赛疯狂森囧带肯赛疯狂森囧带肯交两三";
    [redView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView.mas_bottom).offset(20);
        make.width.mas_equalTo(greenView);
        make.centerX.equalTo(greenView);
        //        make.bottom.equalTo(redView).offset(-20);
    }];
    
    [redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label).offset(20);
    }];
}

- (void)test2 {
    WS(ws);  //避免循环引用
    
    //屏幕中间放一个边长200 * 200的红色View
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //再对一个View布局之前, 一定要将这个View add到一个superView上
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.equalTo(ws.view);
    }];
    
    //红色VIew里放一个内边距上左下右为10, 20 , 20, 40的蓝色View
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    [redView addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(redView).insets(UIEdgeInsetsMake(10, 20, 30, 40));
    }];
    
    //在蓝色View里面放2个Label, 距离左边20, 右边最少40, 非固定宽度
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *label1 = [[UILabel alloc] init];
        label1.backgroundColor = [UIColor purpleColor];
        if (i == 0) {
            label1.text = @"测试一下啊测试一下啊测试一下啊测试一下啊测试一下啊";
        } else {
            label1.text = @"测试一下啊";
        }
        [blueView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blueView).offset(20+i*25);
            make.left.equalTo(blueView).offset(20);
            make.right.lessThanOrEqualTo(blueView).offset(-40);
        }];
    }
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [blueView addSubview:yellowView];
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        //直接mas_equalTo(20)相当于针对yellowView的父视图布局
        make.bottom.left.right.mas_equalTo(20);
        //这个multipliedBy 比例仅针对 同一个View的比例, 下面代码是指 height = width * 0.5;
        make.height.mas_equalTo(yellowView.mas_width).multipliedBy(0.5);
    }];

}

- (void)specialAnimate {
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *redView1 = [[UIView alloc] init];
    redView1.backgroundColor = [UIColor purpleColor];
    [redView addSubview:redView1];

    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:grayView];
    self.grayView = grayView;
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20.f);
        make.bottom.offset(-20.f);
        make.height.equalTo(@(30.f));
    }];
    
    [redView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0.f);
        make.bottom.offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];

    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView.mas_right).offset(30.f);
        make.height.width.bottom.mas_equalTo(redView);
    }];
    
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grayView.mas_right).offset(30.f);
        make.height.width.bottom.mas_equalTo(redView);
        make.right.offset(-20.f);
        
        // 优先级设置为priorityLow，最高1000（默认）
        make.left.equalTo(redView.mas_right).offset(30.f).priorityLow(250);
    }];
}

// 点击屏幕移除蓝色View
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.grayView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
    /*
     这里的三个View的宽度是根据约束自动推断设置的，对黄色的View设置了一个与红色View有关的priority(250)的优先级，它同时有对灰色View有个最高的优先级约束make.left.equalTo(grayView.mas_right).offset(30.f);。当点击屏幕，我将灰色View移除，此时第二优先级就是生效。
     */
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
