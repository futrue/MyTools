//
//  GXScrollView.h
//  GXSliderView
//
//  Created by SGX on 16/10/19.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXScrollView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray <UIView *> *itemViews;

@property (nonatomic, assign) CGFloat midSpace;

@end
