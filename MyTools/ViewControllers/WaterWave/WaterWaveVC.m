//
//  WaterWaveVC.m
//  MyTools
//
//  Created by SGX on 17/1/17.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "WaterWaveVC.h"
#import "LHWaveProgressView.h"

@interface WaterWaveVC ()
@property (nonatomic, weak) LHWaveProgressView *waveProgressView;

@end

@implementation WaterWaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
    [self addWaveProgressView];
}

- (void)creatSubView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 400, 100, 30)];
    resetBtn.backgroundColor = [UIColor greenColor];
    [resetBtn setTitle:@"重新开始" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    resetBtn.layer.masksToBounds = YES;
    resetBtn.layer.cornerRadius = resetBtn.frame.size.width/8;
    resetBtn.layer.borderWidth = 1.0;
    resetBtn.layer.borderColor=[UIColor blueColor].CGColor;
    [resetBtn addTarget:self action:@selector(resetAcction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
}

#pragma mark waveProgressView.numberLabel.text可设置为变量参数，随数据的变化而变化
- (void)addWaveProgressView
{
    LHWaveProgressView *waveProgressView = [[LHWaveProgressView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 180)/2, 44, 180, 180)];
    waveProgressView.waveViewMargin = UIEdgeInsetsMake(15, 15, 20, 20);
    waveProgressView.backgroundImageView.image = [UIImage imageNamed:@"bg_tk_003"];
    waveProgressView.numberLabel.text = @"80";
    waveProgressView.numberLabel.font = [UIFont boldSystemFontOfSize:70];
    waveProgressView.numberLabel.textColor = [UIColor whiteColor];
    waveProgressView.unitLabel.text = @"%";
    waveProgressView.unitLabel.font = [UIFont boldSystemFontOfSize:20];
    waveProgressView.unitLabel.textColor = [UIColor whiteColor];
    waveProgressView.explainLabel.text = @"用电量";
    waveProgressView.explainLabel.font = [UIFont systemFontOfSize:20];
    waveProgressView.explainLabel.textColor = [UIColor whiteColor];
    
    waveProgressView.percent = 0.8;
    [self.view addSubview:waveProgressView];
    _waveProgressView = waveProgressView;
    [_waveProgressView startWave];
}

- (void)resetAcction
{
    [_waveProgressView startWave];
}

@end
