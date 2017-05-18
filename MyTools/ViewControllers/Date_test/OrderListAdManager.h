//
//  OrderListAdManager.h
//  MyTools
//
//  Created by SGX on 17/1/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDOrderListAdView.h"

@interface OrderListAdManager : NSObject

+ (OrderListAdManager *)defaultManager;

@property (nonatomic, strong) DDOrderListAdView *adView;

- (void)closeAD;
- (void)setAdUrl:(NSString *)adUrl;
@end
