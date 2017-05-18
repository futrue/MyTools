//
//  DDOrderListAdView.h
//  VeloCarPooling
//
//  Created by SGX on 17/1/10.
//  Copyright © 2017年 didapinche.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDOrderListAdView;
@protocol DDOrderListAdViewDelegate <NSObject>
- (void)orderListAdViewCloseBtnDidClicked:(DDOrderListAdView *)view;
@end

@interface DDOrderListAdView : UIView
@property (nonatomic, assign) BOOL closeAd;
@property (nonatomic, copy) NSString *adURLString;

@property (nonatomic, weak) id<DDOrderListAdViewDelegate> delegate;

@end
