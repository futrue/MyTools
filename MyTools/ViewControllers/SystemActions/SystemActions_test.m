//
//  SystemActions_test.m
//  MyTools
//
//  Created by SGX on 17/1/13.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SystemActions_test.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface SystemActions_test ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//need import AVFoundation.framework ?
@property (nonatomic,strong) UIButton *mybutton;
@property (nonatomic,strong) UIButton *picLibraryButton;
@property (nonatomic,strong) AVCaptureSession *AVSession;
@property (nonatomic,strong) UIButton *OpenFlashLitght;
@property (nonatomic,strong) UIButton *CloseFlashLight;

@property (nonatomic,strong) UIButton *PickerImageButton;
@property (nonatomic,strong) UIImageView *ShowimageView;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation SystemActions_test

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"button" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(50, 70, 100, 50);
    addBtn.tag = 1;
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btn = addBtn;
    [self.view addSubview:self.btn];
    
    
    _mybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _mybutton.frame = CGRectMake(30, 100, 300, 30);
    _mybutton.backgroundColor = [UIColor redColor];
    [_mybutton setTitle:@"相机" forState:UIControlStateNormal];
    [_mybutton setTitle:@"你呀的，真点啊" forState:UIControlStateHighlighted];
    [_mybutton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_mybutton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_mybutton setTintColor:[UIColor purpleColor]];
    _mybutton.showsTouchWhenHighlighted = YES;
    
    [_mybutton addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_mybutton];
    
    // 相册
    _picLibraryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _picLibraryButton.frame = CGRectMake(30, 150, 300, 30);
    _picLibraryButton.backgroundColor = [UIColor grayColor];
    [_picLibraryButton setTitle:@"相册" forState:UIControlStateNormal];
    [_picLibraryButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_picLibraryButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_picLibraryButton addTarget:self action:@selector(openPictureLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_picLibraryButton];
    
    // 开启闪光灯
    _OpenFlashLitght = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _OpenFlashLitght.frame = CGRectMake(30, 200, 300, 30);
    _OpenFlashLitght.backgroundColor = [UIColor greenColor];
    [_OpenFlashLitght setTitle:@"开启闪关灯" forState:UIControlStateNormal];
    [_OpenFlashLitght setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [_OpenFlashLitght setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    [_OpenFlashLitght addTarget:self action:@selector(openFlashLight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_OpenFlashLitght];
    // 关闭闪光灯
    _CloseFlashLight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _CloseFlashLight.frame = CGRectMake(30, 250, 300, 30);
    _CloseFlashLight.backgroundColor = [UIColor yellowColor];
    [_CloseFlashLight setTitle:@"关闭闪关灯" forState:UIControlStateNormal];
    [_CloseFlashLight setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [_CloseFlashLight setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [_CloseFlashLight addTarget:self action:@selector(closeFlashLight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_CloseFlashLight];
    
    // 从相册选择照片
    _PickerImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _PickerImageButton.frame = CGRectMake(30, 300, 300, 30);
    _PickerImageButton.tag = 501;
    _PickerImageButton.backgroundColor = [UIColor cyanColor];
    [_PickerImageButton setTitle:@"选择照片" forState:UIControlStateNormal];
    [_PickerImageButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_PickerImageButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_PickerImageButton addTarget:self action:@selector(openPictureLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_PickerImageButton];
    
    //
    _ShowimageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 350, 300, 300)];
    _ShowimageView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_ShowimageView];
    _ShowimageView.image = [UIImage imageNamed:@"IMG_0003.JPG"];
}

- (void)addClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 1:
        {
            NSString *phoneNumber=@"18500138888";
            //    NSString *url=[NSString stringWithFormat:@"tel://%@",phoneNumber];//这种方式会直接拨打电话
            NSString *url=[NSString stringWithFormat:@"telprompt://%@",phoneNumber];//这种方式会提示用户确认是否拨打电话
            [self openUrl:url];
            
        }
            break;
        case 2:
        {
            NSString *phoneNumber=@"18500138888";
            NSString *url=[NSString stringWithFormat:@"sms://%@",phoneNumber];
            [self openUrl:url];
        }
            break;
        case 3:
        {
            NSString *mailAddress=@"kenshin@hotmail.com";
            NSString *url=[NSString stringWithFormat:@"mailto://%@",mailAddress];
            [self openUrl:url];
            
        }
            break;
        case 4:
        {
            NSString *url=@"http://www.cnblogs.com/kenshincui";
            [self openUrl:url];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)openUrl:(NSString *)urlStr{
    // http://www.jianshu.com/p/9fcd37c0ea05    37
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    [[UIApplication sharedApplication] openURL:url];

}


///-----------
- (void)takePicture:(id)button
{
    //    //判断是否可以打开相机，模拟器此功能无法使用
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    //        // 创建相机对象
    //        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    //        // 摄像头
    //        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //        //
    //        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    //        picker.mediaTypes = temp_MediaTypes;
    //
    //        picker.delegate = self;
    //        picker.allowsEditing = YES;
    //
    //
    //
    //
    //
    //
    //
    //        [self presentViewController:picker animated:YES completion:nil];
    //
    //    }
    //    else{
    //        // 如果没有提示用户
    //        UIAlertController *alertContolrer = [UIAlertController alertControllerWithTitle:@"相机" message:@"这是模拟器不是相机" preferredStyle:UIAlertControllerStyleAlert];
    //        [self presentViewController:alertContolrer animated:YES completion:nil];
    //
    //        UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    //        [alertContolrer addAction:alert1];
    //
    ////        UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"Default" style:UIAlertActionStyleDefault handler:nil];
    ////        [alertContolrer addAction:alert2];
    ////
    ////        UIAlertAction *alert3 = [UIAlertAction actionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:nil];
    ////        [alertContolrer addAction:alert3];
    ////
    //
    //    }
    //    NSLog(@"打开相机");
    
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"模拟器你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
    
}
// 打开相册
- (void)openPictureLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary ]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        // 打开相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        picker.delegate =self;
        //        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    NSLog(@"打开相册");
}



// 打开闪关灯
- (void)openFlashLight
{
    // 只是打开
    //    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //    if (device.torchMode == AVCaptureTorchModeOff) {
    //        //Create an AV session
    //        AVCaptureSession * session = [[AVCaptureSession alloc]init];
    //
    //        // Create device input and add to current session
    //        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //        [session addInput:input];
    //
    //        // Create video output and add to current session
    //        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
    //        [session addOutput:output];
    //
    //        // Start session configuration
    //        [session beginConfiguration];
    //        [device lockForConfiguration:nil];
    //
    //        // Set torch to on
    //        [device setTorchMode:AVCaptureTorchModeOn];
    //
    //        [device unlockForConfiguration];
    //        [session commitConfiguration];
    //
    //        // Start the session
    //        [session startRunning];
    //
    //        // Keep the session around
    //        [self setAVSession:self.AVSession];
    //        NSLog(@"开启闪光灯");
    //        sleep(3.0);// 控制时间有待优化
    //
    //    }
    //------------------ 闪光灯常亮
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];            if (![device hasTorch]) {//判断是否有闪光灯
        NSLog(@"no torch");
    }else{
        [device lockForConfiguration:nil];//锁定闪光灯
        [device setTorchMode: AVCaptureTorchModeOn];//打开闪光灯
        [device unlockForConfiguration];  //解除锁定
        
    }
    //----------------
    
}

- (void)closeFlashLight
{
    //    [self.AVSession stopRunning];
    //    NSLog(@"关闭闪光灯");
    //----------------
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];            if (![device hasTorch]) {//判断是否有闪光灯
        NSLog(@"no torch");
    }else{
        [device lockForConfiguration:nil];//锁定闪光灯
        [device setTorchMode: AVCaptureTorchModeOff];//关闭闪光灯
        [device unlockForConfiguration];  //解除锁定
        
    }
    //----------------
    
}

#pragma mark --
#pragma mark---UIImagePickerControllerDelegate里的方法
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取照片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 存入相册
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    if ([self.view viewWithTag:501]) {
        [self performSelector:@selector(selectPic:) withObject:image afterDelay:0.1];
    }
    NSURL *imageUrl = [info valueForKey:UIImagePickerControllerReferenceURL];

    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    //根据url获取asset信息, 并通过block进行回调
    [assetsLibrary assetForURL:imageUrl resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        NSString *imageName = representation.filename;
        //获取图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];

        NSLog(@"imageName:%@", imageName);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];


    [self dismissViewControllerAnimated:YES completion:nil];
}


//选着照片
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self performSelector:@selector(selectPic:) withObject:image afterDelay:0.1];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
// 选择照片显示
- (void)selectPic:(UIImage *)image
{
    
    NSLog(@"image:%@",image);
    _ShowimageView.image = image;
    // yourmethod 可以添加你自定义的方法
    [self performSelectorInBackground:@selector(yourmethod) withObject:nil];
}
/**
 *  自定义方法
 */
- (void)yourmethod
{
    NSLog(@"自定义方法");
}

// 点击Cancel 执行的 方法 // 取消选择照片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [self dismissViewControllerAnimated:YES completion:nil];
}


//iPhone 打开和关闭闪光灯代码

//通过以下代码可以调用闪光灯的打开和关闭状态。

-(void)turnOffLed {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch]) {
        
        [device lockForConfiguration:nil];
        
        [device setTorchMode: AVCaptureTorchModeOff];
        
        [device unlockForConfiguration];
        
    }
    
}


-(void)turnOnLed {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch]) {
        
        [device lockForConfiguration:nil];
        
        [device setTorchMode: AVCaptureTorchModeOn];
        
        [device unlockForConfiguration];          
        
    }   
    
}


@end
