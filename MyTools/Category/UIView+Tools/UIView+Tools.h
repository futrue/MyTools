//
//  UIImage+Tools.m
//  MyTools
//
//  Created by SGX on 17/2/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tools)

//裁剪为圆形
- (void)clipsToRound;
//设置圆角弧度
- (void)setCornerRadius:(CGFloat)cornerRadius;
//设置一个或多个圆角圆角弧度
- (void)addRoundedCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

//裁剪图片圆角 比直接使用cornerRadius更高效
+ (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original;

/**
 *  将UIView转换为image
 *
 *  @param frame 要显示的部分
 *
 */
- (UIImage *)renderWithBounds:(CGRect)frame;

//添加边框（单边）
- (void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

//anmation helper
//请使用UIView+AnimationExtensions.h
/**
 *  旋转view
 *  @param angle 弧度：PI = 360度
 */
- (void)rotateViewWithAngle:(CGFloat)angle andDuration:(CGFloat)duration;


//设置anchorPoint,不改变origin
- (void)setAnchorPointAndRemainOrigin:(CGPoint)anchorPoint;

//封装gestureRecognizer到UIView中，用的时候直接把需触发的block传入即可
- (void)touchEndedBlock:(void(^)(UIView *selfView))block;

- (void)touchEndedGesture;

- (void)longPressEndedBlock:(void(^)(UIView *selfView))block;

- (void)longPressEndedGesture:(UIGestureRecognizer*)gesture;
@end

#pragma mark - UIImage
@interface UIImage (Tools)
- (UIImage *)drawImage:(UIImage *)inputImage inRect:(CGRect)frame;
/**
 类方法创建圆角image
 
 @param name 图片名
 @param cornerRadius 圆角弧度
 @return 圆角image
 */
+ (UIImage *)imageNamed:(NSString *)name cornerRadius:(CGFloat)cornerRadius;

/**
 实例方法设置圆角image
 
 @param cornerRadius 圆角弧度
 @return 圆角image
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius;

@end
