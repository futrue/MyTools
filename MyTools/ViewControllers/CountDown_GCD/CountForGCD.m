//
//  CountForGCD.m
//  MyTools
//
//  Created by SongGuoxing on 2017/7/7.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CountForGCD.h"
#import "UIButton+CountDown.h"

@interface CountForGCD ()

@end

@implementation CountForGCD

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * countDownBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 150, 120, 40)];
    [countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownBtn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f];
    [countDownBtn addTarget:self action:@selector(countDownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countDownBtn];
    
}

- (void)countDownBtnAction:(UIButton *)button{
    
    [button startWithTime:5 title:@"点击重新获取" countDownTitle:@"s" mainColor:[UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f] countColor:[UIColor colorWithRed:84 / 255.0 green:180 / 255.0 blue:98 / 255.0 alpha:1.0f]];
    
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
