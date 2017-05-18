//
//  RatingVC.m
//  MyTools
//
//  Created by SGX on 17/2/8.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "RatingVC.h"
#import "LHRatingView.h"

@interface RatingVC ()<ratingViewDelegate>

@end

@implementation RatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(20, 100, 280, 60)];
    rView.center = self.view.center;
    rView.backgroundColor = [UIColor grayColor];
    //    rView.ratingType = INTEGER_TYPE;//整颗星
    rView.delegate = self;
    
    rView.score = 3.5;
    [self.view addSubview:rView];
}

#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    NSLog(@"分数  %.2f",score);
    
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
