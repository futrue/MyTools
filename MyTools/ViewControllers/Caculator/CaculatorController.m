//
//  CaculatorController.m
//  计算器-demo
//
//  Created by SGX on 16/5/9.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "CaculatorController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CaculatorController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *visiblelabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSMutableString *string;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) NSString *fuhaoString;
@property (nonatomic, strong) UIButton *button;

@end

@implementation CaculatorController
@synthesize topView,label,string,str1,button,fuhaoString;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
    
}

- (void)initView {
//    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.view.backgroundColor = [UIColor blackColor];
    CGFloat btnWidth = ( SCREEN_WIDTH - 5 ) / 4;
    CGFloat topViewHeight = SCREEN_HEIGHT -  5 *(btnWidth + 1) - 20;
    topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor blackColor];
    topView.frame = CGRectMake(0, 20, SCREEN_WIDTH, topViewHeight);
    [self.view addSubview:topView];
    
    self.visiblelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 40)];
    self.visiblelabel.textAlignment = NSTextAlignmentLeft;
//    self.visiblelabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.visiblelabel.textColor = [UIColor redColor];
    self.visiblelabel.font = [UIFont systemFontOfSize:15];
//    self.visiblelabel.adjustsFontSizeToFitWidth = YES;
    [topView addSubview:self.visiblelabel];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMidY(topView.bounds), SCREEN_WIDTH - 10, topViewHeight/2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"0";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:44];
    label.adjustsFontSizeToFitWidth = YES;
    [topView addSubview:label];
    
    string = [[NSMutableString alloc] init];
    
    NSArray *titleArr = [NSArray arrayWithObjects:
                         @"AC",@"+/-",@"%",@"÷",
                         @"7",@"8",@"9",@"×",
                         @"4",@"5",@"6",@"-",
                         @"1",@"2",@"3",@"+",
                         @"0",@"",@".",@"=",nil];
    
    NSArray *actionArr = [NSArray arrayWithObjects:
                          @"clear",@"negativeValue",@"percentSign",@"operator:",
                          @"num:",@"num:",@"num:",@"operator:",
                          @"num:",@"num:",@"num:",@"operator:",
                          @"num:",@"num:",@"num:",@"operator:",
                          @"zero",@"zero",@"point",@"equal",nil];// 若需要传参，则需要加：
    
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 4; j++) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor lightGrayColor];
            [button setTitle:titleArr[i*4+j] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:NSSelectorFromString(actionArr[ i*4 + j]) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(1+(btnWidth+1)*j, CGRectGetMaxY(topView.frame)+(1+btnWidth)*i, btnWidth, btnWidth);
            button.titleLabel.font = [UIFont systemFontOfSize:40];
            [self.view addSubview:button];
            
            if (i == 0) {
                button.backgroundColor = [UIColor grayColor];
            }
            if (j == 3) {
                button.backgroundColor = [UIColor orangeColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(btnWidth+1, SCREEN_HEIGHT-btnWidth-1, 1, btnWidth)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}

- (void)clear {
    label.text = @"0";
    [string deleteCharactersInRange:NSMakeRange(0, string.length)];
    self.visiblelabel.text = @"0";
    
}
- (void)negativeValue {
    float preciousNum = [string floatValue];
    if (preciousNum != 0) {
        preciousNum = -preciousNum;
    }
    [self deleteString];
    [self addnum:[NSString stringWithFormat:@"%g",preciousNum]];
}
- (void)percentSign {
    float preciousNum = [string floatValue];
    if (preciousNum != 0) {
        preciousNum = preciousNum/100;
    }
    [self deleteString];
    [self addnum:[NSString stringWithFormat:@"%g",preciousNum]];
}
- (void)num:(UIButton *)sender {
    if ([string isEqualToString:@"0"]) {
        [string deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    [self addnum:sender.titleLabel.text];

}
- (void)zero {
    if (![string hasPrefix:@"0"]) {
        [self addnum:@"0"];
    }
}
- (void)point {
    if (![string containsString:@"."]) {
        [self addnum:@"."];
    }
}
- (void)operator:(UIButton *)sender {
    str1 = label.text;
    [self deleteString];
    fuhaoString = sender.titleLabel.text;
    self.visiblelabel.text = [self.visiblelabel.text stringByAppendingString:fuhaoString];
}
- (void)equal {
    CGFloat results = 0;
    CGFloat m = [str1 floatValue];
    CGFloat n = [string floatValue];
    if ([fuhaoString isEqualToString:@"+"]) {
        results = m + n;
    } else if ([fuhaoString isEqualToString:@"-"]) {
        results = m - n;
    } else if ([fuhaoString isEqualToString:@"×"]) {
        results = m * n;
    } else if ([fuhaoString isEqualToString:@"÷"]){
        results = m / n;
    }
    label.text = [NSString stringWithFormat:@"%g",results];
}


- (void)addnum:(NSString *)sender {
    [string appendString:sender];
    label.text = string;
    self.visiblelabel.text  = string;
}
- (void)deleteString {
    [string deleteCharactersInRange:NSMakeRange(0, string.length)];
}
@end
