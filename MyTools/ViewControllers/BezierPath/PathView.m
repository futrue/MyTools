//
//  PathView.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/3.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "PathView.h"

@implementation PathView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    /*
     // 创建弧线路径
     + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
     // 通过CGPath创建
     + (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;
     链接：http://www.jianshu.com/p/6c9aa9c5dd68
     */
    [[UIColor redColor] set];

    UIBezierPath* path = [UIBezierPath bezierPath];
    // 直线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(20, 20)];// 起点
    [linePath addLineToPoint:CGPointMake(100, 100)];
    
    // 矩形
    UIBezierPath *Rect = [UIBezierPath bezierPathWithRect:CGRectZero];
    // 圆角矩形
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectZero cornerRadius:4];
    //指定位置圆角矩形
    UIBezierPath *roundedCornerRect = [UIBezierPath bezierPathWithRoundedRect:CGRectZero byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(30, 30)];
    // 圆形
    UIBezierPath *round = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    /* 创建弧线路径
     center：弧线圆心坐标
     radius：弧线半径
     startAngle：弧线起始角度
     endAngle：弧线结束角度
     clockwise：是否顺时针绘制
    */
    UIBezierPath *arcpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 200)
                                                        radius:75
                                                    startAngle:0
                                                      endAngle:3.1415926  / 2
                                                     clockwise:YES];
    arcpath.lineWidth = 15.f;
    arcpath.lineCapStyle = kCGLineCapRound;
    arcpath.lineJoinStyle = kCGLineJoinBevel;
    [arcpath stroke];
    //
    
    path.lineWidth     = 10.f;// 线宽
    path.lineCapStyle  = kCGLineCapButt;// 终点类型
    /*
    typedef CF_ENUM(int32_t, CGLineCap) {
        kCGLineCapButt,  // 感觉 和 kCGLineCapSquare没啥太大的区别
        kCGLineCapRound, // 圆角
        kCGLineCapSquare // 正方形
    };
    */
    path.lineJoinStyle = kCGLineJoinMiter;// 交叉点的类型
    /*
     typedef CF_ENUM(int32_t, CGLineJoin) {
     kCGLineJoinMiter,  // 尖的
     kCGLineJoinRound,  // 圆角
     kCGLineJoinBevel   // 切角
     };
     */
    [path stroke];// 路径绘制
    [path addClip];// 在这以后的图形绘制超出当前路径范围则不可见
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 5.f;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:CGPointMake(30, 100)];
    //    给定终点和控制点绘制贝塞尔曲线
    
    // 一个控制点（一个曲面）
//    [bezierPath addQuadCurveToPoint:CGPointMake(200, 150) controlPoint:CGPointMake(100, 50)];
    // 两个控制点（两个曲面）
    [bezierPath addCurveToPoint:CGPointMake(300, 100) controlPoint1:CGPointMake(120, 50) controlPoint2:CGPointMake(210, 150)];
    
    [bezierPath stroke];
    
    // 扇形
    [[UIColor blueColor] set];
    UIBezierPath *fanShaped = [UIBezierPath bezierPath];
    [fanShaped moveToPoint:CGPointMake(100, 200)]; // 设置起始点
    [fanShaped addArcWithCenter:CGPointMake(100, 200) radius:80 startAngle:0 endAngle:3.14159 / 2 clockwise:NO];
    fanShaped.lineWidth = 5.f;
    fanShaped.lineCapStyle = kCGLineCapRound;
    fanShaped.lineJoinStyle = kCGLineJoinRound;
    [fanShaped closePath];
    [fanShaped stroke];
    
    [self customRect];
}

- (void)customRect {
    [[UIColor purpleColor] set];
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    path.lineWidth     = 5.f;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    // 起点
    [path moveToPoint:CGPointMake(200, 300)];
    
    // 添加直线
    [path addLineToPoint:CGPointMake(250, 300)];
    [path addLineToPoint:CGPointMake(300, 350)];
    [path addLineToPoint:CGPointMake(300, 400)];
    [path addLineToPoint:CGPointMake(250, 450)];
    [path addLineToPoint:CGPointMake(200, 450)];
    [path addLineToPoint:CGPointMake(150, 400)];
    [path addLineToPoint:CGPointMake(150, 350)];
    [path closePath];
    
    //根据坐标点连线
    [path stroke];
    // 填充
    [path fill];
}

@end
