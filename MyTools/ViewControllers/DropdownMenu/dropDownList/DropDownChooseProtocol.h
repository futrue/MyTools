//
//  DropDownChooseProtocol.h
//  DropDownDemo
//
//  Created by 韩占禀 on 15-3-27.
//  Copyright (c) 2015年 韩占禀. All rights reserved.
//

#import <Foundation/Foundation.h>

//协议：DropDownChooseDelegate
@protocol DropDownChooseDelegate <NSObject>

@optional

-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index;

@end

//协议：DropDownChooseDataSource
@protocol DropDownChooseDataSource <NSObject>

-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
-(NSInteger)defaultShowSection:(NSInteger)section;

@end



