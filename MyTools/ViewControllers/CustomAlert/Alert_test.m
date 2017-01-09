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

@interface Alert_test ()<GXAlertDelegate>

@end

@implementation Alert_test

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];

    for (int i = 0; i < 3; i++) {
        NSArray *arr = @[@"alert",@"notifyView",@"actionSheet"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor grayColor]];
        button.layer.cornerRadius = 4;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setFrame:CGRectMake((80 + 50) * i, 200, 80, 44)];
        [self.view addSubview:button];
        SEL sel = NSSelectorFromString(arr[i]);
        [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }
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

- (void)_notifyView {
    //    GXNotifyView *noti = [[GXNotifyView alloc] initWithMessage:@"ssss"];
    //    [noti show];
    //    [[[GXNotifyView alloc] initWithMessage:@"test"] show];
    
    //    [GXNotifyView showBaseLoding];
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
