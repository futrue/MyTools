//
//  OrderListAdManager.m
//  MyTools
//
//  Created by SGX on 17/1/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "OrderListAdManager.h"
#import "Date_testVC.h"
#import "NSDate+Utilities.h"

static OrderListAdManager *manager = nil;

NSString *const adKey = @"AD_KEY";
NSString *const lastShowAdTime = @"lastShowAdTime";

@interface OrderListAdManager ()
@property (nonatomic, strong) Date_testVC *vc;

@property (nonatomic, strong) CADisplayLink *weekTimer;
@property (nonatomic, assign) NSTimeInterval aWeek;

@property (nonatomic, copy) NSString *adUrl;

@end

@implementation OrderListAdManager

+ (OrderListAdManager *)defaultManager {
    if (!manager) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            manager = [[OrderListAdManager alloc] init];
        });
    }
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.adView = [[DDOrderListAdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
    }
    return self;
}

- (void)setAdUrl:(NSString *)adUrl {
    _adUrl = adUrl;
    if (!adUrl.length) {
        return;
    }
    NSString *displayedMd5Str = [[NSUserDefaults standardUserDefaults] valueForKey:adKey];
    NSString *currentMd5Str = [adUrl md5String];
    
    NSDate *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"asdsad"];
    NSTimeInterval timeInterval = [lastDate timeIntervalSinceDate:[self dateByAddingSeconds:0]];
    
    if (![displayedMd5Str isEqualToString:currentMd5Str]) {// 不一样的广告，显示
        [self.adView setAdURLString:adUrl];
    } else {
        NSLog(@"还有%f秒可显示广告",timeInterval);
        if (timeInterval < 1) { // 过了timeInterval后显示
            [self.adView setAdURLString:adUrl];
        }
    }
}

- (void)closeAD {
    NSDate *date3 = [self dateByAddingSeconds:10];
    [[NSUserDefaults standardUserDefaults] setObject:date3 forKey:@"asdsad"];
    [[NSUserDefaults standardUserDefaults] setValue:[self.adUrl md5String] forKey:adKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [NSDate timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


//- (void)countdown {
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    if (self.aWeek > now) {
//        NSLog(@"倒计时中...");
//        [self start];
//    } else {
//        NSLog(@"倒计时完毕。");
//        [self end];
//    }
//}

//- (NSTimeInterval)aWeek {
//    if (!_aWeek) {
//        _aWeek = [[NSDate date] timeIntervalSinceNow] + 10;
//    }
//    return _aWeek;
//}
//
//-(void)start {
//    if (!_weekTimer) {
//        _weekTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(countdown)];
//        _weekTimer.preferredFramesPerSecond = 1;
//        [_weekTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    }
//}
//
//- (void)restart {
//    self.aWeek = [[NSDate date] timeIntervalSinceNow] + 10;
//    [self countdown];
//}
//
//-(void)end {
//    if (_weekTimer) {
//        [_weekTimer invalidate];
//        _weekTimer = nil;
//    }
//}



@end
