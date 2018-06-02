//
//  VisualEffectVC.m
//  MyTools
//
//  Created by SGX on 17/1/6.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "VisualEffectVC.h"

@interface VisualEffectVC ()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;
@property (nonatomic, strong) UIScrollView       *scrollView;
@property (nonatomic, strong) UIButton           *button;
@property (nonatomic, strong) UIView             *inputView1;
@property (nonatomic, strong) UIView             *inputView2;
@property (nonatomic, strong) UIImageView        *imageView;
@property (nonatomic, assign) BOOL               showFirstView;
@property (nonatomic, strong) UISlider           *slider;

@end

@implementation VisualEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 毛玻璃相关
    [self.view addSubview:self.scrollView];
    self.effectView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:self.effectView];
    [self.effectView.contentView addSubview:self.vibrancyEffectView];
    
    [self.view addSubview:self.slider];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:TEST_IMG];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.clipsToBounds = YES;
        self.imageView = imageView;
        _scrollView.contentSize = imageView.image.size;
        [_scrollView addSubview:imageView];
    }
    return _scrollView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        _effectView.userInteractionEnabled = NO;
        _effectView.alpha = 0.5;
        _effectView.frame = CGRectMake(20, 20, 240, 180);
        _effectView.center = self.view.center;
    }
    return _effectView;
}

- (UIVisualEffectView *)vibrancyEffectView {
    if (!_vibrancyEffectView) {
        _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _vibrancyEffectView.frame = CGRectMake(20, 60, 150, 200);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 120, 40)];
        label.text = @"hey,girl";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:30];
        [_vibrancyEffectView.contentView addSubview:label];
        
    }
    return _vibrancyEffectView;
}
/*
 typedef NS_ENUM(NSInteger, UIBlurEffectStyle) {
 UIBlurEffectStyleExtraLight,
 UIBlurEffectStyleLight,
 UIBlurEffectStyleDark,
 UIBlurEffectStyleExtraDark __TVOS_AVAILABLE(10_0) __IOS_PROHIBITED __WATCHOS_PROHIBITED,
 UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
 UIBlurEffectStyleProminent NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
 } NS_ENUM_AVAILABLE_IOS(8_0);
 
 */



- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(100, self.view.bounds.size.height - 80, self.view.bounds.size.width - 200, 40)];
        _slider.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        [_slider addRoundedCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadius:10];

        [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (void)valueChange:(UISlider *)slider {
    CGFloat progress = slider.value;
    self.effectView.alpha = progress;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
