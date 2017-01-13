//
//  CustomButton_test.m
//  MyTools
//
//  Created by SGX on 17/1/13.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CustomButton_test.h"
#import "GXCustomButton.h"

@interface CustomButton_test ()
@property (nonatomic, strong) GXCustomButton *button;
@property (nonatomic, strong) GXCustomButton *button2;

@end

@implementation CustomButton_test

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:self.button];
    
    self.button2.frame = CGRectMake(30, 100, 100, 100);
    self.button2.backgroundColor = [UIColor yellowColor];
    [self.button2 setTitle:@"测试一下" forState:UIControlStateNormal];
    [self.button2 setImage:[UIImage imageNamed:@"userLogo"] forState:UIControlStateNormal];
    [self.view addSubview:self.button2];
    [self.button2 addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
}


- (GXCustomButton *)button {
    if (!_button) {
        _button = [[GXCustomButton alloc] initWithImageName:@"userLogo" title:@"点我试试" imageAlignmentType:ImageAlignmentTypeLeft];
        _button.frame = CGRectMake(0, 0, 150.f, 100.f);
        _button.imageTextDistance = 10.f;
        _button.imageCornerRadius = 25.f;
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor orangeColor]];
        _button.layer.cornerRadius = 4.f;
        [_button addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (GXCustomButton *)button2 {
    if (!_button2) {
        _button2 = [[GXCustomButton alloc] initWithAlignmentType:ImageAlignmentTypeDown];
    }
    return _button2;
}

- (void)changeType:(UIButton *)sender {
    sender.tag = self.button.imageAlignmentType;
    switch (sender.tag) {
        case ImageAlignmentTypeLeft:
        {
            [self.button setTitle:@"下图上字" forState:UIControlStateNormal];
            [self.button setImageAlignmentType:ImageAlignmentTypeDown];
        }
            break;
        case ImageAlignmentTypeDown:
        {
            [self.button setTitle:@"右图左字" forState:UIControlStateNormal];
            [self.button setImageAlignmentType:ImageAlignmentTypeRight];
        }
            break;
        case ImageAlignmentTypeRight:
        {
            [self.button setTitle:@"上图下字" forState:UIControlStateNormal];
            [self.button setImageAlignmentType:ImageAlignmentTypeUp];
        }
            break;
        case ImageAlignmentTypeUp:
        {
            [self.button setTitle:@"左图右字" forState:UIControlStateNormal];
            [self.button setImageAlignmentType:ImageAlignmentTypeLeft];
        }
            break;
            
        default:
            break;
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
