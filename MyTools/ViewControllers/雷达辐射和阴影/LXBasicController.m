
//
//  LXBasicController.m
//  LXViewShadowPath
//
//  Created by chenergou on 2017/11/23.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXBasicController.h"
#import "animation.h"
#import "RadarView.h"
//iphone X 尺寸
#define ZHheight ([[UIApplication sharedApplication] statusBarFrame].size.height >20? 86:64)  //导航栏高度
#define IphoneXHeight ([[UIApplication sharedApplication] statusBarFrame].size.height >20? 22:0)  //导航栏增加高度
#define IphoneXTabbarH ([[UIApplication sharedApplication] statusBarFrame].size.height >20? 83:49)  //tabbar高度

@interface LXBasicController ()
{
    UIButton * _RegisterBtn;
    NSTimer *_timer;
}

@property (nonatomic, strong) RadarView *scanRadarView;
@property (nonatomic, strong) RadarView *diffuseRadarView;

@end

@implementation LXBasicController
-(void)setShadowPathSide:(LXShadowPathSide)shadowPathSide{
    _shadowPathSide = shadowPathSide;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 扫描 类型 RadarView */
    _scanRadarView = [RadarView scanRadarViewWithRadius:self.view.bounds.size.width*0.5 angle:400 radarLineNum:5 hollowRadius:0];
    
    /** 扩散 类型 RadarView */
    _diffuseRadarView = [RadarView diffuseRadarViewWithStartRadius:7 endRadius:self.view.bounds.size.width*0.5 circleColor:[UIColor orangeColor]];
    
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    if (self.radarType) {
        switch (self.radarType) {
            case 1:
                [self radio];
                break;
            case 2:
                [_diffuseRadarView showTargetView:self.view];
                [_diffuseRadarView startAnimatian];
                break;
            case 3:
                [_scanRadarView showTargetView:self.view];
                [_scanRadarView startAnimatian];
                break;
                
            default:
                break;
        }
    } else {
        [self shadow];
    }
    
}

- (void)shadow {
    self.shaowView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.shaowView.center = self.view.center;
    
    self.shaowView.image =[UIImage imageNamed:@"gougou"];
    [self.view addSubview:self.shaowView];
    
    switch (self.shadowPathSide) {
        case LXShadowPathTop:
            
            [self.shaowView LX_SetShadowPathWith:[UIColor magentaColor] shadowOpacity:1 shadowRadius:5 shadowSide:LXShadowPathTop shadowPathWidth:10];
            break;
        case LXShadowPathBottom:
            [self.shaowView LX_SetShadowPathWith:[UIColor blackColor] shadowOpacity:0.5 shadowRadius:1 shadowSide:LXShadowPathBottom shadowPathWidth:2];
            break;
        case LXShadowPathLeft:
            [self.shaowView LX_SetShadowPathWith:[UIColor greenColor] shadowOpacity:0.3 shadowRadius:5 shadowSide:LXShadowPathLeft shadowPathWidth:2];
            break;
        case LXShadowPathRight:
            [self.shaowView LX_SetShadowPathWith:[UIColor purpleColor] shadowOpacity:0.5 shadowRadius:5 shadowSide:LXShadowPathRight shadowPathWidth:2];
            break;
        case LXShadowPathNoTop:
            [self.shaowView LX_SetShadowPathWith:[UIColor greenColor] shadowOpacity:0.3 shadowRadius:2 shadowSide:LXShadowPathNoTop shadowPathWidth:10];
            break;
        case LXShadowPathAllSide:
            [self.shaowView LX_SetShadowPathWith:[UIColor blueColor] shadowOpacity:0.3 shadowRadius:5 shadowSide:LXShadowPathAllSide shadowPathWidth:20];
            break;
            
    }
}

- (void)radio {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(clickAnimation) userInfo:nil repeats:YES];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    CGFloat shipeiWidth = SCREEN_WIDTH / 375.f;
    _RegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*.5 - 50*shipeiWidth,ZHheight + 60 +200 + 30 , 100*shipeiWidth, 100*shipeiWidth)];
    [self.view addSubview:_RegisterBtn];
    
    _RegisterBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    _RegisterBtn.titleLabel.numberOfLines = 0;
    [_RegisterBtn setTitleColor:[UIColor redColor] forState:0];
    [_RegisterBtn setTitle:@"长按录音" forState:0];
    _RegisterBtn.backgroundColor = [UIColor greenColor];
    
    _RegisterBtn.layer.masksToBounds = NO;
    _RegisterBtn.layer.cornerRadius = 50*shipeiWidth;
    _RegisterBtn.layer.borderWidth = 5*shipeiWidth;
    _RegisterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _RegisterBtn.layer.shadowOffset =  CGSizeMake(0, 0);
    _RegisterBtn.layer.shadowOpacity = 0.6;
    _RegisterBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
    
    [_RegisterBtn addTarget:self action:@selector(clickAnimation1) forControlEvents:UIControlEventTouchDown];// 按下去
    [_RegisterBtn addTarget:self action:@selector(clickAnimation2) forControlEvents:UIControlEventTouchUpInside];// 抬起来
    
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(100, 100, 40, 40);
    view.backgroundColor = [UIColor orangeColor];
    
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 5;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    
    view.layer.shadowOffset =  CGSizeMake(0, 1);
    view.layer.shadowOpacity = 0.6;
    view.layer.shadowRadius = 4;
    view.layer.shadowColor =  [UIColor redColor].CGColor;
    [self.view addSubview:view];

}

-(void)clickAnimation1{
    //开启定时器
    NSLog(@"UIControlEventTouchDown");
    [_timer setFireDate:[NSDate distantPast]];
}
-(void)clickAnimation{
    NSLog(@"time");

    __block animation *andome = [[animation alloc] initWithFrame:_RegisterBtn.frame];
    andome.CGfrom_x = _RegisterBtn.bounds.size.width;
    andome.backgroundColor = [UIColor clearColor];
    andome.tag = 10001;
    [self.view addSubview:andome];
    [self.view sendSubviewToBack:andome];
    [UIView animateWithDuration:1 animations:^{
        andome.transform = CGAffineTransformScale(andome.transform, 1.5, 1.5);
        andome.alpha = 0;
    } completion:^(BOOL finished) {
        [andome removeFromSuperview];
        NSLog(@"结束动画");
    }];
}
-(void)clickAnimation2{
    NSLog(@"UIControlEventTouchUpInside");
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    //for循环查找:
    for (UIView *findLabel in self.view.subviews) {
        if (findLabel.tag == 10001)
        {
            [findLabel removeFromSuperview ];
        }
    }
}
- (void)dealloc {
    //取消定时器
    [_timer invalidate];
    _timer = nil;
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
