//
//

#import "animation.h"

@implementation animation

- (void)drawRect:(CGRect)rect {

    //半径
    CGFloat redbius =_CGfrom_x/2;
    //开始角度
    CGFloat startAngle = 0;
    //中心点
    CGPoint point = CGPointMake(_CGfrom_x/2, _CGfrom_x/2);
    //结束角
    CGFloat endAngle = 2*M_PI;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:redbius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path=path.CGPath;   //添加路径
    layer.strokeColor= [UIColor redColor].CGColor;
    layer.fillColor= [UIColor blueColor].CGColor;
    [self.layer addSublayer:layer];

}
//-(void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    [[UIColor redColor] setFill];
//    UIRectFill(rect);
//    NSInteger pulsingCount = 5;
//    double animationDuration = 3;
//    CALayer * animationLayer = [CALayer layer];
//    for (int i = 0; i < pulsingCount; i++) {
//        CALayer * pulsingLayer = [CALayer layer];
//        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//        pulsingLayer.borderColor = [UIColor blueColor].CGColor;
//        pulsingLayer.borderWidth = 1;
//        pulsingLayer.cornerRadius = rect.size.height / 2;
//
//        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//
//        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
//        animationGroup.fillMode = kCAFillModeBackwards;
//        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
//        animationGroup.duration = animationDuration;
//        animationGroup.repeatCount = HUGE;
//        animationGroup.timingFunction = defaultCurve;
//
//        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        scaleAnimation.fromValue = @1.4;
//        scaleAnimation.toValue = @2.2;
//
//        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
//        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
//
//        animationGroup.animations = @[scaleAnimation, opacityAnimation];
//        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
//        [animationLayer addSublayer:pulsingLayer];
//    }
//    [self.layer addSublayer:animationLayer];
//}

@end
