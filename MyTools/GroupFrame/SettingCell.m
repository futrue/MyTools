//
//  SettingCell.m
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle
{
    static NSString *ID = @"cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(SettingItem *)item {
    _item = item;
    [self setUpData];
    
    [self setUpAccessoryView];
}
// 设置数据
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subtitle;
}
// 设置右边的辅助视图
- (void)setUpAccessoryView
{
    self.accessoryType = _item.accessoryType;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
