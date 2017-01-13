//
//  GXSlideBtn.m
//  GXSliderView
//
//  Created by SGX on 16/10/19.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "GXSlideBtn.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface GXSlideBtn ()
@property (nonatomic, strong) NSArray <UIButton *> *buttonArray;
@property (nonatomic, strong) UIView *indicatorView;


@end

@implementation GXSlideBtn


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    }
    return self;
}

- (void)touched:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideViewDidSelectedIndex:)]) {
        [self.delegate slideViewDidSelectedIndex:sender.tag];
    }
    self.selectedIndex = sender.tag;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex == selectedIndex) {
        return;
    }
    _selectedIndex = selectedIndex;
    if ([self.buttonArray count] && [self.buttonArray count] > _selectedIndex) {
        [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj setSelected:idx == _selectedIndex];
        }];
    }
    
}
- (void)setIndexProgress:(CGFloat)indexProgress {
    _indexProgress = indexProgress;
    /* 取整方法
     * 1:   float + 0.5
     * 2:   roundf(float)
     */
    self.selectedIndex = roundf(indexProgress);
    CGFloat width = SCREEN_WIDTH / 3;
    CGRect rect = self.indicatorView.frame;
    CGFloat space = (width - rect.size.width) * 0.5;
    rect.origin.x = self.bounds.size.width / self.titleArray.count * indexProgress + space;
    self.indicatorView.frame = rect;    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupButtons];

    NSString *string = @"";
    for (NSString *temp in self.titleArray) {
        if (temp.length) {
            string = temp.length > string.length ? temp : string;
        }
    }
    CGFloat baseWidth = [string sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
    CGFloat indicatorWidth = self.isFullIndicator ? self.bounds.size.width / self.titleArray.count : baseWidth;
    CGFloat x = ((self.bounds.size.width / self.titleArray.count) - indicatorWidth) / 2;
    if (self.selectedIndex) {
        [self.buttonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj setSelected:idx == _selectedIndex];
        }];
        x += (self.bounds.size.width / self.titleArray.count) * self.selectedIndex;
    }
    self.indicatorView.frame = CGRectMake(x, 43, indicatorWidth, 3);
    [self addSubview:self.indicatorView];

}

- (void)setupButtons {
    CGFloat width = self.bounds.size.width / self.titleArray.count;
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor ? self.titleColor : [UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:self.titleSelectedColor ? self.titleSelectedColor : [UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:self.titleSelectedColor ? self.titleSelectedColor : [UIColor redColor] forState:UIControlStateSelected | UIControlStateHighlighted];
        [button.titleLabel setFont:self.font ? self.font : [UIFont systemFontOfSize:16]];
        self.font = button.titleLabel.font;
        
        if (i== 0) {
            [button setSelected:YES];
        }
        button.frame = CGRectMake(width * i, 0, width-1, 44);
        
        [self addSubview:button];
        
        [array addObject:button];
    }
    self.buttonArray = array.copy;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

@end
