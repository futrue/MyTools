//
//  PopMenuVC.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/20.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "PopMenuVC.h"
#import "Toolbar.h"

@interface PopMenuVC ()
@property (nonatomic, strong) Toolbar *toolbar;
@property (nonatomic, strong)CAGradientLayer * gradient;// 渐变层

@end

@implementation PopMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toolbar = [[Toolbar alloc] init];
    self.toolbar.frame = CGRectMake(0, self.view.height - 40.f, self.view.width, 40.f);
    [self.view addSubview:self.toolbar];
    [self setUI];
    
    
    
}


#pragma mark - 颜色渐变
-(void) setUI{
    // 设置背景渐变
    //  创建 CAGradientLayer 对象
    _gradient = [CAGradientLayer layer];
    //  设置 gradientLayer 的 Frame
    _gradient.frame = CGRectMake(0, 64.f,[UIScreen mainScreen].bounds.size.width, 220);
    //  创建渐变色数组，需要转换为CGColor颜色
    _gradient.colors = @[(id)[UIColor orangeColor].CGColor,
                         (id)[UIColor whiteColor].CGColor];

    //  设置三种颜色变化点，取值范围 0.0~1.0
    _gradient.locations = @[@(0.1f) ,@(0.0f)];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    _gradient.startPoint = CGPointMake(0, 0);
    _gradient.endPoint = CGPointMake(0, 1);
    //  添加渐变色到创建的 UIView 上去
    [self.view.layer addSublayer:_gradient];
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
