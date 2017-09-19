//
//  GroupSettingVC.h
//  MyTools
//
//  Created by SongGuoxing on 2017/8/10.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingGroup.h"

@interface GroupSettingVC : UITableViewController

@property (nonatomic, strong) NSMutableArray <SettingGroup *> *groups;

@end
