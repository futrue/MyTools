//
//  UIView_Convert.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "UIView_Convert.h"

@interface UIView_Convert ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *orangeView;
@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *greenView;

@end

@implementation UIView_Convert

/*
 // 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
 - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
 
 // 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
 - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
 
 // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
 - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
 
 // 将rect从view中转换到当前视图中，返回在当前视图中的rect
 // 例如把UITableViewCell中的subview(btn)的frame转换到VC中
 - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
 
 原文链接：http://www.jianshu.com/p/76dcaa37a2c4
 例如：controllerA中有一个UITableView，UITableView里有多行UITableVieCell，cell上放有一个button
 // 在controllerA中实现:
 CGRect rc = [cell convertRect:cell.btn.frame toView:self.view];
 或者
 CGRect rc = [self.view convertRect:cell.btn.frame fromView:cell];
 */



- (void)viewDidLoad {
    [super viewDidLoad];
    // 坐标转换比较详细的讲解 http://www.jianshu.com/p/92e2d0200eb4
    
    // 关于UIView的很多方法讲解 http://www.cnblogs.com/pengyingh/articles/2379476.html
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.orangeView];
    
    [self.redView addSubview:self.yellowView];
    [self.yellowView addSubview:self.greenView];
    
    
    // 黄色view里的绿色view在self.view的位置（记住： 黄色view和绿色view需是父子view关系）
    // 从中间往两边读：把黄色view中绿色view转化为在self.view中的位置  或者 把绿色view从黄色view中的位置转为在self.view中的位置
    
    // 在viewDidLoad里，self.view还没有加载在window上，得传self.view，不能传nil；   若是传nil，需要在viewDidAppear里做操作；（viewWillAppear都不行）
    CGRect rect1 = [self.yellowView convertRect:self.greenView.frame toView:self.view];
    //         rect1 = [self.view convertRect:self.greenView.frame fromView:self.yellowView];
    NSLog(@"--黄色控件里的绿色view在self.view的位置%@",NSStringFromCGRect(rect1));//{{160, 160}, {70, 70}}
    
    // 要计算出某个view相对于self.view的位置，得传view.bounds,不能用frame,即rect3
    CGRect rect2 = [self.greenView convertRect:self.greenView.frame toView:self.view];
    rect2 = [self.view convertRect:self.greenView.frame fromView:self.greenView];//❌
    NSLog(@"-greenView-frame--%@",NSStringFromCGRect(rect2));//{{210, 210}, {70, 70}} ❌
    
    CGRect rect3 = [self.greenView convertRect:self.greenView.bounds toView:self.view];
    //         rect3 = [self.view convertRect:self.greenView.bounds fromView:self.greenView];//✔️
    NSLog(@"-greenView-bounds--%@",NSStringFromCGRect(rect3));//{{160, 160}, {70, 70}} ✔️
    
    CGPoint originInSuperview = [self.redView convertPoint:CGPointZero fromView:self.yellowView];// {100, 100}
    originInSuperview = [self.view convertPoint:self.yellowView.frame.origin fromView:self.redView]; //{110, 110}
    NSLog(@"originInSuperview: %@", NSStringFromCGPoint(originInSuperview));
    
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect rect1 = [self.yellowView convertRect:self.greenView.frame toView:nil];
    //         rect1 = [self.view convertRect:self.greenView.frame fromView:nil];
    rect1 = [[UIApplication sharedApplication].keyWindow convertRect:self.greenView.bounds fromView:self.greenView];//✔️
    
    NSLog(@"-viewDidAppear-黄色控件里的绿色view在self.view的位置%@",NSStringFromCGRect(rect1));//{{160, 160}, {70, 70}}
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 350, 500)];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIView *)orangeView {
    if (!_orangeView) {
        _orangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _orangeView.backgroundColor = [UIColor orangeColor];
    }
    return _orangeView;
}
- (UIView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}
- (UIView *)greenView {
    if (!_greenView) {
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 70, 70)];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

@end
