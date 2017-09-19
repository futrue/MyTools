//
//  SettingGroup.h
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingItem.h"

@interface SettingGroup : NSObject

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *footerView;

/** 组头 */
@property (nonatomic, copy) NSString *headerTitle;
/** 组尾 */
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong) NSMutableArray *items;

@end
