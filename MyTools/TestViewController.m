//
//  TestViewController.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/16.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TestViewController.h"
#import <objc/runtime.h>

#define RADIANS(degrees) (((degrees) * M_PI) / 180.0)

#define kMaxLength 11
@interface TestViewController ()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *endButton;
@property (nonatomic, strong) UIButton *commitButton;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 64 = 0 http://www.jianshu.com/p/c0b8c5f131a0
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self startButton];
    [self endButton];
    [self commitButton];
    [self forTest];
}

- (void)forTest {
    for (int i = 0; i < 10; i++) {
        if (i == 5) {
            continue;// 结束本次循环，不会打印 5
        }
        if (i == 8) {
            break;// 跳出循环，不会走 9 ，10
        }
        printf("num == %d",i);
    }
}
- (void)createClass {
    // 创建一个名为 TangQiaoCustomView 的类，它是UIView的子类
    Class newClass = objc_allocateClassPair([UIView class], "TangQiaoCustomView", 0);
    // 为该类增加一个名为 report 的方法
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    // 注册该类
    objc_registerClassPair(newClass);
    
    // 创建一个 TangQiaoCustomView类的实例
    id instanceOfNewClass = [[newClass alloc] init];
    // 调用 report 方法
    [instanceOfNewClass performSelector:@selector(report)];

}

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++)
    {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}

- (void)report {
    NSLog(@"report");
}



- (void)didRuninCurrModel:(id)sender {
    NSLog(@"running---with object-----");
}

- (void)didRuninCurrModelNoArgument {
    NSLog(@"running---without object-----");
}

- (void)startAction {
    [self startAnimate];
//    [self performSelector:@selector(didRuninCurrModel:) withObject:[NSNumber numberWithBool:YES] afterDelay:3.0f];
//    [self performSelector:@selector(didRuninCurrModelNoArgument) withObject:nil afterDelay:3.0f];
    
//    [self performSelector:@selector(changeColor) withObject:nil afterDelay:2.0f];
//    [self.testView performSelector:@selector(changeRandomColor) withObject:nil afterDelay:2.0f];
    
}

- (void)endAction {
    [self stopAnimate];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:[NSNumber numberWithBool:YES]];//可以取消成功。
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:[NSNumber numberWithBool:NO]];//不能取消成功。参数不匹配
//
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:nil];//不能取消成功。参数不匹配
//    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModelNoArgument) object:nil];//可以成功取消
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
//    [[self class] cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];//可以取消成功。
//    [NSObject cancelPreviousPerformRequestsWithTarget:self.testView selector:@selector(changeRandomColor) object:nil];//不能取消成功。参数不匹配

}

- (void)startAnimate {
    UIView *view = self.startButton;
    view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5));
    
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^ {
        view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5));
    } completion:nil];
}

- (void)stopAnimate {
    UIView *view = self.startButton;
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear) animations:^ {
        view.transform = CGAffineTransformIdentity;
    } completion:nil];
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

- (UIButton *)commitButton {
    if (!_commitButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 4.f;
        [btn setTitle:@"commit" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        _commitButton = btn;
        btn.frame = CGRectMake(180, 100, 66, 35);
        [self.view addSubview:btn];
        
    }
    return _commitButton;
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
