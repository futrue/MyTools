//
//  UIControlFastGet.h
//  OurMemory
//
//  Created by SongGuoxing on 2017/7/13.
//  Copyright © 2017年 SongGuoxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIControlFastGet : NSObject

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title bgColor:(UIColor *)bgColor;
+ (UIButton *)buttonWithImageNamed:(NSString *)name;
+ (UIButton *)buttonWithTitle:(NSString *)title;

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor;
+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor;
+ (UILabel *)labelWithText:(NSString *)text;
@end
