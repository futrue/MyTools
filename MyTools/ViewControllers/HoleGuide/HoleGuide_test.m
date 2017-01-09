//
//  HoleGuide_test.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "HoleGuide_test.h"
#import "HoleGuideView.h"

@interface HoleGuide_test ()
@property (nonatomic, strong) HoleGuideView *holeView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *dismissBtn;

@end

@implementation HoleGuide_test

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    UIImage *image = [UIImage imageNamed:@"guide_hand"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, image.size.width , image.size.height)];
    imgView.image = image;
    imgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imgView];
    //添加按钮
    self.dismissBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dismissBtn.frame = CGRectMake(120, 400, 80, 40);
    [self.dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.dismissBtn.layer.borderWidth = 1;
    self.dismissBtn.layer.cornerRadius = 4.0;
    self.dismissBtn.layer.masksToBounds = YES;
    [self.dismissBtn setAdjustsImageWhenHighlighted:NO];
    self.dismissBtn.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.dismissBtn.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    self.dismissBtn.layer.cornerRadius = 4.0;
    [self.dismissBtn setTitle:@"点我!" forState:UIControlStateNormal];
    [self.dismissBtn addTarget:self
                        action:@selector(dismissBtn:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.dismissBtn];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.addBtn.frame = CGRectMake(20, 400, 80, 40);
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.layer.masksToBounds = YES;
    [self.addBtn setAdjustsImageWhenHighlighted:NO];
    self.addBtn.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.addBtn.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    self.addBtn.layer.cornerRadius = 20.0;
    [self.addBtn setTitle:@"++!" forState:UIControlStateNormal];
    [self.addBtn addTarget:self
                    action:@selector(addBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addBtn];

}

- (void)addBtn:(UIButton *)sender {
    [self addHoleView];
}

- (void)dismissBtn:(UIButton *)sender {
    [self.holeView removeHoles];
    [self.holeView removeFromSuperview];
}

- (void)addHoleView {
    self.holeView = [[HoleGuideView alloc] initWithFrame:self.view.frame];
    [self.holeView addFocusViews:_dismissBtn];// 带事件穿透
    [self.holeView addRoundRectHole:_dismissBtn.frame withCornerRadius:20];
    [self.holeView addCircleHoleOnCenterPoint:CGPointMake(200, 100) andDiameter:100];
    [self.holeView addRectHoleOnRect:CGRectMake(10, 20, 100, 60)];
    
    [self.view addSubview:_holeView];
    //    self.holeView.isDarkFocusView = YES;
    [self.holeView addCustomView:[self customView] onRect:CGRectMake(10, 200, 300, 100)];
    
    self.holeView.TapHoleViewBlock = ^{
        NSLog(@"dgfdsf");
    };
    
    __weak __typeof(self)weakSelf = self;
    self.holeView.SwipHoleViewBlock = ^{
        [weakSelf performSelector:@selector(dismissBtn:) withObject:nil];
    };
}

- (UIView *)customView {
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor clearColor]];
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.borderWidth = 1.0f;
    label.layer.cornerRadius = 10.0f;
    [label setTextColor:[UIColor whiteColor]];
    [label sizeToFit];
    label.text = @"点击按钮, 退出遮罩层.";
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
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
