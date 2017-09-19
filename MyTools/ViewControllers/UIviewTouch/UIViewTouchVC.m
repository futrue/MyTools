//
//  UIViewTouchVC.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/7.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "UIViewTouchVC.h"
#import "SomeView.h"

#define kImageCount  4
//guide_1
@interface UIViewTouchVC ()
@property (nonatomic, strong) SomeView *cView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, assign) int currentIndex;

@end

@implementation UIViewTouchVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self touches];
    
    [self initLayout];
    [self addGesture];
}

- (void)touches {
    SomeView *customView = [[SomeView alloc] init];
    customView.frame = CGRectMake(20, 200, 160, 255);
    self.cView = customView;
    [self.view addSubview:customView];
}

- (void)initLayout {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 270, 330)];
    imgView.centerX = self.view.centerX;
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"guide_1"];
    [self.view addSubview:imgView];
    self.imgView = imgView;
    self.currentIndex = 1;
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    tap.numberOfTapsRequired = 1;//设置点按次数，默认为1
    tap.numberOfTouchesRequired = 1;//点按的手指数
    [self.view addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressImage:)];
    longGes.minimumPressDuration = 0.5;//默认是0.5，一般不修改
    [self.imgView addGestureRecognizer:longGes];
    
    /*添加捏合手势*/
    UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImage:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    /*添加旋转手势*/
    UIRotationGestureRecognizer *rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    [self.imgView addGestureRecognizer:rotationGesture];
    
    /*添加拖动手势*/
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImage:)];
    [self.imgView addGestureRecognizer:panGesture];
    
    /*添加轻扫手势*/
    //注意一个轻扫手势只能控制一个方向，默认向右，通过direction进行方向控制
    UISwipeGestureRecognizer *swipeGestureToRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    //swipeGestureToRight.direction=UISwipeGestureRecognizerDirectionRight;//默认为向右轻扫
    [self.view addGestureRecognizer:swipeGestureToRight];
    
    UISwipeGestureRecognizer *swipeGestureToLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeGestureToLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureToLeft];

    // //解决在图片上滑动时拖动手势和轻扫手势的冲突
    [panGesture requireGestureRecognizerToFail:swipeGestureToRight];
    [panGesture requireGestureRecognizerToFail:swipeGestureToLeft];
    //解决拖动和长按手势之间的冲突
    [longGes requireGestureRecognizerToFail:panGesture];
    
    /*演示不同视图的手势同时执行
     *在上面_imageView已经添加了长按手势，这里给视图控制器的视图也加上长按手势让两者都执行
     *
     */
    self.view.tag=100;
    self.imgView.tag=200;
    UILongPressGestureRecognizer *viewLongPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    viewLongPressGesture.delegate=self;
    [self.view addGestureRecognizer:viewLongPressGesture];

}

- (void)nextImage {
    int index = (self.currentIndex + kImageCount + 1) % kImageCount;
    self.currentIndex = index;
}

- (void)lastImage {
    int index = (self.currentIndex + kImageCount - 1) % kImageCount;
    self.currentIndex = index;
}

- (void)setCurrentIndex:(int)currentIndex {
    _currentIndex = currentIndex;
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%i",currentIndex]];
    [self showPhotoImage];
}

- (void)showPhotoImage {
    self.title = [NSString stringWithFormat:@"guide_%i",self.currentIndex];
}


#pragma mark - 视图控制器的触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIViewController start touch...");
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    //取得一个触摸对象（对于多点触摸可能有多个对象）
//    UITouch *touch=[touches anyObject];
////    NSLog(@"%@",touch);
//    //取得当前位置
//    CGPoint current=[touch locationInView:self.view];
//    //取得前一个位置
//    CGPoint previous=[touch previousLocationInView:self.view];
//    //移动前的中点位置
//    CGPoint center=self.cView.center;
//    //移动偏移量
//    CGPoint offset=CGPointMake(current.x-previous.x, current.y-previous.y);
//    //重新设置新位置
//    self.cView.center=CGPointMake(center.x+offset.x, center.y+offset.y);
    
    NSLog(@"UIViewController moving...");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"UIViewController touch end.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - 手势操作
#pragma mark 点按隐藏或显示导航栏
-(void)tapImage:(UITapGestureRecognizer *)gesture{
    //NSLog(@"tap:%i",gesture.state);
    BOOL hidden=!self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

#pragma mark 长按提示是否删除
-(void)longPressImage:(UILongPressGestureRecognizer *)gesture{
    //NSLog(@"longpress:%i",gesture.state);
    //注意其实在手势里面有一个view属性可以获取点按的视图
    //UIImageView *imageView=(UIImageView *)gesture.view;
    
    //由于连续手势此方法会调用多次，所以需要判断其手势状态
    if (gesture.state==UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"System Info" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete the photo" otherButtonTitles:nil];
        [actionSheet showInView:self.view];
        
    }
}

#pragma mark 捏合时缩放图片
-(void)pinchImage:(UIPinchGestureRecognizer *)gesture{
    //NSLog(@"pinch:%i",gesture.state);
    
    if (gesture.state==UIGestureRecognizerStateChanged) {
        //捏合手势中scale属性记录的缩放比例
        self.imgView.transform=CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }else if(gesture.state==UIGestureRecognizerStateEnded){//结束后恢复
        [UIView animateWithDuration:.5 animations:^{
            self.imgView.transform=CGAffineTransformIdentity;//取消一切形变
        }];
    }
}

#pragma mark 旋转图片
-(void)rotateImage:(UIRotationGestureRecognizer *)gesture{
    //NSLog(@"rotate:%i",gesture.state);
    if (gesture.state==UIGestureRecognizerStateChanged) {
        //旋转手势中rotation属性记录了旋转弧度
        self.imgView.transform=CGAffineTransformMakeRotation(gesture.rotation);
    }else if(gesture.state==UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.8 animations:^{
            self.imgView.transform=CGAffineTransformIdentity;//取消形变
        }];
    }
}

#pragma mark 拖动图片
-(void)panImage:(UIPanGestureRecognizer *)gesture{
    if (gesture.state==UIGestureRecognizerStateChanged) {
        CGPoint translation=[gesture translationInView:self.view];//利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动
        self.imgView.transform=CGAffineTransformMakeTranslation(translation.x, translation.y);
    }else if(gesture.state==UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            self.imgView.transform=CGAffineTransformIdentity;
        }];
    }
    
}

#pragma mark 轻扫则查看下一张或上一张
//注意虽然轻扫手势是连续手势，但是只有在识别结束才会触发，不用判断状态
-(void)swipeImage:(UISwipeGestureRecognizer *)gesture{
    //    NSLog(@"swip:%i",gesture.state);
    //    if (gesture.state==UIGestureRecognizerStateEnded) {
    
    //direction记录的轻扫的方向
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {//向右
        [self nextImage];
        //            NSLog(@"right");
    }else if(gesture.direction==UISwipeGestureRecognizerDirectionLeft){//向左
        //            NSLog(@"left");
        [self lastImage];
    }
    //    }
}



#pragma mark 控制器视图的长按手势
-(void)longPressView:(UILongPressGestureRecognizer *)gesture{
    NSLog(@"view long press!");
}


#pragma mark 手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //NSLog(@"%i,%i",gestureRecognizer.view.tag,otherGestureRecognizer.view.tag);
    
    //注意，这里控制只有在UIImageView中才能向下传播，其他情况不允许
    if ([otherGestureRecognizer.view isKindOfClass:[UIImageView class]]) {
        return YES;
    }
    return NO;
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
