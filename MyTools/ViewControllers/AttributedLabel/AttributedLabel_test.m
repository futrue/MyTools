//
//  AttributedLabel_test.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/1.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "AttributedLabel_test.h"
#import "XPQLabel.h"

#define OriginColor RGB(0, 122.4, 255)//(0, 0.48, 1)
@interface AttributedLabel_test ()

@property (nonatomic, strong) UISegmentedControl *horiSeg;
@property (nonatomic, strong) UISegmentedControl *vetiSeg;
@property (nonatomic, strong) UISegmentedControl *pathSeg;
@property (nonatomic, strong) UISegmentedControl *animateSeg;
@property (nonatomic, strong) UISegmentedControl *rotationSeg;

@property (nonatomic, strong) UILabel *horiLabel;
@property (nonatomic, strong) UILabel *vetiLabel;
@property (nonatomic, strong) UILabel *pathLabel;
@property (nonatomic, strong) UILabel *animateLabel;

@property (nonatomic, strong) UIButton *enter1Btn;
@property (nonatomic, strong) UIButton *enter2Btn;
@property (nonatomic, strong) UIButton *exit1Btn;
@property (nonatomic, strong) UIButton *exit2Btn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) BOOL animation;
@property (nonatomic, assign) BOOL rotate;

@property (nonatomic, strong) XPQLabel *stringLabel;
@property (nonatomic, strong) XPQLabel *attributedLabel;

@end

@implementation AttributedLabel_test

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"很厉害的label";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self setupUI];
}

- (void)setupUI {
    [self addViews];
    [self layoutViews];
}

- (void)addViews {
    [self.view addSubview:self.contentView];
    
    [self.contentView addSubview:self.horiSeg];
    [self.contentView addSubview:self.vetiSeg];
    [self.contentView addSubview:self.pathSeg];
    [self.contentView addSubview:self.animateSeg];
    [self.contentView addSubview:self.rotationSeg];

    [self.contentView addSubview:self.horiLabel];
    [self.contentView addSubview:self.vetiLabel];
    [self.contentView addSubview:self.pathLabel];
    [self.contentView addSubview:self.animateLabel];
    
    [self.contentView addSubview:self.enter1Btn];
    [self.contentView addSubview:self.enter2Btn];
    [self.contentView addSubview:self.exit1Btn];
    [self.contentView addSubview:self.exit2Btn];
    
    [self.view addSubview:self.stringLabel];
    [self.view addSubview:self.attributedLabel];
}

- (void)layoutViews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(10.f);
        make.trailing.offset(-10.f);
        make.bottom.offset(-10.f);
//        make.height.offset(300.f);
    }];
    
    [self.horiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(0.f);
        make.centerY.equalTo(self.horiSeg);
    }];

    [self.vetiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(0.f);
        make.centerY.equalTo(self.vetiSeg);
    }];

    [self.horiSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.vetiSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horiSeg.mas_bottom).offset(10);
        make.leading.equalTo(self.horiSeg);
        make.size.equalTo(self.vetiSeg);
    }];

    [self.pathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.vetiSeg.mas_bottom).offset(10);
    }];

    [self.pathSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pathLabel.mas_bottom).offset(10);
        make.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(35);
    }];
    
    [self.animateSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pathSeg.mas_bottom).offset(10);
        make.leading.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    
    [self.rotationSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pathSeg.mas_bottom).offset(10);
        make.leading.equalTo(self.animateSeg.mas_trailing).offset(15.f);
        make.trailing.equalTo(self.contentView);
        
        make.height.equalTo(self.animateSeg);
    }];
    
    [self.animateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.rotationSeg.mas_bottom).offset(10);
    }];

    [self.enter1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_centerX).offset(-20);
        make.top.equalTo(self.animateLabel.mas_bottom).offset(10);
    }];

    [self.enter2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.enter1Btn);
        make.top.equalTo(self.enter1Btn.mas_bottom).offset(10);
    }];
    
    [self.exit1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_centerX).offset(20);
        make.top.equalTo(self.enter1Btn);
    }];
    
    [self.exit2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.exit1Btn);
        make.top.equalTo(self.enter2Btn);
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];

    //
    [self.stringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(10);
        make.trailing.offset(-10);
        make.top.offset(10);
        make.height.offset(100);
    }];
    [self.attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(_stringLabel);
        make.trailing.offset(-10);
        make.top.equalTo(_stringLabel.mas_bottom).offset(10);
    }];
}

#pragma mark - Actions
- (void)horiSegChanged:(UISegmentedControl *)seg {
    NSLog(@"水平排版");
    BOOL animation = self.animation;
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.stringLabel setTextHorizontalAlignment:XPQLabelHorizontalAlignmentLeft animation:animation];
            [self.attributedLabel setTextHorizontalAlignment:XPQLabelHorizontalAlignmentLeft animation:animation];
            break;
        case 1:
            [self.stringLabel setTextHorizontalAlignment:XPQLabelHorizontalAlignmentCenter animation:animation];
            [self.attributedLabel setTextHorizontalAlignment:XPQLabelHorizontalAlignmentCenter animation:animation];
            break;
        case 2:
            [self.stringLabel setTextHorizontalAlignment:XPQLabelHorizontalAlignmentRight animation:animation];
            [self.attributedLabel setTextHorizontalAlignment:XPQLabelHorizontalAlignmentRight animation:animation];
            break;

        default:
            break;
    }

}
- (void)vetiSegChanged:(UISegmentedControl *)seg {
    NSLog(@"垂直排版");
    BOOL animation = self.animation;
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.stringLabel setTextVerticalAlignment:XPQLabelVerticalAlignmentUp animation:animation];
            [self.attributedLabel setTextVerticalAlignment:XPQLabelVerticalAlignmentUp animation:animation];
            break;
        case 1:
            [self.stringLabel setTextVerticalAlignment:XPQLabelVerticalAlignmentCenter animation:animation];
            [self.attributedLabel setTextVerticalAlignment:XPQLabelVerticalAlignmentCenter animation:animation];
            break;
        case 2:
            [self.stringLabel setTextVerticalAlignment:XPQLabelVerticalAlignmentDown animation:animation];
            [self.attributedLabel setTextVerticalAlignment:XPQLabelVerticalAlignmentDown animation:animation];
            break;
            
        default:
            break;
    }
}
- (void)pathSegChanged:(UISegmentedControl *)seg {
    NSLog(@"路径排版");
    BOOL animation = self.animation;
    BOOL rotate = self.rotate;
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.stringLabel setPath:nil rotate:rotate animation:animation];
            [self.attributedLabel setPath:nil rotate:rotate animation:animation];
            break;
        case 1:
        {
            XPQLabelPath *path = [XPQLabelPath pathForBeginPoint:CGPointMake(10.0, 10.0)];
            [path addLineToPoint:CGPointMake(250, 50)];
            
            XPQLabelPath *path1 = [XPQLabelPath pathForBeginPoint:CGPointMake(10.0, 15.0)];
            [path1 addLineToPoint:CGPointMake(240, 10)];

            [self.stringLabel setPath:path rotate:rotate animation:animation];
            [self.attributedLabel setPath:path1 rotate:rotate animation:animation];
            
        }
            break;
        case 2: {
            XPQLabelPath *path = [XPQLabelPath pathForBeginPoint:CGPointMake(20.0, 70.0)];
            [path addArcWithCentrePoint:CGPointMake(90.0, 70.0) angle:-M_PI];

            [self.stringLabel setPath:path rotate:rotate animation:animation];
            [self.attributedLabel setPath:path rotate:rotate animation:animation];
        }
            break;
        case 3: {
            XPQLabelPath *path = [XPQLabelPath pathForBeginPoint:CGPointMake(20.0, 60.0)];
            [path addCurveToPoint:CGPointMake(300.0, 60.0) anchorPoint:CGPointMake(100.0, 0.0)];
            
            [self.stringLabel setPath:path rotate:rotate animation:animation];
            [self.attributedLabel setPath:path rotate:rotate animation:animation];
        }
            break;
        default:
            break;
    }


}
- (void)animateSegChanged:(UISegmentedControl *)seg {
    NSLog(@"是否有动画");
    self.animation = seg.selectedSegmentIndex == 0;
}
- (void)rotationSegChanged:(UISegmentedControl *)seg {
    NSLog(@"是都旋转");
    self.rotate = seg.selectedSegmentIndex == 0;
}

- (void)enter1Action {
    NSLog(@"移动入场");
    [self.stringLabel startShowWithDirection:XPQLabelAnimationDirectionDown duration:0.5 bounce:0.0 stepTime:0.2];
    [self.attributedLabel startShowWithDirection:XPQLabelAnimationDirectionLeft duration:0.5 bounce:0.0 stepTime:0.2];

}
- (void)enter2Action {
    NSLog(@"显现入场");
    CATransform3D transform = CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 1.0);
    [self.stringLabel startFixedShowWithTransform:&transform duration:1.0 stepTime:0.1]; CATransform3DRotate(CATransform3DIdentity, 2 * M_PI, 0.0, 0.0, 1.0);
    [self.attributedLabel startFixedShowWithTransform:&transform duration:1.0 stepTime:0.1];
}
- (void)exit1Action {
    NSLog(@"移动出场");
    [self.stringLabel startHideWithDirection:XPQLabelAnimationDirectionLeft duration:0.5 stepTime:0.2];
    [self.attributedLabel startHideWithDirection:XPQLabelAnimationDirectionDown duration:0.5 stepTime:0.2];

}
- (void)exit2Action {
    NSLog(@"消失出场");
    CATransform3D transform = CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 1.0);
    [self.stringLabel startFixedHideWithTransform:&transform duration:1.0 stepTime:0.1];
    [self.attributedLabel startFixedHideWithTransform:&transform duration:1.0 stepTime:0.1];
}


#pragma mark - Lazy
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    }
    return _contentView;
}
- (UILabel *)horiLabel {
    if (!_horiLabel) {
        UILabel *label = [UIControlFastGet labelWithText:@"水平对齐"];
        [label sizeToFit];

        _horiLabel = label;
    }
    return _horiLabel;
}

- (UILabel *)vetiLabel {
    if (!_vetiLabel) {
        UILabel *label = [UIControlFastGet labelWithText:@"垂直对齐"];
        _vetiLabel = label;
    }
    return _vetiLabel;
}

- (UILabel *)pathLabel {
    if (!_pathLabel) {
        UILabel *label = [UIControlFastGet labelWithText:@"设置路径"];
        _pathLabel = label;
    }
    return _pathLabel;
}

- (UILabel *)animateLabel {
    if (!_animateLabel) {
        UILabel *label = [UIControlFastGet labelWithText:@"动画方式"];
        _animateLabel = label;
    }
    return _animateLabel;
}

- (UISegmentedControl *)horiSeg {
    if (!_horiSeg) {
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"左对齐",@"居中",@"右对齐"]];
        [seg addTarget:self action:@selector(horiSegChanged:) forControlEvents:UIControlEventValueChanged];
        _horiSeg = seg;
    }
    return _horiSeg;
}

- (UISegmentedControl *)vetiSeg {
    if (!_vetiSeg) {
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"上对齐",@"居中",@"下对齐"]];
        [seg addTarget:self action:@selector(vetiSegChanged:) forControlEvents:UIControlEventValueChanged];
        _vetiSeg = seg;
    }
    return _vetiSeg;
}

- (UISegmentedControl *)pathSeg {
    if (!_pathSeg) {
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"无路径",@"直线",@"圆曲线",@"贝塞尔曲线"]];
        [seg addTarget:self action:@selector(pathSegChanged:) forControlEvents:UIControlEventValueChanged];
        _pathSeg = seg;
    }
    return _pathSeg;
}

- (UISegmentedControl *)animateSeg {
    if (!_animateSeg) {
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"有动画",@"无动画"]];
        [seg addTarget:self action:@selector(animateSegChanged:) forControlEvents:UIControlEventValueChanged];
        _animateSeg = seg;
    }
    return _animateSeg;
}

- (UISegmentedControl *)rotationSeg {
    if (!_rotationSeg) {
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"随路径旋转",@"不随路径旋转"]];
        [seg addTarget:self action:@selector(rotationSegChanged:) forControlEvents:UIControlEventValueChanged];
        _rotationSeg = seg;
    }
    return _rotationSeg;
}

- (UIButton *)enter1Btn {
    if (!_enter1Btn) {
        UIButton *button = [UIControlFastGet buttonWithTitle:@"移动入场" titleColor:OriginColor];
        [button addTarget:self action:@selector(enter1Action) forControlEvents:UIControlEventTouchUpInside];
        _enter1Btn = button;
    }
    return _enter1Btn;
}
- (UIButton *)enter2Btn {
    if (!_enter2Btn) {
        UIButton *button = [UIControlFastGet buttonWithTitle:@"显现入场" titleColor:OriginColor];
        [button addTarget:self action:@selector(enter2Action) forControlEvents:UIControlEventTouchUpInside];
        _enter2Btn = button;
    }
    return _enter2Btn;
}
- (UIButton *)exit1Btn {
    if (!_exit1Btn) {
        UIButton *button = [UIControlFastGet buttonWithTitle:@"移动出场" titleColor:OriginColor];
        [button addTarget:self action:@selector(exit1Action) forControlEvents:UIControlEventTouchUpInside];
        _exit1Btn = button;
    }
    return _exit1Btn;
}
- (UIButton *)exit2Btn {
    if (!_exit2Btn) {
        UIButton *button = [UIControlFastGet buttonWithTitle:@"消失出场" titleColor:OriginColor];
        [button addTarget:self action:@selector(exit2Action) forControlEvents:UIControlEventTouchUpInside];
        _exit2Btn = button;
    }
    return _exit2Btn;
}

- (XPQLabel *)stringLabel {
    if (!_stringLabel) {
        _stringLabel = [[XPQLabel alloc] init];
        _stringLabel.text = @"这里是一串普通的文本文字。";
        _stringLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
    }
    return _stringLabel;
}

- (XPQLabel *)attributedLabel {
    if (!_attributedLabel) {
        _attributedLabel = [[XPQLabel alloc] init];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"this is attributed string."];
        //把this的字体颜色变为红色
        [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                            value:(id)[UIColor redColor].CGColor
                            range:NSMakeRange(0, 4)];
        //把is变为绿色
        [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                            value:(id)[UIColor greenColor].CGColor
                            range:NSMakeRange(5, 2)];
        //改变this的字体，value必须是一个CTFontRef
        [attriString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:12].fontName, 20, NULL)) range:NSMakeRange(8, 10)];
        //给this加上下划线，value可以在指定的枚举中选择
        [attriString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                            value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble]
                            range:NSMakeRange(19, 6)];
        _attributedLabel.attributedText = attriString;
        _attributedLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return _attributedLabel;
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
