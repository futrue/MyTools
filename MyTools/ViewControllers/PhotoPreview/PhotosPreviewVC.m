//
//  PhotosPreviewVC.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "PhotosPreviewVC.h"
#import "iCarousel.h"
#import "AFSoundManager.h"

#define ITEM_SPACING 200
#define IMG_NUMBER  6

@interface PhotosPreviewVC ()<iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) iCarousel *carousel;
//音乐部分
@property (nonatomic, strong) UIButton *statusButton;  //播放状态

@property (nonatomic,assign) BOOL wrap;

@end

@implementation PhotosPreviewVC
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self soundManager];
    self.wrap = YES;
}

- (void)setupUI {
    self.view.backgroundColor = BgColor;
    [self.view addSubview:self.typeBtn];
    [self.view addSubview:self.statusButton];
    [self.view addSubview:self.carousel];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-30);
    }];

//    [self.carousel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(self.view).offset(30);
//    }];

}
- (void)soundManager{
    self.typeBtn.selected = YES;
    [self playLocalFile];
    [self oFFType];
}

- (void)swichType {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"图片类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"type1", @"type2", @"type3", @"type4", @"type5", @"type6", @"type7", @"type8", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    for (UIView *view in self.carousel.visibleItemViews)
    {
        view.alpha = 1.0;
    }
    
    [UIView beginAnimations:nil context:nil];
    self.carousel.type = (int)buttonIndex;
    [UIView commitAnimations];
    
}

- (void)oFFType {
    if (self.statusButton.isSelected) {  //播放
        [self pauseAudio];
        self.statusButton.selected = NO;
        
    }else{  //暂停
        [self resumeAudio];
        self.statusButton.selected = YES;
    }
}

-(void)pauseAudio {
    [[AFSoundManager sharedManager]pause];
}

-(void)resumeAudio {
    [[AFSoundManager sharedManager]resume];
}

-(void)playLocalFile {
    [[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"111.mp3" andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"mm:ss"];
    }];
}

-(UIImage *)invertImage:(UIImage *)originalImage {
    UIGraphicsBeginImageContext(originalImage.size);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    CGRect imageRect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    [originalImage drawInRect:imageRect];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, originalImage.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    CGContextClipToMask(UIGraphicsGetCurrentContext(), imageRect,  originalImage.CGImage);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, originalImage.size.width, originalImage.size.height));
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}



#pragma mark -
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return IMG_NUMBER;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index{
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%zi.jpg",index]]];
    
    view.frame = CGRectMake(70, 80, 180, 260);
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
    return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel{
    return IMG_NUMBER;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carouse{
    return self.wrap;
}


- (UIButton *)typeBtn {
    if (!_typeBtn) {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeBtn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(swichType) forControlEvents:UIControlEventTouchUpInside];
        [_typeBtn sizeToFit];
}
    return _typeBtn;
}

- (UIButton *)statusButton {
    if (!_statusButton) {
        _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statusButton setImage:[UIImage imageNamed:@"喇叭11.png"] forState:UIControlStateNormal];
        [_statusButton setImage:[UIImage imageNamed:@"喇叭22.png"] forState:UIControlStateSelected];
        [_statusButton setTitle:@"播放" forState:UIControlStateSelected];
        [_statusButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_statusButton addTarget:self action:@selector(oFFType) forControlEvents:UIControlEventTouchUpInside];
        [_statusButton sizeToFit];
    }
    return _statusButton;
}

- (iCarousel *)carousel {
    if (!_carousel) {
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH - 20, 300)];
        _carousel.delegate = self;
        _carousel.dataSource = self;
        _carousel.type = iCarouselTypeCustom;
    }
    return _carousel;
}
@end
