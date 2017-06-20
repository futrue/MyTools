
//
//  Layoutsubviews_test.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/12.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Layoutsubviews_test.h"
#import "TestView.h"

@interface Layoutsubviews_test ()
@property (nonatomic, strong) NSTimer   *timer;
@property (nonatomic, strong) TestView  *largeView;
@property (nonatomic, strong) TestView  *smallView;

@end
// 结论
/** 
 1. 一个view是不能够自己调用layoutSubviews,如果要调用,需要调用setNeedsLayout或者layoutIfNeeded
 2. 如果view的frame值为0,即使被添加了耶不会调用layoutSubviews
 3. 如果一个view的frame值改变了,那么它的父类的layoutSubviews也会被执行
 */

/** 
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */

@implementation Layoutsubviews_test

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、init初始化不会触发layoutSubviews [正确的]
    // 2、addSubview会触发layoutSubviews [不完全正确,当frame为0时是不会触发的]
    // 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化 [正确]
    
//        [self test_1];
//        [self test_2];
//        [self test_3];
    
    // 4、滚动一个UIScrollView会触发layoutSubviews[错误,不用滚动就会触发]
//        [self test_4];
    
    // 5、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
    [self test_5];
}
- (void)test_1
{
    /*
     解释:
     
     走了initWithFrame:方法,但是又有frame值为{{0, 0}, {0, 0}},并不需要绘制任何的东西,
     所以即使添加了test,也没必要绘制它,同时也验证了addSubview会触发layoutSubviews是错
     误的,只有当被添加的view有着尺寸的时候才会触发layoutSubviews
     */
    
    TestView *test = [TestView new];
    [self.view addSubview:test];
}

- (void)test_2
{
    TestView *test = [TestView new];
    test.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:test];
}

- (void)test_3
{
    /*
     解释:
     
     layoutSubviews这个方法自身无法调用,是被父类添加的时候才执行的方法
     */
    
    TestView *test = [TestView new];
    test.frame = CGRectMake(0, 0, 50, 50);
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [test addSubview:showView];
}

- (void)test_4
{
    CGRect rect    = self.view.bounds;
    CGFloat height = rect.size.height;
    CGFloat width  = rect.size.width;
    
    UIScrollView *rootScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    NSArray *data            = @[@"", @"", @"", @""];
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TestView *tmp        = [[TestView alloc] initWithFrame:CGRectMake(width*idx, 0,
                                                                          width, height)];
        [rootScroll addSubview:tmp];
    }];
    rootScroll.contentSize   = CGSizeMake(width * data.count, height);
    [self.view addSubview:rootScroll];
}

- (void)test_5
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                              target:self
                                            selector:@selector(timerEvent:)
                                            userInfo:nil
                                             repeats:YES];
    _largeView = [[TestView alloc] initWithFrame:self.view.bounds];
    _largeView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_largeView];
    
    _smallView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _smallView.backgroundColor = [UIColor blueColor];
    [_largeView addSubview:_smallView];
}

- (void)timerEvent:(id)sender
{
    _smallView.frame = CGRectMake(arc4random()%100 + 20,
                                  arc4random()%100 + 20,
                                  arc4random()%100 + 20,
                                  arc4random()%100 + 20);
    NSLog(@"_smallView %@", _smallView);
    NSLog(@"_smallView %@", _largeView);
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
