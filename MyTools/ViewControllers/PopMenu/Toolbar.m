//
//  Toolbar.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/20.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Toolbar.h"


@interface Toolbar ()
@property (nonatomic, strong) UIToolbar *bar;
@property (nonatomic, strong) NSArray<UIBarButtonItem *> *items;

@end

@implementation Toolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bar];
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = self.bounds;
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
        layer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,
                         (__bridge id)[UIColor whiteColor].CGColor];
        layer.locations = @[@(0.5),@(1.0)];
        [self.layer addSublayer:layer];

    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bar.frame = CGRectMake(0, 0, self.width - 100.f, self.height);
}
- (void)action1 {
    
}
- (void)action2 {
    
}

- (UIToolbar *)bar {
    if (!_bar) {
        _bar = [[UIToolbar alloc] init];
        _bar.backgroundColor = [UIColor whiteColor];
        _bar.items = self.items;
    }
    return _bar;
}

- (NSArray<UIBarButtonItem *> *)items {
    if (!_items) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"我的用户" style:UIBarButtonItemStylePlain target:self action:@selector(action1)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"数据分析" style:UIBarButtonItemStylePlain target:self action:@selector(action2)];
        
        _items = @[leftItem,rightItem];
    }
    return _items;
}
@end
