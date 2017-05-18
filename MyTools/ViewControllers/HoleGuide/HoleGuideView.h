//
//  HoleGuideView.h
//  GXHoleGuideView
//
//  Created by SGX on 16/5/4.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HoleType) {
    HoleTypeCircle,
    HoleTypeRect,
    HoleTypeRoundRect,
    HoleTypeCustomRect
};


@interface HoleGuideView : UIView
@property (nonatomic, strong) UIColor *dimmingColor;// 暗光颜色
@property (copy, nonatomic) void (^blockTaped)();
@property (copy, nonatomic) void (^blockSwipped)();
@property (nonatomic, copy) void (^TapHoleViewBlock)();
@property (nonatomic, copy) void (^SwipHoleViewBlock)();
@property (nonatomic, assign) BOOL isDarkFocusView;

// * 圆  */
- (void)addCircleHoleOnCenterPoint:(CGPoint)centerPoint andDiameter:(CGFloat)diameter;
// * 矩形  */
- (void)addRectHoleOnRect:(CGRect)rect;
// * 圆角矩形 */
- (void)addRoundRectHole:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius;
// * 自定义View */
- (void)addCustomView:(UIView *)customView onRect:(CGRect)rect;
// * 事件穿透 */
- (void)addFocusViews:(UIView *)focusView;

- (void)removeHoles;

@end
