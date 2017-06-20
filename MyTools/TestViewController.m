//
//  TestViewController.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/16.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"

@interface TestViewController ()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *endButton;
@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startButton];
    [self endButton];
    [self testView];

}

- (void)didRuninCurrModel:(id)sender {
    NSLog(@"running---with object-----");
}

- (void)didRuninCurrModelNoArgument {
    NSLog(@"running---without object-----");
}

- (void)changeColor {
    [self.testView changeRandomColor];
}

- (void)startAction {
//    [self performSelector:@selector(didRuninCurrModel:) withObject:[NSNumber numberWithBool:YES] afterDelay:3.0f];
//    [self performSelector:@selector(didRuninCurrModelNoArgument) withObject:nil afterDelay:3.0f];
    
//    [self performSelector:@selector(changeColor) withObject:nil afterDelay:2.0f];
    [self.testView performSelector:@selector(changeRandomColor) withObject:nil afterDelay:2.0f];
}

- (void)endAction {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:[NSNumber numberWithBool:YES]];//可以取消成功。
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:[NSNumber numberWithBool:NO]];//不能取消成功。参数不匹配
//
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:nil];//不能取消成功。参数不匹配
//    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModelNoArgument) object:nil];//可以成功取消
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
//    [[self class] cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];//可以取消成功。
    [NSObject cancelPreviousPerformRequestsWithTarget:self.testView selector:@selector(changeRandomColor) object:nil];//不能取消成功。参数不匹配

}


- (UIButton *)startButton {
    if (!_startButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.layer.cornerRadius = 4.f;
        [btn setTitle:@"Start" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
        _startButton = btn;
        btn.frame = CGRectMake(20, 100, 60, 35);
        [self.view addSubview:btn];
    }
    return _startButton;
}

- (UIButton *)endButton {
    if (!_endButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 4.f;
        [btn setTitle:@"End" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(endAction) forControlEvents:UIControlEventTouchUpInside];
        _endButton = btn;
        btn.frame = CGRectMake(100, 100, 60, 35);
        [self.view addSubview:btn];

    }
    return _endButton;
}

- (TestView *)testView {
    if (!_testView) {
        _testView = [[TestView alloc] initWithFrame:CGRectMake(20, 300, 200, 80)];
        _testView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_testView];
    }
    return _testView;
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
