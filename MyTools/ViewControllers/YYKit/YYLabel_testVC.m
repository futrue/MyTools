//
//  YYLabel_testVC.m
//  Skill_test
//
//  Created by SGX on 17/1/4.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "YYLabel_testVC.h"

@interface YYLabel_testVC ()
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) YYLabel *yyLabel;
@property (nonatomic, strong) NSMutableAttributedString *text;
@property (nonatomic) YYTextDirection dotDirection;

@end

@implementation YYLabel_testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text = [[NSMutableAttributedString alloc] initWithString:@"test"];
    self.text.font = [UIFont boldSystemFontOfSize:24];
    //    self.text.underlineStyle = NSUnderlineStyleSingle;
    //    __weak typeof(self) weakSelf = self;
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Linkvsfwef="];
        one.font = [UIFont boldSystemFontOfSize:24];
        //        one.underlineStyle = NSUnderlineStyleSingle;
        [one setTextHighlightRange:one.rangeOfAll
                             color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:nil];
        
        [self.text appendAttributedString:one];
        
    }
    self.yyLabel.frame = CGRectMake(20, 100, 200, 30);
    [self.view addSubview:self.yyLabel];
    
    self.yyLabel.attributedText = self.text;
    
    
    
    [self.view addSubview:self.label1];
    
    self.label1.attributedText = self.text;
    
    [self setup];
}

- (void)setup {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor grayColor];
    label.text = @"aaaasdfghjkefqeqsadfl;";
    label.textColor = [UIColor redColor];
    label.center = self.view.center;
    [label sizeToFit];
    [self.view addSubview:label];
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 100, 30)];
    }
    return _label1;
}

- (YYLabel *)yyLabel {
    if (!_yyLabel) {
        _yyLabel = [[YYLabel alloc] init];
        _yyLabel.textAlignment = NSTextAlignmentCenter;
        _yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _yyLabel.numberOfLines = 0;
        _yyLabel.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
        _yyLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSLog(@"highlightTapAction: %@",[text.string substringWithRange:range]);
        };
        
    }
    return _yyLabel;
}

@end
