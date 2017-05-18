//
//  LHWaterWaveView.h
//  WaterProgressBar
//
//  Created by lihui on 15/10/15.
//  Copyright © 2015年 lihui. All rights reserved.
//
/**
 *  主要设置水波的View
 */
#import <UIKit/UIKit.h>

@interface LHWaterWaveView : UIView

/**
 *  波浪的颜色
 */
@property (nonatomic, strong)UIColor *waveColor;
/**
 *  水波的百分比
 */
@property (nonatomic ,assign) CGFloat percent;
/**
 *  水波开始
 */
- (void) startWave;
/**
 *  水波停止
 */
- (void) stopWave;
/**
 *  恢复设置
 */
- (void) reset;

@end
