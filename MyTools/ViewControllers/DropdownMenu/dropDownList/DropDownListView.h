//
//  DropDownListView.h
//  DropDownList_test
//
//  Created by SGX on 17/2/6.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListProtocol.h"
typedef NS_ENUM(NSInteger, AlignmentType) {
    AlignmentTypeRight      = 0,    // Visually left aligned
    AlignmentTypeCenter     = 1    // Visually left aligned
};
//__attribute__((deprecated("已废弃，请使用DDPHPRequest")))
@interface DropDownListView : UIView

- (void)setDelegate:(id<DropDownListDelegate>)delegate dataSource:(id<DropDownListDataSource>)dataSource;


/**
 reset title for self

 @param title new title
 @param section someone section
 */
- (void)setTitle:(NSString *)title inSection:(NSInteger)section;

@property (nonatomic, assign) AlignmentType alignmentType;
@property (nonatomic, assign) NSInteger defaultShowSection;

@end
