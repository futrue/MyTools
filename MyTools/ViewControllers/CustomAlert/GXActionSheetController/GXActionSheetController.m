//
//  GXActionSheetController.m
//  GXAlertView
//
//  Created by SGX on 16/4/25.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "GXActionSheetController.h"

//#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
//#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define XRGB(r,g,b) [UIColor colorWithRed:(0x##r)/255.0 green:(0x##g)/255.0 blue:(0x##b)/255.0 alpha:1]
#define XRGBA(r,g,b,a) [UIColor colorWithRed:(0x##r)/255.0 green:(0x##g)/255.0 blue:(0x##b)/255.0 alpha:(a)]
@interface GXActionSheetAction ()

-(void)invoke;

@end
@implementation GXActionSheetAction

- (id)initWithTitle:(NSString *)title andAction:(ActionSheetHandle)handle {
    self = [super init];
    if (self) {
        _title = title;
        _handle = handle;
    }
    return self;
}

- (void)invoke {
    if (_handle) {
        _handle(self);
    }
}

@end



@interface GXActionSheetController ()

@end

@implementation GXActionSheetController

- (id)initWithTitle:(NSString *)title Actions:(NSArray *)actions {
    if ([super init]) {
        self.title = title;
        _actions = [[NSMutableArray alloc] initWithArray:actions];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [_cancelBtn setBackgroundColor:XRGB(f2, f2, f2)];
    [_cancelBtn setTitle:_cancelText.length > 0 ? _cancelText:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *previousView = _cancelBtn;
    CGFloat padding = 5.0f;
    for ( NSInteger i = [_actions count]; i > 0; i --) {
        GXActionSheetAction *action = _actions[i - 1];
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [actionBtn setTitle:action.title forState:UIControlStateNormal];
        [actionBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [actionBtn setBackgroundColor:XRGB(f2, f2, f2)];
        if (action.highlight) {
            [actionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        } else {
            [actionBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
        }
        [actionBtn setFrame:CGRectMake(0, CGRectGetMinY(previousView.frame)- 50 -padding, SCREEN_WIDTH, 50)];
        [self.view addSubview:actionBtn];
        [actionBtn addTarget:action action:@selector(invoke) forControlEvents:UIControlEventTouchUpInside];

        previousView = actionBtn;
        padding = 1;
    }
   
    if (self.content) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self.view addSubview:_contentLabel];
        [_contentLabel setFont:[UIFont systemFontOfSize:12]];
        [_contentLabel setTextColor:[UIColor redColor]];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [_contentLabel setBackgroundColor:XRGB(f2, f2, f2)];
        [_contentLabel setText:_content];
//        [_contentLabel sizeToFit];
        [_contentLabel setFrame:CGRectMake(0, CGRectGetMinY(previousView.frame)-40, SCREEN_WIDTH, _contentLabel.bounds.size.height)];
    }
    if (self.title) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45 - previousView.bounds.size.height, SCREEN_WIDTH, 45)];
        [self.view addSubview:titleLabel];
        [titleLabel setFont:[UIFont systemFontOfSize:13]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setBackgroundColor:XRGB(f2, f2, f2)];
        [titleLabel setTextColor:[UIColor redColor]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setText:self.title];
        CGRect titleFrame = titleLabel.frame;
        if (self.content) {
            titleFrame.origin.y = CGRectGetMinY(_contentLabel.frame) - 40;
        } else {
            titleFrame.origin.y = CGRectGetMinY(previousView.frame)-1 - 44;
        }
        [titleLabel setFrame:titleFrame];
    }
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        _background = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        CGFloat height =  (_actions.count + 1) * 50 + padding;
        [_background setFrame:CGRectMake(0, self.view.bounds.size.height - height, SCREEN_WIDTH, height)];
        [self.view addSubview:_background];
        [self.view sendSubviewToBack:_background];
    }
    
}

- (void)cancel {
    if (_cancelAction) {
        _cancelAction(nil);
    } else {
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setCancelText:(NSString *)cancelText {
    _cancelText = cancelText;
    [_cancelBtn setTitle:_cancelText.length > 0 ? _cancelText : @"取消" forState:UIControlStateNormal];
}
@end
