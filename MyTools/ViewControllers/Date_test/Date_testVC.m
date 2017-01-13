//
//  Date_testVC.m
//  MyTools
//
//  Created by SGX on 17/1/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Date_testVC.h"
#import "NSDate+Utilities.h"
#import "OrderListAdManager.h"

@interface Date_testVC ()<DDOrderListAdViewDelegate>

@property (nonatomic, strong) CADisplayLink *weekTimer;
@property (nonatomic, assign) NSTimeInterval aWeek;

@property (nonatomic, strong) DDOrderListAdView *adView;

@end

@implementation Date_testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"开始倒计时" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor blueColor]];
    addBtn.frame = CGRectMake(30, 100, 100, 30);
    [addBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *addBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn1 setTitle:@"重新倒计时" forState:UIControlStateNormal];
    [addBtn1 setBackgroundColor:[UIColor greenColor]];
    addBtn1.frame = CGRectMake(150, 100, 100, 30);
    [addBtn1 addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn1];
    
    UIButton *addBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn2 setTitle:@"停止倒计时" forState:UIControlStateNormal];
    [addBtn2 setBackgroundColor:[UIColor greenColor]];
    addBtn2.frame = CGRectMake(270, 100, 100, 30);
    [addBtn2 addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn2];

    
    self.adView = [[OrderListAdManager defaultManager] adView];
    self.adView.delegate = self;
    [self.view addSubview:self.adView];
    self.adView.center = self.view.center;
    [self  showAD];
    
}


- (void)showAD {
    [[OrderListAdManager defaultManager] setAdUrl:@"http://192.168.1.192/pics//g/20161229164026463_0.jpg"];
//    [self.adView setAdURLString:@"http://192.168.1.192/pics//g/20161229164026463_0.jpg"];
}


- (void)orderListAdViewCloseBtnDidClicked:(DDOrderListAdView *)view {
    //UI
    [[OrderListAdManager defaultManager] closeAD];// logic
}

- (void)ignoreAd {
    NSDate *startDate = [NSDate date];
    NSDate *aWeekDate = [NSDate dateWithTimeIntervalSinceNow:7*24*3600];
    
    NSTimeInterval timeInterval =[aWeekDate timeIntervalSinceDate:startDate];
    NSLog(@"timeInterval = %f",timeInterval);
    
    
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",currentDate,year,month,day);
    
}

- (void)week {
    NSDate *now = [NSDate date];
    NSDate *now1 = [NSDate dateWithTimeIntervalSinceNow:10];
    
    NSDate *week = [NSDate dateWithDaysFromNow:7];
    NSTimeInterval timeInterval =[week timeIntervalSinceDate:now];
    NSTimeInterval timeInterval1 =[now1 timeIntervalSinceDate:now];
    
    NSLog(@"timeInterval 2 = %f  ====%f",timeInterval,timeInterval1);
    
}





- (void)countdown {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (self.aWeek > now) {
        NSLog(@"倒计时中...");
        [self start];
    } else {
        NSLog(@"倒计时完毕。");
        [self end];
    }
}
- (NSTimeInterval)aWeek {
    if (!_aWeek) {
        _aWeek = [[NSDate date] timeIntervalSince1970] + 10;
    }
    return _aWeek;
}

-(void)start {
    if (!_weekTimer) {
        _weekTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(countdown)];
        _weekTimer.preferredFramesPerSecond = 1;
        [_weekTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)restart {
    self.aWeek = [[NSDate date] timeIntervalSince1970] + 10;
    [self countdown];
}

-(void)end {
    NSLog(@"停止时完毕。");
    if (_weekTimer) {
        [_weekTimer invalidate];
        _weekTimer = nil;
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
