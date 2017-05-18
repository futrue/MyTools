//
//  ContactGroup.h
//  ContactGroup
//
//  Created by chwe on 16/3/3.
//  Copyright © 2016年 chwe. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Contact.h"
@interface ContactGroup : NSObject


#pragma mark 组名
@property (nonatomic,copy) NSString *name;

#pragma mark 分组描述
@property (nonatomic,copy) NSString *detail;

#pragma mark 联系人
@property (nonatomic,strong) NSMutableArray *contacts;

#pragma mark 带参数个构造函数
-(ContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;

#pragma mark 静态初始化方法
+(ContactGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)contacts;


@end
