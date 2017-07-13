//
//  DropDownListProtocol.h
//  DropDownList_test
//
//  Created by SGX on 17/2/6.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownListDelegate <NSObject>

@optional
- (void)didSelectedSection:(NSInteger)section index:(NSInteger)index;

@end

@protocol DropDownListDataSource <NSObject>

@optional
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section index:(NSInteger)index;

@end

