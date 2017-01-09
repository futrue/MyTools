//
//  GXAlertView.h
//  GXAlertView
//
//  Created by SGX on 16/4/22.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertDismissType) {
    AlertCancelled = 0,
    AlertConfirmed = 1
};

@class GXAlertView,GXAlertAction;
@protocol GXAlertDelegate <NSObject>

- (void)alert:(GXAlertView *)alert dismissBy:(AlertDismissType)type;

@end
typedef void(^AlertActionHandler) (GXAlertAction *action);

// AlertAction 看似无用， 其实可看成是对 AlertView 的一个扩展，如果我再加一个操作（取消、确认除外），就用到了action，只需关心弹出alertview后点击了什么，而不需判断 他所在的index
@interface GXAlertAction : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) AlertActionHandler handler;

- (id)initWithTitle:(NSString *)title withAction:(AlertActionHandler)action;
@end


@interface GXAlertView : UIView
{
    UILabel *_titleLabel;    /// * title
    UILabel *_contentLabel;  /// * description
    UIButton *_cancelBtn;    /// * 取消按钮
    UIButton *_confirmBtn;   /// * 确认按钮
    
    UIView *_horizontalLine; /// * 取消、确认 顶部线
    UIView *_verticalLine;   /// * 取消、确认 分割线
    UIImageView *_titleImageView; // 图片
    
    NSMutableArray *_buttonArr; /// * 取消、确认
    
    BOOL _hasInit;           /// * 记录是否初始化
    UIView *_hostView;      // self 载体 view
}

@property (nonatomic, weak) id<GXAlertDelegate> alertDelegate;
/* 
 *  title
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleImageName;
@property (nonatomic, weak) UIColor *titleColor;
/*
 * content
 */
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSAttributedString *attributedContent;
@property (nonatomic, retain) UIView *customContentView; /// * 自定义的contentView
/*
 *  choose
 */
@property (nonatomic, copy) NSString *cancelText;
@property (nonatomic, copy) NSString *confirmText;
@property (nonatomic, weak) UIColor *btnTextColor;
@property (nonatomic, assign) BOOL hideConfirm; /// * 隐藏确认btn

@property (nonatomic, retain) NSArray *buttonActions;

@property (nonatomic, readonly, getter=isVisible) BOOL visible;

/*
 *  method
 */
- (void) show;
- (void) dismiss;


@end
