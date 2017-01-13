//
//  DDOrderListAdView.m
//  VeloCarPooling
//
//  Created by SGX on 17/1/10.
//  Copyright © 2017年 didapinche.com. All rights reserved.
//

#import "DDOrderListAdView.h"
#import "UIImageView+WebCache.h"

@interface DDOrderListAdView()
@property (nonatomic, strong) UIImageView *adImg;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation DDOrderListAdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
//    self.backgroundColor = COLOR_BACKGROUND;
    [self addSubview:self.adImg];
    [self insertSubview:self.closeBtn aboveSubview:self.adImg];
    [self.adImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(15.f, 10, 1.f, 10));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.adImg);
        make.centerY.equalTo(self.adImg);
        make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
    }];
}

- (void)setAdURLString:(NSString *)adURLString {
    _adURLString = adURLString;
    // http://192.168.1.192/pics//g/20161226154553293_0.jpg
    self.hidden = NO;
    [self.adImg sd_setImageWithURL:[NSURL URLWithString:adURLString]];
}

- (void)closeAd:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        if ([self.delegate respondsToSelector:@selector(orderListAdViewCloseBtnDidClicked:)]) {
            [self.delegate orderListAdViewCloseBtnDidClicked:self];
        }
        self.hidden = YES;
    } completion:^(BOOL finished) {
        [self ignoreAd];
    }];
}

- (void)ignoreAd {
    NSDate *startDate = [NSDate date];
    NSDate *aWeekDate = [NSDate dateWithTimeIntervalSinceNow:7*24*3600];
    
    NSTimeInterval timeInterval =[aWeekDate timeIntervalSinceDate:startDate];
    NSLog(@"timeInterval = %f",timeInterval);

    
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",currentDate,year,month,day);

}

//- (CGSize)intrinsicContentSize {
//    if (!self.adURLString.length) {
//        return CGSizeMake(SCREEN_WIDTH, 0);
//    }
//    return CGSizeMake(SCREEN_WIDTH, 65);
//}

//- (void)setCloseAd:(BOOL)closeAd {
//    _closeAd = closeAd;
//    [self invalidateIntrinsicContentSize];
//}

- (UIImageView *)adImg {
    if (!_adImg) {
        _adImg = [[UIImageView alloc] init];
        _adImg.backgroundColor = [UIColor whiteColor];
        _adImg.contentMode = UIViewContentModeScaleAspectFill;
        _adImg.layer.masksToBounds = YES;
        _adImg.layer.borderColor = XRGB(D8, D8, D8).CGColor;
        _adImg.layer.borderWidth = 0.5f;
        _adImg.layer.cornerRadius = 4.f;
//        _adImg.layer.shadowColor = COLOR_PRIMARY.CGColor;
//        _adImg.layer.shadowOffset = CGSizeMake(0, -1);
//        _adImg.layer.shadowOpacity = 0.8;
//        _adImg.layer.shadowRadius = 2;
    }
    return _adImg;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundColor:[UIColor yellowColor]];
        _closeBtn.layer.cornerRadius = 4.f;
        _closeBtn.layer.masksToBounds = YES;
        [_closeBtn addTarget:self action:@selector(closeAd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
