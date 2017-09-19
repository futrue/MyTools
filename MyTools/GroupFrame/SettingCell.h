//
//  SettingCell.h
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"

@interface SettingCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle;

@property (nonatomic, strong) SettingItem *item;
@end
