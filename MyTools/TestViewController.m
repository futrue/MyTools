//
//  TestViewController.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/16.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"

#define kMaxLength 11
@interface TestViewController ()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *endButton;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UITextField *textF;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startButton];
    [self endButton];
    [self commitButton];
//    [self testView];
    [self setup];
    
}

- (void)setup {
    self.textF.frame = CGRectMake(20, 200, 200, 30);
    [self.view addSubview:self.textF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:self.textF];

}

- (void)textFiledEditChanged:(NSNotification *)noti {
    UITextField *textField = (UITextField *)noti.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[textField textInputMode] primaryLanguage];// [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (void)didRuninCurrModel:(id)sender {
    NSLog(@"running---with object-----");
}

- (void)didRuninCurrModelNoArgument {
    NSLog(@"running---without object-----");
}

- (void)changeColor {
    [self.testView changeRandomColor];
}

- (void)startAction {
//    [self performSelector:@selector(didRuninCurrModel:) withObject:[NSNumber numberWithBool:YES] afterDelay:3.0f];
//    [self performSelector:@selector(didRuninCurrModelNoArgument) withObject:nil afterDelay:3.0f];
    
//    [self performSelector:@selector(changeColor) withObject:nil afterDelay:2.0f];
//    [self.testView performSelector:@selector(changeRandomColor) withObject:nil afterDelay:2.0f];
    
}

- (void)endAction {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:[NSNumber numberWithBool:YES]];//可以取消成功。
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:[NSNumber numberWithBool:NO]];//不能取消成功。参数不匹配
//
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModel:) object:nil];//不能取消成功。参数不匹配
//    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRuninCurrModelNoArgument) object:nil];//可以成功取消
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
//    [[self class] cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];//可以取消成功。
    [NSObject cancelPreviousPerformRequestsWithTarget:self.testView selector:@selector(changeRandomColor) object:nil];//不能取消成功。参数不匹配

}


- (UIButton *)startButton {
    if (!_startButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.layer.cornerRadius = 4.f;
        [btn setTitle:@"Start" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
        _startButton = btn;
        btn.frame = CGRectMake(20, 100, 60, 35);
        [self.view addSubview:btn];
    }
    return _startButton;
}

- (UIButton *)endButton {
    if (!_endButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 4.f;
        [btn setTitle:@"End" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(endAction) forControlEvents:UIControlEventTouchUpInside];
        _endButton = btn;
        btn.frame = CGRectMake(100, 100, 60, 35);
        [self.view addSubview:btn];

    }
    return _endButton;
}

- (UIButton *)commitButton {
    if (!_commitButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 4.f;
        [btn setTitle:@"commit" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        _commitButton = btn;
        btn.frame = CGRectMake(180, 100, 66, 35);
        [self.view addSubview:btn];
        
    }
    return _commitButton;
}


- (TestView *)testView {
    if (!_testView) {
        _testView = [[TestView alloc] initWithFrame:CGRectMake(20, 300, 200, 80)];
        _testView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_testView];
    }
    return _testView;
}

- (UITextField *)textF {
    if (!_textF) {
        _textF = [[UITextField alloc] init];
        _textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textF.layer.cornerRadius = 4;
        _textF.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return _textF;
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
