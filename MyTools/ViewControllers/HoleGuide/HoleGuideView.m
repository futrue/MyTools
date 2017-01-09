//
//  HoleGuideView.m
//  GXHoleGuideView
//
//  Created by SGX on 16/5/4.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "HoleGuideView.h"
#pragma mark - all hole type objects
@interface Hole : NSObject
@property (nonatomic, assign) HoleType holeType;
@end
@implementation Hole
@end

@interface CircleHole : Hole
@property (nonatomic, assign) CGPoint holeCenterPoint;
@property (nonatomic, assign) CGFloat holeDiameter;
@end
@implementation CircleHole
@end

@interface RectHole : Hole
@property (nonatomic, assign) CGRect holeRect;
@end
@implementation RectHole
@end

@interface RoundRectHole : RectHole
@property (nonatomic, assign) CGFloat holeCornerRadius;
@end
@implementation RoundRectHole
@end

@interface CustomRectHole : RectHole
@property (nonatomic, strong) UIView *customView;
@end
@implementation CustomRectHole
@end

@interface HoleGuideView()
@property (nonatomic, strong) NSMutableArray *holes;
@property (nonatomic, strong) NSMutableArray *focusViews;

@end

@implementation HoleGuideView


-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _holes = [NSMutableArray new];
    _focusViews = [NSMutableArray new];
    self.backgroundColor = [UIColor clearColor];
    _isDarkFocusView = NO;
    _dimmingColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swip];
}

#pragma mark -事件穿透
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        for (UIView *focus in self.focusViews) {
            if (CGRectContainsPoint(focus.frame, point)) {
                return focus;
            }
        }
    }
    return hitView;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == nil) {
        return;
    }
    [self.dimmingColor setFill];
    UIRectFill(rect);
    for (Hole *hole in self.holes) {
        [[UIColor clearColor] setFill];
        if (hole.holeType == HoleTypeRect) {
            RectHole *rectHole = (RectHole *)hole;
//            CGRect holeRectIntersection = CGRectIntersection(rectHole.holeRect, self.frame);
//            UIRectFill(holeRectIntersection);
//            [self configWithContxt:context isDarkFocusView:_isDarkFocusView];
//            CGContextFillRect(context, holeRectIntersection);
//            
            CGRect holeRectIntersection = CGRectIntersection(rectHole.holeRect, self.frame);
            UIRectFill(holeRectIntersection);
            
            UIBezierPath *outerBezierPath = [UIBezierPath bezierPathWithRect:CGRectInset(holeRectIntersection, -4, -4)];
            CGFloat ra[] = {4, 4};
            outerBezierPath.lineCapStyle = kCGLineCapRound;
            [outerBezierPath setLineDash:ra count:2 phase:0];
            
            [[UIColor whiteColor] setStroke];
            [outerBezierPath stroke];
        } else if (hole.holeType == HoleTypeRoundRect) {
            RoundRectHole *roundRectHole = (RoundRectHole *)hole;
            CGRect holeRectIntersection = CGRectIntersection(roundRectHole.holeRect, self.frame);
            UIBezierPath *beizierPath = [UIBezierPath bezierPathWithRoundedRect:holeRectIntersection cornerRadius:roundRectHole.holeCornerRadius];
            CGContextAddPath(UIGraphicsGetCurrentContext(), beizierPath.CGPath);

            [self configWithContxt:context isDarkFocusView:_isDarkFocusView];
            CGContextFillPath(UIGraphicsGetCurrentContext());
        } else if (hole.holeType == HoleTypeCircle) {
            CircleHole *circleHole = (CircleHole *)hole;
            CGRect rectInView = CGRectMake(floorf(circleHole.holeCenterPoint.x - circleHole.holeDiameter*0.5f),
                                           floorf(circleHole.holeCenterPoint.y - circleHole.holeDiameter*0.5f),
                                           circleHole.holeDiameter,
                                           circleHole.holeDiameter);

            [self configWithContxt:context isDarkFocusView:_isDarkFocusView];
            CGContextFillEllipseInRect(context, rectInView);
        } else if (hole.holeType == HoleTypeCustomRect) {
            CustomRectHole *customHole = (CustomRectHole *)hole;
            [customHole.customView setFrame:customHole.holeRect];
            [self addSubview:customHole.customView];
        }
    }
}
- (void)configWithContxt:(CGContextRef)context isDarkFocusView:(BOOL)isDark {
    if (isDark) {
        CGContextSetFillColorWithColor(context, [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor);
        CGContextSetBlendMode(context, kCGBlendModePlusDarker);
    } else {
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextSetBlendMode(context, kCGBlendModeClear);
    }
}

#pragma maek - add hole type  
- (void)addCircleHoleOnCenterPoint:(CGPoint)centerPoint andDiameter:(CGFloat)diameter {
    CircleHole *circleHole = [CircleHole new];
    circleHole.holeType = HoleTypeCircle;
    circleHole.holeCenterPoint = centerPoint;
    circleHole.holeDiameter = diameter;
    [self.holes addObject:circleHole];
    [self setNeedsDisplay];
}

- (void)addRectHoleOnRect:(CGRect)rect {
    RectHole *rectHole = [RectHole new];
    rectHole.holeType = HoleTypeRect;
    rectHole.holeRect = rect;
    [self.holes addObject:rectHole];
    [self setNeedsDisplay];
}

- (void)addRoundRectHole:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius {
    RoundRectHole *roundRectHole = [RoundRectHole new];
    roundRectHole.holeType = HoleTypeRoundRect;
    roundRectHole.holeRect = rect;
    roundRectHole.holeCornerRadius = cornerRadius;
    [self.holes addObject:roundRectHole];
    [self setNeedsDisplay];
}

- (void)addCustomView:(UIView *)customView onRect:(CGRect)rect {
    CustomRectHole *customHole = [CustomRectHole new];
    customHole.holeType = HoleTypeCustomRect;
    customHole.holeRect = rect;
    customHole.customView = customView;
    [self.holes addObject:customHole];
    [self setNeedsDisplay];
}

- (void)addFocusViews:(UIView *)focusView {
    [self.focusViews addObject:focusView];
}

- (void)setDimmingColor:(UIColor *)dimmingColor {
    _dimmingColor = dimmingColor;
    [self setNeedsDisplay];
}
- (void)setIsDarkFocusView:(BOOL)isDarkFocusView {
    _isDarkFocusView = isDarkFocusView;
    if (_isDarkFocusView) {
        _dimmingColor = [UIColor clearColor];
    }
    [self setNeedsDisplay];
}

#pragma mark -  gestrue
- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.TapHoleViewBlock) {
        self.TapHoleViewBlock();
    }
}

- (void)swip:(UISwipeGestureRecognizer *)swip {
    if (self.SwipHoleViewBlock) {
        self.SwipHoleViewBlock();
    }
}

- (void)removeHoles
{
    [self.holes removeAllObjects];
    [self setNeedsDisplay];
}


















@end
