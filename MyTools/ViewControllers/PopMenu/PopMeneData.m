//
//  PopMeneData.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/20.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "PopMeneData.h"

@implementation PopMeneData


+ (NSArray<NSDictionary *> *)dataSource {
    NSArray *array = @[@{@"软件开发":@[@"app-PC端软件开发",
                                    @"app-手机端网站开发",
                                    @"app-移动App"]},
                        @{@"网站开发":@[@"web-PC端软件开发",
                                    @"web-手机端网站开发",
                                    @"web-移动App",
                                    @"web-后台开发" ,
                                    @"web-H5开发"]},
                        @{@"移动办公开发":@[@"mobile-PC端软件开发",
                                    @"mobile-手机端网站开发",
                                    @"mobile-移动App",
                                    @"mobile-后台开发"]},
                        @{@"家具等":@[@"home-PC端软件开发",
                                    @"home-手机端网站开发",
                                    @"home-移动App",
                                    @"home-后台开发"]}];

    return array;
}

@end
