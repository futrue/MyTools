//
//  TestView.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/12.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TestView.h"

@interface TestView ()
@property (nonatomic) CADisplayLink *displayLink;

@end

@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"initWithFrame:%@" ,NSStringFromCGRect(frame));
    }
    return self;
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews %@", self);
    [super layoutSubviews];
}


- (void)changeRandomColor {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
//    self.displayLink.paused = YES;
    self.displayLink.preferredFramesPerSecond = 3;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)change {
//    self.displayLink.paused = NO;

    self.backgroundColor = RandomColor;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
