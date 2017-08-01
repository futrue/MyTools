//
//  UIControlFastGet.m
//  OurMemory
//
//  Created by SongGuoxing on 2017/7/13.
//  Copyright © 2017年 SongGuoxing. All rights reserved.
//

#import "UIControlFastGet.h"

@implementation UIControlFastGet

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor {
    UIButton *button = [[UIButton alloc] init];
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    button.titleLabel.font = FONT(15.0);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button sizeToFit];
    return button;
}


+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    button.titleLabel.font = FONT(15.0);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button sizeToFit];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title bgColor:(UIColor *)bgColor {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    button.titleLabel.font = FONT(15.0);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button sizeToFit];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = FONT(15.0);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button sizeToFit];

    return button;
}

+ (UIButton *)buttonWithImageNamed:(NSString *)name {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button sizeToFit];

    return button;
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    label.textColor = textColor ? : [UIColor darkGrayColor];
    label.font = FONT(15);
    [label sizeToFit];

    return label;
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor  {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor ? : [UIColor darkGrayColor];
    label.font = FONT(15);
    [label sizeToFit];

    return label;
}

+ (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor darkGrayColor];
    label.font = FONT(15);
    
    return label;
}


@end
