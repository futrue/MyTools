//
//  YHDropDownMenu.h
//  YHDropDownMenuDemo
//
//  Created by 王英辉 on 9/26/14.
//  Copyright (c) 2014 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHIndexPath : NSObject

/**
 * 列
 */
@property (nonatomic, assign) NSInteger column;

/**
 * 行
 */
@property (nonatomic, assign) NSInteger row;

/**
 * 初始化类方法和对象方法
 */
- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row;

@end

#pragma mark - data source protocol
@class YHDropDownMenu;

@protocol YHDropDownMenuDataSource <NSObject>

@required

/**
 * 某列有多少行
 */
- (NSInteger)menu:(YHDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;

/**
 * 某行的文字
 */
- (NSString *)menu:(YHDropDownMenu *)menu titleForRowAtIndexPath:(YHIndexPath *)indexPath;

@optional

/**
 * 设置菜单多少列，默认为一列
 */
- (NSInteger)numberOfColumnsInMenu:(YHDropDownMenu *)menu;

/**
 * 设置某列图标是否动画
 */
- (BOOL)menu:(YHDropDownMenu *)menu animateOfRowsInColumn:(NSInteger)column;

/**
 * 设置某列图标
 */
- (NSString *)menu:(YHDropDownMenu *)menu ImageNameOfRowsInColumn:(NSInteger)column;
@end

#pragma mark - delegate
@protocol YHDropDownMenuDelegate <NSObject>
@optional

/**
 * 选中某行回调
 */
- (void)menu:(YHDropDownMenu *)menu didSelectRowAtIndexPath:(YHIndexPath *)indexPath;
@end

#pragma mark - interface
@interface YHDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <YHDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <YHDropDownMenuDelegate> delegate;

/**
 * 文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 * 下划线颜色
 */
@property (nonatomic, strong) UIColor *separatorColor;

/**
 * 背景颜色
 */
@property (nonatomic, strong) UIColor *menuBgColor;

/**
 * 选中时的颜色
 */
@property (nonatomic, strong) UIColor *selectMenuBgColor;

/**
 *  下拉菜单的宽默认为屏幕的宽
 *
 *  @param origin 菜单的View的frame.origin
 *  @param height 菜单的高
 *  @return menu  返回对象本身
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;

/**
 * 获得indexPath下的title
 */
- (NSString *)titleForRowAtIndexPath:(YHIndexPath *)indexPath;

@end
