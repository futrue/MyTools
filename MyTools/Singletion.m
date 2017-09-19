//
//  Singletion.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/18.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Singletion.h"

@implementation Singletion

+ (Singletion *)shared {
    static Singletion *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[Singletion alloc] init];
    });
    return single;
}

- (void)clear {
    self.name = nil;
    self.count = 0;
}

- (void)save {
    self.name = @"save";
    self.count = 99;
}

@end
