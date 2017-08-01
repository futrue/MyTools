//
//  TestViewController.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/16.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"
#import <objc/runtime.h>

#define RADIANS(degrees) (((degrees) * M_PI) / 180.0)

#define kMaxLength 11
@interface TestViewController ()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *endButton;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UITextField *textF;
@property (nonatomic, strong) YYLabel *label;


@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 64 = 0 http://www.jianshu.com/p/c0b8c5f131a0
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self startButton];
    [self endButton];
    [self commitButton];
    [self testView];
    [self setup];
    [self sortData:nil];

}

- (void)createClass {
    // 创建一个名为 TangQiaoCustomView 的类，它是UIView的子类
    Class newClass = objc_allocateClassPair([UIView class], "TangQiaoCustomView", 0);
    // 为该类增加一个名为 report 的方法
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    // 注册该类
    objc_registerClassPair(newClass);
    
    // 创建一个 TangQiaoCustomView类的实例
    id instanceOfNewClass = [[newClass alloc] init];
    // 调用 report 方法
    [instanceOfNewClass performSelector:@selector(report)];

}

void ReportFunction(id self, SEL _cmd)
{
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++)
    {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}
- (void)report {
    NSLog(@"report");
}


- (void)sortData:(id)data {
//    NSDictionary *data = @{@"6":@"66",@"8":@"88",@"2":@"22",@"11":@"111",@"5":@"55"};
    NSArray*keys = [data allKeys];
    //排序好的key,组成的数组
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    // 要用数组
    NSMutableArray *resultArr = @{}.mutableCopy;
    for (NSString *key in sortedArray) {
        id obj = [data objectForKey:key];
        [resultArr addObject:@{key:obj}];
    }
    NSLog(@"resultArr == %@",resultArr);
    self.dataArr = resultArr;
}


- (void)setup {
    self.textF.frame = CGRectMake(20, 200, 200, 30);
    [self.view addSubview:self.textF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:self.textF];
    
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    
    
    //添加文本
    NSString *title =@"豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。十旬休假，胜友如云；千里逢迎，高朋满座。";
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
    
    text.font = font ;
    
    
    _label = [YYLabel new];
    _label.userInteractionEnabled =YES;
    _label.numberOfLines =0;
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(240, 260) text:text];
    _label.textLayout = layout;
    _label.frame = CGRectMake(60,360, 240,260);
    _label.frame = CGRectMake(60,360, [self measureFrame:layout.frame].width,[self measureFrame:layout.frame].height);

    _label.attributedText = text;
    
    [self.view addSubview:_label];
    
    _label.layer.borderWidth =0.5;
    _label.layer.borderColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:1.000].CGColor;
    
    
    [self addSeeMoreButton];


}
- (void)addSeeMoreButton {
    __weak typeof(self) _self =self;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...more"];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
        YYLabel *label = _self.label;
        [label sizeToFit];
    };
    
    [text setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"more"]];
    [text setTextHighlight:hi range:[text.string rangeOfString:@"more"]];
    text.font =_label.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
    _label.truncationToken = truncationToken;
}

- (CGSize)measureFrame:(CTFrameRef)frame
{
    CGPathRef framePath = CTFrameGetPath(frame);
    CGRect frameRect = CGPathGetBoundingBox(framePath);
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex numLines = CFArrayGetCount(lines);
    CGFloat maxWidth = 0;
    CGFloat textHeight = 0;
    CFIndex lastLineIndex = numLines - 1;
    
    for(CFIndex index = 0; index < numLines; index++)
    {
        CGFloat ascent, descent, leading, width;
        CTLineRef line = (CTLineRef) CFArrayGetValueAtIndex(lines, index);
        width = CTLineGetTypographicBounds(line, &ascent,  &descent, &leading);
        if (width > maxWidth) { maxWidth = width; }
        if (index == lastLineIndex) {
            CGPoint lastLineOrigin;
            CTFrameGetLineOrigins(frame, CFRangeMake(lastLineIndex, 1), &lastLineOrigin);
            textHeight =  CGRectGetMaxY(frameRect) - lastLineOrigin.y + descent;
        }
    }
    return CGSizeMake(ceil(maxWidth), ceil(textHeight));
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
    [self startAnimate];
//    [self performSelector:@selector(didRuninCurrModel:) withObject:[NSNumber numberWithBool:YES] afterDelay:3.0f];
//    [self performSelector:@selector(didRuninCurrModelNoArgument) withObject:nil afterDelay:3.0f];
    
//    [self performSelector:@selector(changeColor) withObject:nil afterDelay:2.0f];
//    [self.testView performSelector:@selector(changeRandomColor) withObject:nil afterDelay:2.0f];
    
}

- (void)endAction {
    [self stopAnimate];
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

- (void)startAnimate {
    UIView *view = self.testView;
    view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5));
    
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^ {
        view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5));
    } completion:nil];
}

- (void)stopAnimate {
    UIView *view = self.testView;
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear) animations:^ {
        view.transform = CGAffineTransformIdentity;
    } completion:nil];
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
        _testView = [[TestView alloc] initWithFrame:CGRectMake(10, 370, self.view.width - 20, 270)];
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
