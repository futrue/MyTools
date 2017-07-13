//
//  MIT License
//
//  Copyright (c) 2012 Bob McCune http://bobmccune.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "StickyNotesViewController.h"
#import "NoteView.h"

@implementation StickyNotesViewController

+ (NSString *)displayName {
	return @"Sticky Notes";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	self.title = [[self class] displayName];
	self.noteView = [[NoteView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)];
	self.noteView.delegate = self;
	self.noteView.text = @"A computer once beat me at chess, but it was no match for me at kick boxing.\n-Emo Philips";
	self.nextText = @"A lot of people are afraid of heights. Not me, I'm afraid of widths.\n-Steven Wright";

	UIImage *corkboard = [UIImage imageNamed:@"corkboard.png"];
	self.view.backgroundColor = [UIColor colorWithPatternImage:corkboard];

    // Shadow needs to be applied to the containing layer so it doesn't blip when the animation occurs.
    // Hat tip to Troy for pointing that out!
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 300)];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.layer.shadowOffset = CGSizeMake(0, 2);
    containerView.layer.shadowOpacity = 0.80;
    [containerView addSubview:self.noteView];
	[self.view addSubview:containerView];
}

- (void)addNoteTapped {
	[UIView transitionWithView:self.noteView duration:0.6
					   options:UIViewAnimationOptionTransitionCurlUp
					animations:^{
						NSString *currentText = self.noteView.text;
						self.noteView.text = self.nextText;
						self.nextText = currentText;
					} completion:^(BOOL finished){

                    }];
}

/*
 typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
 UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
 UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
 UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
 
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
 UIViewAnimationOptionCurveEaseIn               = 1 << 16,
 UIViewAnimationOptionCurveEaseOut              = 2 << 16,
 UIViewAnimationOptionCurveLinear               = 3 << 16,
 
 UIViewAnimationOptionTransitionNone            = 0 << 20, // default
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
 
 UIViewAnimationOptionPreferredFramesPerSecondDefault     = 0 << 24,
 UIViewAnimationOptionPreferredFramesPerSecond60          = 3 << 24,
 UIViewAnimationOptionPreferredFramesPerSecond30          = 7 << 24,
 
 } NS_ENUM_AVAILABLE_IOS(4_0);
 
 UIViewAnimationOptionLayoutSubviews            //提交动画的时候布局子控件，表示子控件将和父控件一同动画。
 
 UIViewAnimationOptionAllowUserInteraction      //动画时允许用户交流，比如触摸
 
 UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
 
 UIViewAnimationOptionRepeat                    //动画无限重复
 
 UIViewAnimationOptionAutoreverse               //执行动画回路,前提是设置动画无限重复
 
 UIViewAnimationOptionOverrideInheritedDuration //忽略外层动画嵌套的执行时间
 
 UIViewAnimationOptionOverrideInheritedCurve    //忽略外层动画嵌套的时间变化曲线
 
 UIViewAnimationOptionAllowAnimatedContent      //通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照
 
 UIViewAnimationOptionShowHideTransitionViews   //用显隐的方式替代添加移除图层的动画效果
 
 UIViewAnimationOptionOverrideInheritedOptions  //忽略嵌套继承的选项
 
 //时间函数曲线相关
 
 UIViewAnimationOptionCurveEaseInOut            //时间曲线函数，由慢到快
 
 UIViewAnimationOptionCurveEaseIn               //时间曲线函数，由慢到特别快
 
 UIViewAnimationOptionCurveEaseOut              //时间曲线函数，由快到慢
 
 UIViewAnimationOptionCurveLinear               //时间曲线函数，匀速
 
 //转场动画相关的
 
 UIViewAnimationOptionTransitionNone            //无转场动画
 
 UIViewAnimationOptionTransitionFlipFromLeft    //转场从左翻转
 
 UIViewAnimationOptionTransitionFlipFromRight   //转场从右翻转
 
 UIViewAnimationOptionTransitionCurlUp          //上卷转场
 
 UIViewAnimationOptionTransitionCurlDown        //下卷转场
 
 UIViewAnimationOptionTransitionCrossDissolve   //转场交叉消失
 
 UIViewAnimationOptionTransitionFlipFromTop     //转场从上翻转
 
 UIViewAnimationOptionTransitionFlipFromBottom  //转场从下翻转
 

 */

@end
