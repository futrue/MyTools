//
//  SystemActions_test.m
//  MyTools
//
//  Created by SGX on 17/1/13.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SystemActions_test.h"

@interface SystemActions_test ()
@property (nonatomic, strong) UIButton *btn;

@end

@implementation SystemActions_test

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"button" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(50, 400, 100, 50);
    addBtn.tag = 1;
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btn = addBtn;
    [self.view addSubview:self.btn];
}

- (void)addClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 1:
        {
            NSString *phoneNumber=@"18500138888";
            //    NSString *url=[NSString stringWithFormat:@"tel://%@",phoneNumber];//这种方式会直接拨打电话
            NSString *url=[NSString stringWithFormat:@"telprompt://%@",phoneNumber];//这种方式会提示用户确认是否拨打电话
            [self openUrl:url];
            
        }
            break;
        case 2:
        {
            NSString *phoneNumber=@"18500138888";
            NSString *url=[NSString stringWithFormat:@"sms://%@",phoneNumber];
            [self openUrl:url];
        }
            break;
        case 3:
        {
            NSString *mailAddress=@"kenshin@hotmail.com";
            NSString *url=[NSString stringWithFormat:@"mailto://%@",mailAddress];
            [self openUrl:url];
            
        }
            break;
        case 4:
        {
            NSString *url=@"http://www.cnblogs.com/kenshincui";
            [self openUrl:url];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)openUrl:(NSString *)urlStr{
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
}


@end
