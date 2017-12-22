//
//  SubTestView.m
//  MyTools
//
//  Created by SongGuoxing on 2017/10/12.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SubTestView.h"

@implementation SubTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)log {
//    [super log];
    NSLog(@"sub log");
//    [NSException raise:NSInternalInconsistencyException format:@"you must override %@ in a subclass",NSStringFromSelector(_cmd)];
}

@end
