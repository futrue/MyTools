//
//  CustomButton_test.m
//  MyTools
//
//  Created by SGX on 17/1/13.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CustomButton_test.h"
#import "GXCustomButton.h"
#import "MZShapedButton.h"

@interface CustomButton_test ()
@property (nonatomic, strong) GXCustomButton *button;
@property (nonatomic, strong) GXCustomButton *button2;

@end

@implementation CustomButton_test

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [self.view addSubview:self.button];
    
    self.button2.frame = CGRectMake(SCREEN_WIDTH - 110, SCREEN_HEIGHT - 110, 100, 100);
    self.button2.backgroundColor = [UIColor yellowColor];
    [self.button2 setTitle:@"测试一下" forState:UIControlStateNormal];
    [self.button2 setImage:[UIImage imageNamed:@"userLogo"] forState:UIControlStateNormal];
    [self.view addSubview:self.button2];
    [self.button2 addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    
    [self shapedBtn];
}

- (void)shapedBtn
{
    //标签1
    UILabel *labelNormal =
    [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 10, 20)];
    labelNormal.text = @"普通按钮点击边框外也响应事件，响应区域仍为矩形";
    labelNormal.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [self.view addSubview:labelNormal];
    
    //普通按钮
    UIButton *btnNromal = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNromal.frame = CGRectMake(50, 70, 100, 100);
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = [[self getPath:1] CGPath];
    btnNromal.layer.mask = shapLayer;
    [btnNromal setTitle:@"普通按钮" forState:UIControlStateNormal];
    [btnNromal addTarget:self
                  action:@selector(btnAction:)
        forControlEvents:UIControlEventTouchUpInside];
    btnNromal.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btnNromal];
    
    //标签2
    UILabel *labelShaped =
    [[UILabel alloc] initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH - 10, 20)];
    labelShaped.text = @"下面的按钮只在形状内响应，非矩形";
    labelShaped.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [self.view addSubview:labelShaped];
    
    //六边形
    MZShapedButton *btn1 = [MZShapedButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(50, 250, 100, 100);
    btn1.path = [self getPath:1];
    [btn1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn1];
    
    //五边形
    MZShapedButton *btn2 = [MZShapedButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(160, 250, 100, 90);
    btn2.path = [self getPath:2];
    [btn2 setTitle:@"按钮2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn2];
    
    //随意
    MZShapedButton *btn3 = [MZShapedButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(10, 370, 200, 100);
    btn3.path = [self getPath:3];
    [btn3 setTitle:@"按钮3" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn3];
}

- (GXCustomButton *)button {
    if (!_button) {
        _button = [[GXCustomButton alloc] initWithImageName:@"userLogo" title:@"点我试试" imageAlignmentType:ImageAlignmentTypeLeft];
        _button.frame = CGRectMake(10, SCREEN_HEIGHT - 110, 150.f, 100.f);
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









#pragma mark
#pragma mark Action
//变色响应
- (void)btnAction:(MZShapedButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 + 1) / 255.0
                                             green:(arc4random() % 255 + 1) / 255.0
                                              blue:(arc4random() % 255 + 1) / 255.0
                                             alpha:1.0];
}

#pragma mark
#pragma mark Method
//获取遮罩path
- (UIBezierPath *)getPath:(NSInteger)num
{
    switch (num)
    {
        case 1:
        {
            float viewWidth = 100;
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2), (viewWidth / 4))];
            [path addLineToPoint:CGPointMake((viewWidth / 2), 0)];
            [path addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)),
                                             (viewWidth / 4))];
            [path addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)),
                                             (viewWidth / 2) + (viewWidth / 4))];
            [path addLineToPoint:CGPointMake((viewWidth / 2), viewWidth)];
            [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2),
                                             (viewWidth / 2) + (viewWidth / 4))];
            [path closePath];
            return path;
        }
            break;
        case 2:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(50.0, 0.0)];
            [path addLineToPoint:CGPointMake(100.0, 35.0)];
            [path addLineToPoint:CGPointMake(80, 90)];
            [path addLineToPoint:CGPointMake(20.0, 90)];
            [path addLineToPoint:CGPointMake(0.0, 35.0)];
            [path closePath];
            return path;
        }
            break;
        case 3:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(0, 100)];
            [path addLineToPoint:CGPointMake(20, 0)];
            [path addLineToPoint:CGPointMake(45, 50)];
            [path addLineToPoint:CGPointMake(70, 0)];
            [path addLineToPoint:CGPointMake(150, 30)];
            [path addLineToPoint:CGPointMake(175, 0)];
            [path addLineToPoint:CGPointMake(200, 100)];
            [path closePath];
            return path;
        }
            break;
            
        default:
            return nil;
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
