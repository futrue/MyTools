//
//  SettingItem.h
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;
/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;
/** 封装点击这行cell想做的事情 */
// block 只能用 copy,这里就比较牛逼了，回调没有参数，但是在做回调的地方可以传任意数据
@property (nonatomic, copy) void (^operation)();

+ (instancetype)itemWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title;

@end
