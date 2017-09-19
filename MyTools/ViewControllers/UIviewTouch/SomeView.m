//
//  SomeView.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/7.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SomeView.h"

@implementation SomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *img = [UIImage imageNamed:@"test"];
        self.backgroundColor = [UIColor colorWithPatternImage:img];
    }
    return self;
}

#pragma mark - UIView的触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIView start touch...");
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    //    NSLog(@"%@",touch);
    
    //取得当前位置
    CGPoint current=[touch locationInView:self];
    //取得前一个位置
    CGPoint previous=[touch previousLocationInView:self];
    
    //移动前的中点位置
    CGPoint center=self.center;
    //移动偏移量
    CGPoint offset=CGPointMake(current.x-previous.x, current.y-previous.y);
    
    //重新设置新位置
    self.center=CGPointMake(center.x+offset.x, center.y+offset.y);

    NSLog(@"UIView moving...");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIView touch end.");
}

@end
