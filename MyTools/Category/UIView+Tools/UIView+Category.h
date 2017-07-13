//
//  UIView+Category.h
//  MyTools
//
//  Created by SongGuoxing on 2017/7/12.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat maxX;
@property (nonatomic) CGFloat maxY;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic, readonly) CGFloat halfWidth;
@property (nonatomic, readonly) CGFloat halfHeight;
@property (nonatomic, readonly) CGPoint halfPoint;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@end
