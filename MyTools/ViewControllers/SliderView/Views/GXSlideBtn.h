//
//  GXSlideBtn.h
//  GXSliderView
//
//  Created by SGX on 16/10/19.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXSlideBtn;
@protocol GXSlideBtnDelegate <NSObject>
- (void)slideViewDidSelectedIndex:(NSInteger)index;
@end

@interface GXSlideBtn : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat indexProgress;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, assign) BOOL isFullIndicator;

@property (nonatomic, weak) id <GXSlideBtnDelegate> delegate;

@end
