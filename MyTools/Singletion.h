//
//  Singletion.h
//  MyTools
//
//  Created by SongGuoxing on 2017/8/18.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singletion : NSObject
+ (Singletion *)shared;


@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) CGFloat count;
- (void)clear;
- (void)save;
@end
