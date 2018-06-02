//
//  DidaPopViewManager.h
//  VeloCarPooling
//
//  Created by SongGuoxing on 2018/5/10.
//  Copyright © 2018年 didapinche.com. All rights reserved.
//

#import <Foundation/Foundation.h>
// 弹窗使用请见 DidaPopViewManager
/**
 弹窗起点
 */
typedef NS_ENUM(NSInteger,PopViewStartPosition) {
    PopViewStartPositionCenter,// 中心
    PopViewStartPositionTop,   // 顶部
    PopViewStartPositionBottom,// 底部
};

/**
 弹窗终点
 */
typedef NS_ENUM(NSInteger,PopViewEndPosition) {
    PopViewEndPositionCenter,// 中心
    PopViewEndPositionTop,   // 顶部
    PopViewEndPositionBottom,// 底部
};

@interface DidaPopViewManager : NSObject

+ (DidaPopViewManager *)sharedManager;

- (void)showView:(UIView *)view withStartPosition:(PopViewStartPosition)startPosition endPosition:(PopViewEndPosition)endPosition touchMaskDisapperHandler:(void(^)())handler;

- (void)showView:(UIView *)view withStartPosition:(PopViewStartPosition)startPosition endPosition:(PopViewEndPosition)endPosition;;

- (void)dismiss;

@end
