//
//  GXScrollView.m
//  GXSliderView
//
//  Created by SGX on 16/10/19.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "GXScrollView.h"
#import "GXSlideBtn.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GXScrollView ()<UIScrollViewDelegate,GXSlideBtnDelegate>
@property (nonatomic, strong) GXSlideBtn *slideView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GXScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.slideView];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.slideView];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.slideView.titleArray = self.titleArray;
    self.slideView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 45);
    self.scrollView.frame = CGRectMake(0, 45 + self.midSpace, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 45 - self.midSpace);
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)* self.itemViews.count, CGRectGetHeight(self.bounds));
    [self.itemViews enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = CGRectMake(idx*CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        [_scrollView addSubview:view];
    }];
    if (self.selectedIndex && self.selectedIndex < self.titleArray.count) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.selectedIndex * self.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height) animated:NO];
    }

}

#pragma mark - <UISlideViewDelegate>
- (void)slideViewDidSelectedIndex:(NSInteger)index {
    self.selectedIndex = index;
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(index * self.bounds.size.width, 0);
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat f = scrollView.contentOffset.x/self.bounds.size.width;
    self.slideView.indexProgress = f;
    self.selectedIndex = roundf(f);
}


- (GXSlideBtn *)slideView {
    if (!_slideView) {
        _slideView = [[GXSlideBtn alloc] init];
        _slideView.delegate = self;
    }
    return _slideView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.slideView.selectedIndex = selectedIndex;
}
@end
