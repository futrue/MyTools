//
//  GroupNetwork_testVC.m
//  MyTools
//
//  Created by SongGuoxing on 2017/5/27.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "GroupNetwork_testVC.h"

@interface GroupNetwork_testVC ()

@end

@implementation GroupNetwork_testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self line1];
    [self getPostDetailCompletion:^{
        [self showLabel2];
    }];
}

- (void)line1 {
//    /创建信号量/
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    /创建全局并行/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件A");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印i %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件B");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印j %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件C");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印k %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件D");
        for (int i = 0; i<10000; i++) {
            NSLog(@"打印l %d",i);
        }
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
//        /四个请求对应四次信号等待/
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"处理事件E");
        [self showLabel];
    });
}


- (void)showLabel {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"method 1 over";
    label.center = self.view.center;
    label.centerY = 100;
    [label sizeToFit];
    [self.view addSubview:label];
}

- (void)getPostDetailCompletion:(void(^)())completion {
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    dispatch_group_enter(serviceGroup);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self getPostEntityCompletion:^{
            dispatch_group_leave(serviceGroup);
//        }];/
    });
    
    dispatch_group_enter(serviceGroup);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self getPostRecommendInfoCompletion:^{
            dispatch_group_leave(serviceGroup);
//        }];
    });
    
    dispatch_group_enter(serviceGroup);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self getPostRepliesListType:DDPagingRequestTypeRefresh completion:^{
            dispatch_group_leave(serviceGroup);
//        }];
    });
    
    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(), ^{
        completion();
    });
}

- (void)showLabel2 {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"method 2 over";
    label.center = self.view.center;
    label.centerY = 200;
    [label sizeToFit];
    [self.view addSubview:label];
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
