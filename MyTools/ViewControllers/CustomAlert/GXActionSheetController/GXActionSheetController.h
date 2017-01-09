//
//  GXActionSheetController.h
//  GXAlertView
//
//  Created by SGX on 16/4/25.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXActionSheetAction;
typedef void (^ActionSheetHandle)(GXActionSheetAction *action);
@interface GXActionSheetAction : NSObject {
    ActionSheetHandle _handle;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL highlight;

- (id)initWithTitle:(NSString *)title andAction:(ActionSheetHandle)handle;
@end

@interface GXActionSheetController : UIViewController {
    UILabel *_contentLabel;
    UIButton *_cancelBtn;
    UIVisualEffectView *_background;
    NSMutableArray *_actions;
}

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *cancelText;

@property (nonatomic, copy) ActionSheetHandle cancelAction;
- (id)initWithTitle:(NSString *)title Actions:(NSArray *)actions;

@end
