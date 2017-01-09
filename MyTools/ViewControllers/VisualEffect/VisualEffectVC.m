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
    
    // UIView相关
    
    [self.view addSubview:self.inputView1];
    [self.view addSubview:self.inputView2];
    [self.view addSubview:self.button];
    self.showFirstView = YES;
    [self.view addSubview:self.slider];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"837003.jpg"]];
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


- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor orangeColor];
        _button.frame = CGRectMake(20, self.view.bounds.size.height - 80, 40, 40);
        _button.layer.cornerRadius = 4;
        _button.layer.masksToBounds = YES;
        [_button setBackgroundImage:[UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)change:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    self.showFirstView = btn.selected;
}

- (void)setShowFirstView:(BOOL)showFirstView {
    _showFirstView = showFirstView;
    
    if (_showFirstView) {
        CGPoint center = self.inputView1.center;
        center.x = self.view.bounds.size.width / 2;
        
        CGPoint center2 = self.inputView2.center;
        center2.x = center.x + self.view.bounds.size.width;
        
        [UIView animateWithDuration:1 animations:^{
            self.inputView1.center = center;
            self.inputView2.center = center2;
            
        } completion:nil];
        
        
    } else {
        CGPoint center = self.inputView1.center;
        center.x = self.view.bounds.size.width / 2;
        
        CGPoint center2 = self.inputView2.center;
        center2.x = center.x - self.view.bounds.size.width;
        
        [UIView animateWithDuration:1 animations:^{
            self.inputView1.center = center2;
            self.inputView2.center = center;
            
        } completion:nil];
        
    }
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(100, self.view.bounds.size.height - 80, self.view.bounds.size.width - 200, 40)];
        _slider.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (void)valueChange:(UISlider *)slider {
    CGFloat progress = slider.value;
    self.effectView.alpha = progress;
    //    CGPoint center = self.imageView.center;
    //    CGRect frame = self.imageView.frame;
    //    frame.size.width  *= (1 + progress);
    //    frame.size.height *= (1 + progress);
    //    self.imageView.frame = frame;
}

- (UIView *)inputView1 {
    if (!_inputView1) {
        _inputView1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height - 150, self.view.bounds.size.width - 20, 30)];
        _inputView1.backgroundColor = [UIColor redColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"";
    }
    return _inputView1;
}

- (UIView *)inputView2 {
    if (!_inputView2) {
        _inputView2 = [[UIView alloc] initWithFrame:CGRectMake((self.inputView1.center.x + self.view.bounds.size.width) - (self.view.bounds.size.width - 20)/2, self.view.bounds.size.height - 150, self.view.bounds.size.width - 20, 30)];
        _inputView2.backgroundColor = [UIColor yellowColor];
    }
    return _inputView2;
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
