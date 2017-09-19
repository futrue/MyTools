//
//  BezierPath_Test.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/3.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "BezierPath_Test.h"
#import "PathView.h"
#import "CustomView.h"

@interface BezierPath_Test ()
//、、ftp://e:e@dx.dl1234.com.5599/
//http://ddyyzx.com/zx/
@end

@implementation BezierPath_Test

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    PathView *view1 = [[PathView alloc] initWithFrame:CGRectMake(20, 100, self.view.width - 40, self.view.height - 120)];
    view1.backgroundColor = [UIColor whiteColor];

//    [self.view addSubview:view1];
    
    
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [self.view addSubview:customView];
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
