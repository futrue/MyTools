//
//  Quantz2D_VC.m
//  Skill_test
//
//  Created by SGX on 17/1/4.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Quantz2D_VC.h"
#import "QuartzView.h"
#import "CoreImageVC.h"

@interface Quantz2D_VC ()
@property (nonatomic, strong) QuartzView *view1;

@end

@implementation Quantz2D_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.view1];
    
    UIImage *img1 = [UIView imageWithRoundedCornersSize:20 usingImage:TEST_IMG];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img1];
    CGFloat max = MIN(TEST_IMG.size.height, TEST_IMG.size.width);
    imageView.size = CGSizeMake(max, max);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [imageView addRoundedCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadius:10];
    [self.view addSubview:imageView];

    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images"]];
    imageView2.size = CGSizeMake(100, 100);
    imageView2.contentMode = UIViewContentModeScaleToFill;
    imageView2.clipsToBounds = YES;
    imageView2.center = CGPointMake(50, self.view.center.y + 150);

    imageView2.layer.borderWidth = 5;
    imageView2.layer.borderColor = COLOR_PRIMARY.CGColor;
    imageView2.layer.cornerRadius = 50;

//    [imageView2 setCornerRadius:50];
//    [imageView2 clipsToRound];
    [self.view addSubview:imageView2];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"coreImage" style:UIBarButtonItemStyleDone target:self action:@selector(coreImage:)];

}


-(void)coreImage:(UIBarButtonItem *)btn{
    [self.navigationController pushViewController:[[CoreImageVC alloc] init] animated:YES];
}

- (QuartzView *)view1 {
    if(!_view1) {
        _view1 = [[QuartzView alloc] initWithFrame:CGRectMake(10, 64, self.view.bounds.size.width - 20, 40)];
        _view1.backgroundColor = [UIColor whiteColor];
    }
    return _view1;
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
