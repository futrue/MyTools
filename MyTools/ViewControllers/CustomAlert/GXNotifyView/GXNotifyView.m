//
//  GXNotifyView.m
//  GXAlertView
//
//  Created by SGX on 16/4/25.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "GXNotifyView.h"
@interface GXNotifyLoadingView : GXNotifyView
{
    UIImageView *_contentImage;
}
@end

@interface GXNotifyViewManager : NSObject {
    GXNotifyView *_notifyView;
    UIView  *_backgroundView;
}

@end

@implementation GXNotifyViewManager

static GXNotifyViewManager *_instance = nil;
+ (id)defaultManager {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[GXNotifyViewManager alloc] init];
        });
    }
    return _instance;
}

- (id)init {
    self = [super init];
    if ( self) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    }
    return self;
}

- (void)showNotify:(GXNotifyView *)notify {
    if (_notifyView) {
        [self hideNotify];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideNotify) object:nil];
    }
    [_backgroundView setHidden:NO];
    [_backgroundView addSubview:notify];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_backgroundView];
    _notifyView = notify;
    [notify setCenter:CGPointMake(_backgroundView.bounds.size.width / 2, _backgroundView.bounds.size.height / 2 * 0.8)];
    [self performSelector:@selector(hideNotify) withObject:nil afterDelay:notify.showTime];
}

- (void)hideNotify {
    if (_notifyView) {
        [_notifyView removeFromSuperview];
        _notifyView = nil;
    }
    [_backgroundView setHidden:YES];
}

//- (void)hideloading {
//    if (_notifyView && [_notifyView isKindOfClass:[GXNotifyLoadingView class]]) {
//        [_notifyView removeFromSuperview];
//        _notifyView = nil;
//        [_backgroundView  setHidden: YES];
//    }
//}

@end


@implementation GXNotifyLoadingView

- (id)initBaseLoading {
    self = [super init];
    if (self) {
        [self.layer setCornerRadius:4.0f];
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setColor:[UIColor orangeColor]];

        [indicator setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:indicator];
        [self startAnimationWithView:indicator];
        CGRect appBounds = [UIApplication sharedApplication].keyWindow.bounds;
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:CGRectMake(CGRectGetMidX(appBounds), CGRectGetMidY(appBounds), CGRectGetWidth(indicator.bounds) + 30, CGRectGetHeight(indicator.bounds) + 30)];
        [indicator setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
        self.showTime = 60.0f; // max loading time
    }
    return self;
}
- (void)startAnimationWithView:(UIView *)view{
    /* 运行时有移动效果
    if ([view.layer animationForKey:@"rotate"]) {
        return;
    }
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = 1.0; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [view.layer removeAllAnimations];
    [view.layer addAnimation:rotation forKey:@"rotate"];
    [view setHidden:NO];
    */
    
    [(UIActivityIndicatorView *)view startAnimating];
}

- (id)initWithMessage:(NSString *)message {
    self  = [super init];
    if (self) {
        [self.layer setCornerRadius:4.0];
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setColor:[UIColor orangeColor]];
        [indicator setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:indicator];
        [self startAnimationWithView:indicator];
        
        CGRect appBounds = [UIApplication sharedApplication].keyWindow.bounds;
        [self setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.66]];
        
        if (message.length > 0) {
            UILabel *msgLabel = [[UILabel alloc] init];
            [msgLabel setBackgroundColor: [UIColor clearColor]];
            [msgLabel setNumberOfLines:0];
            [msgLabel setText:message];
            [msgLabel setTextAlignment:NSTextAlignmentCenter];
            [msgLabel setTextColor:[UIColor whiteColor]];
            [msgLabel setFont:[UIFont systemFontOfSize:16]];
            [self addSubview:msgLabel];
            
            CGRect msgRect = [msgLabel textRectForBounds:CGRectMake(0, 0, appBounds.size.width - 60, appBounds.size.height) limitedToNumberOfLines:0];
            
            CGRect showRect = CGRectMake(0, 0, msgRect.size.width + 30, msgRect.size.height + indicator.bounds.size.height + 35);
            
            [indicator setCenter:CGPointMake(showRect.size.width / 2, 15 + indicator.bounds.size.height/2)];
            
            msgRect.origin.x = (showRect.size.width - msgRect.size.width) / 2;
            msgRect.origin.y = CGRectGetMaxY(indicator.frame)+10;
            [msgLabel setFrame:msgRect];
            [self setFrame:showRect];
            
        } else {
            [self setFrame:CGRectMake(CGRectGetMidX(appBounds), CGRectGetMidY(appBounds), CGRectGetWidth(indicator.bounds) + 30, CGRectGetHeight(indicator.bounds) + 30)];
            [indicator setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
            [self setBackgroundColor:[UIColor clearColor]];
        }
        self.showTime = 60.0f; // max show time
    }
    return self;
}
@end

@implementation GXNotifyView

- (id)initWithMessage:(NSString *)message {
    if ([super init]) {
        _showTime = 2.0f;
        UILabel *msgLabel = [[UILabel alloc] init];
        [msgLabel setBackgroundColor:[UIColor clearColor]];
        [msgLabel setNumberOfLines:0];
        [msgLabel setTextAlignment:NSTextAlignmentCenter];
        [msgLabel setTextColor:[UIColor whiteColor]];
        [msgLabel setText:message];
        [msgLabel setFont:[UIFont systemFontOfSize:16]];

        CGRect appBounds = [UIApplication sharedApplication].keyWindow.bounds;
        CGRect msgRect = [msgLabel textRectForBounds:CGRectMake(0, 0, appBounds.size.width - 60, appBounds.size.height) limitedToNumberOfLines:0];
        [self setFrame:CGRectInset(msgRect, -15, -15)];
        msgRect.origin.x = 15;
        msgRect.origin.y = 15;
        [msgLabel setFrame:msgRect];
        [self addSubview:msgLabel];
        [self.layer setCornerRadius:4.0f];
        [self setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.65]];

    }
    return self;
}

- (void)show {
    [[GXNotifyViewManager defaultManager] showNotify:self];
}
+ (void)hide {
    [[GXNotifyViewManager defaultManager] hideNotify];
}

+ (void)showLoadingWithText:(NSString *)text {
    [[[GXNotifyLoadingView alloc] initWithMessage:text] show];
}

+ (void)showBaseLoding {
    [[[GXNotifyLoadingView alloc] initBaseLoading] show];
}

//+ (void)hideLoading {
//    [[GXNotifyViewManager defaultManager] hideloading];
//}
@end
