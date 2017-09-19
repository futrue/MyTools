//
//  SettingItem.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem
+ (instancetype)itemWithTitle:(NSString *)title {
    SettingItem *item = [[SettingItem alloc] init];
    item.title = title;
    return item;
    return [[SettingItem alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}


@end
