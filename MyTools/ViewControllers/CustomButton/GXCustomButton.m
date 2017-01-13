//
//  GXCustomButton.m
//  GXCustomButton
//
//  Created by SGX on 16/10/20.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "GXCustomButton.h"

@implementation GXCustomButton


- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title imageAlignmentType:(ImageAlignmentType)type {
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // step1: button content alignment
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        // defalut setting
        self.imageTextDistance = 5.f;
        self.imageCornerRadius = 0.f;
        self.imageAlignmentType = type ? : ImageAlignmentTypeLeft;
    }
    return self;
}

- (instancetype)initWithAlignmentType:(ImageAlignmentType)type {
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // step1: button content alignment
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        // defalut setting
        self.imageTextDistance = 5.f;
        self.imageCornerRadius = 0.f;
        self.imageAlignmentType = type ? : ImageAlignmentTypeLeft;

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = self.imageCornerRadius;
    self.imageView.layer.masksToBounds = YES;
    [self layout];
}

- (void)layout {
    CGFloat btnWidth = CGRectGetWidth(self.frame);
    CGFloat btnHeight = CGRectGetHeight(self.frame);

    CGFloat imgWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat imgHeight = CGRectGetHeight(self.imageView.frame);
    
    // calculate width of titleLabel bt it's font
    CGSize size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat textWidth = ceilf(size.width);
    CGFloat textHeight = ceilf(size.height);

    // distance between image and title
    CGFloat space;

    CGFloat imgOffsetX;
    CGFloat imgOffsetY;
    CGFloat titleOffsetX;
    CGFloat titleOffsetY;

    switch (self.imageAlignmentType) {
        case ImageAlignmentTypeUp:
        {
            space = (btnHeight - (imgHeight + self.imageTextDistance + textHeight)) / 2;
            imgOffsetX = (btnWidth - imgWidth) / 2;
            imgOffsetY = space;
            titleOffsetX = (btnWidth - textWidth) / 2 - imgWidth;
            titleOffsetY = imgHeight + self.imageTextDistance + space;
            
        }
            break;
        case ImageAlignmentTypeLeft:
        {
            space = (btnWidth - (imgWidth + self.imageTextDistance + textWidth)) / 2;
            imgOffsetX = space;
            imgOffsetY = (btnHeight -imgHeight) / 2;
            titleOffsetX = btnWidth - (imgWidth + space + textWidth);
            titleOffsetY = (btnHeight - textHeight) / 2;
        }
            break;
        case ImageAlignmentTypeDown:
        {
            space = (btnHeight - (imgHeight + self.imageTextDistance + textHeight)) / 2;
            imgOffsetX = (btnWidth - imgWidth) / 2;
            imgOffsetY = textHeight + self.imageTextDistance + space;
            titleOffsetX = (btnWidth - textWidth) / 2 - imgWidth;
            titleOffsetY = space;
        }
            break;
        case ImageAlignmentTypeRight:
        {
            space = (btnWidth - (imgWidth + self.imageTextDistance + textWidth)) / 2;
            imgOffsetX = space + self.imageTextDistance + textWidth;
            imgOffsetY = (btnHeight - imgHeight) / 2;
            titleOffsetX = - (imgWidth - space);
            titleOffsetY = (btnHeight - textHeight) / 2;
        }
            break;

        default:
            break;
    }
    
    // step2 :set top inset and left inset keep the same with init method
    [self setImageEdgeInsets:UIEdgeInsetsMake(imgOffsetY, imgOffsetX, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY, titleOffsetX, 0, 0)];
    
}

@end
