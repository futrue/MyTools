//
//  Alert_test.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Alert_test.h"

#import "GXAlertView.h"
#import "GXActionSheetController.h"
#import "GXNotifyView.h"

#import "HYActivityView.h"
#import "UIView+Tools.h"

@interface Alert_test ()<GXAlertDelegate>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation Alert_test

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 系统弹窗
    UIButton *alert = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 140, 100, 80, 40)];
    [alert setTitle:@"alert" forState:UIControlStateNormal];
    alert.backgroundColor = RandomColor;
    [alert addTarget:self action:@selector(systemAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alert];
    [alert addBottomBorderWithColor:[UIColor redColor] andWidth:0.5];
    
    UIButton *sheet = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 60, 100, 80, 40)];
    [sheet setTitle:@"sheet" forState:UIControlStateNormal];
    sheet.backgroundColor = RandomColor;
    [sheet addTarget:self action:@selector(systemSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sheet];
    [sheet addTopBorderWithColor:[UIColor redColor] andWidth:1];

    // 自定义弹窗
    NSArray *arr = @[@"alert",@"notifyView",@"actionSheet",@"HYActivityView"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor grayColor]];
//        button.layer.cornerRadius = 4;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.contentEdgeInsets = UIEdgeInsetsMake(3, 6, 3, 6);
        [button sizeToFit];
        button.center = CGPointMake(SCREEN_WIDTH / 2, 200 + 60 * i);
        [self.view addSubview:button];
        SEL sel = NSSelectorFromString(arr[i]);
        [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        if (i == 1) {
            [self setCorner:button];
        }
          if (i== 3) {
            self.button = button;
          }
    }
}

- (void)systemAlert {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"alert" message:@"something" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"userName";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"password";
        textField.secureTextEntry = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *login = alertC.textFields.firstObject;
        UITextField *passWord = alertC.textFields.lastObject;
        NSLog(@"%@",login.text);
        NSLog(@"%@",passWord.text);
    }];
    
//    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
//    [alertC addAction:delete];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
}

- (void)systemSheet {
    UIAlertController *sheetC = [UIAlertController alertControllerWithTitle:@"sheet" message:@"wrming" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [sheetC addAction:deleteAction];
    [sheetC addAction:cancelAction];
    [sheetC addAction:saveAction];
    [self presentViewController:sheetC animated:YES completion:nil];
}

- (void)alertTextFieldDidChange:(NSNotification *)notifition {
    UIAlertController *alertContrller = (UIAlertController *)self.presentedViewController;
    if (alertContrller) {
        UITextField *login = alertContrller.textFields.firstObject;
        UIAlertAction *okAction = alertContrller.actions.lastObject;
        okAction.enabled = login.text.length > 2;
        
    }
}


- (void)setCorner:(UIButton *)btn {
    CGRect rect = CGRectMake(0, 0, 100, 50);
    CGSize radio = CGSizeMake(15, 2);
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = path.CGPath;
    btn.layer.mask = maskLayer;
}

- (void)alert {
    [self performSelector:@selector(_alertView) withObject:nil];

}
- (void)notifyView {
    [self performSelector:@selector(_notifyView) withObject:nil];
}

- (void)actionSheet {
    [self performSelector:@selector(_actionSheet) withObject:nil];
}

- (void)HYActivityView {
    [self buttonClicked:self.button];
}

- (void)_notifyView {
    [GXNotifyView showLoadingWithText:@"loading..."];
    [self performSelector:@selector(hide) withObject:nil afterDelay:2];
}
- (void)hide {
    [GXNotifyView hide];
}

- (void)_actionSheet {
    GXActionSheetController *sheet = nil;
    GXActionSheetAction *action1 = [[GXActionSheetAction alloc] initWithTitle:@"yes" andAction:^(GXActionSheetAction *action) {
        NSLog(@"=====");
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    GXActionSheetAction *action2 = [[GXActionSheetAction alloc] initWithTitle:@"no" andAction:^(GXActionSheetAction *action) {
        NSLog(@"----");
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    sheet = [[GXActionSheetController alloc] initWithTitle:@"delete it？" Actions:@[action1,action2]];
    
    sheet.cancelAction = ^(GXActionSheetAction *action) {
        NSLog(@"cancel");
    };
    
    sheet.cancelText = @"取消";
    [self presentViewController:sheet animated:YES completion:nil];
}



- (void)_alertView {
    GXAlertView *alertView = [[GXAlertView alloc] init];
    //    alertView.title = @"alert";
    alertView.titleImageName = @"icon_personal_homepage";
    alertView.content = @"delete etBackgroundColoeater:[UIColor greenColor]][button setTitle:?";
    
    //    UIImage *image = [UIImage imageNamed:@"icon_personal_homepage"];
    //    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //    imageV.image = image;
    //    alertView.customContentView = imageV;
    
    alertView.cancelText = @"cancel";
    alertView.confirmText = @"sure";
    alertView.btnTextColor = [UIColor colorWithRed:255 green:139 blue:15 alpha:1];
    alertView.alertDelegate = self;
    [alertView show];
}
#pragma mark - GXAlertView delegate
- (void)alert:(GXAlertView *)alert dismissBy:(AlertDismissType)type {
    if (type == AlertCancelled) {
        NSLog(@"quxiao");
    } else {
        NSLog(@"queren");
    }
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
}



///===================================
- (void)addButtonClicked:(UIButton *)button
{
    ButtonView *bv = [[ButtonView alloc]initWithText:@"新浪微博" image:[UIImage imageNamed:@"share_platform_sina"] handler:^(ButtonView *buttonView){
        NSLog(@"点击新增的新浪微博");
    }];
    [self.activityView addButtonView:bv];
}

- (void)buttonClicked:(UIButton *)button
{
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv = [[ButtonView alloc]initWithText:@"新浪微博" image:[UIImage imageNamed:@"share_platform_sina"] handler:^(ButtonView *buttonView){
            NSLog(@"点击新浪微博");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"Email" image:[UIImage imageNamed:@"share_platform_email"] handler:^(ButtonView *buttonView){
            NSLog(@"点击Email");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"印象笔记" image:[UIImage imageNamed:@"share_platform_evernote"] handler:^(ButtonView *buttonView){
            NSLog(@"点击印象笔记");
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"QQ" image:[UIImage imageNamed:@"share_platform_qqfriends"] handler:^(ButtonView *buttonView){
            NSLog(@"点击QQ");
        }];
        [self.activityView addButtonView:bv];
        
        //        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"share_platform_wechat"] handler:^(ButtonView *buttonView){
        //            NSLog(@"点击微信");
        //        }];
        //        [self.activityView addButtonView:bv];
        //
        //        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"share_platform_wechattimeline"] handler:^(ButtonView *buttonView){
        //            NSLog(@"点击微信朋友圈");
        //        }];
        //        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
