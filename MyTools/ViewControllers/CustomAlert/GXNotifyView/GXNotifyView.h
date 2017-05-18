//
//  GXNotifyView.h
//  GXAlertView
//
//  Created by SGX on 16/4/25.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXNotifyView : UIView

@property (nonatomic, assign) NSTimeInterval showTime;
/*
 * show it and hide after some time,defalut is 2.0s 
 */
- (id)initWithMessage:(NSString *)message;
- (void)show;

/*
 * loading 
 */
+ (void)showLoadingWithText:(NSString *)text;
+ (void)showBaseLoding;
//+ (void)hideLoading;
+ (void)hide;
@end
