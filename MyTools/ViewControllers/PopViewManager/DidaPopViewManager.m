//
//  DidaPopViewManager.m
//  VeloCarPooling
//
//  Created by SongGuoxing on 2018/5/10.
//  Copyright © 2018年 didapinche.com. All rights reserved.
//

#import "DidaPopViewManager.h"

static DidaPopViewManager *_manager = nil;


@interface DidaPopViewManager ()
@property (nonatomic, strong) UIView *showingView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, copy) void (^touchMaskDisapperBlock)();
@end

@implementation DidaPopViewManager

+ (DidaPopViewManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DidaPopViewManager alloc] init];
    });
    return _manager;
}
- (void)showView:(UIView *)view withStartPosition:(PopViewStartPosition)startPosition endPosition:(PopViewEndPosition)endPosition touchMaskDisapperHandler:(void(^)())handler {
    if (self.showingView) {
        return;
    }
    UIView *superView = [UIApplication sharedApplication].keyWindow;// window
    if (handler) {
        [self.maskView addGestureRecognizer:self.tapGestureRecognizer];
        self.touchMaskDisapperBlock = handler;
    }
    [superView addSubview:self.maskView];
    [superView addSubview:view];

//    [view sizeToFit];
        CGSize size = [view systemLayoutSizeFittingSize:CGSizeZero];
    view.centerX = superView.centerX;
    CGFloat originY,endY;

    switch (startPosition) {
        case PopViewStartPositionTop:
            originY = 0 - view.height;
            break;
        case PopViewStartPositionBottom:
            originY = superView.height;
            break;
            
        default:
            originY = superView.height / 2 - view.height;
            break;
    }
    
    switch (endPosition) {
        case PopViewEndPositionTop:
            endY = 0;
            break;
        case PopViewEndPositionBottom:
            endY = self.maskView.height - view.height;
            break;
            
        default:
            endY = self.maskView.height / 2 - view.height / 2;
            break;
    }
    self.originY = originY;
    view.y = endY;
    
    [view setTransform:CGAffineTransformMakeTranslation(0, self.originY)];
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [view setTransform:CGAffineTransformIdentity];
        self.showingView = view;
        self.maskView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            self.maskView.userInteractionEnabled = YES;
        }
    }];
    
}

- (void)showView:(UIView *)view withStartPosition:(PopViewStartPosition)startPosition endPosition:(PopViewEndPosition)endPosition {
    [self showView:view withStartPosition:startPosition endPosition:endPosition touchMaskDisapperHandler:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        [self.showingView setTransform:CGAffineTransformMakeTranslation(0, self.originY)];
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.showingView removeFromSuperview];
        _showingView = nil;
        if (finished && self.touchMaskDisapperBlock) {
            self.touchMaskDisapperBlock();
        }
    }];
}

- (void)tapOnMask {
    [self dismiss];
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = XRGBA(0, 0, 0, 0.5); // 默认颜色
    }
    return _maskView;
}

#pragma mark - Lazy
- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMask)];
    }
    return _tapGestureRecognizer;
}

@end
