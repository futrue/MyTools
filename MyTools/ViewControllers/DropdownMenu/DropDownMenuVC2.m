//
//  DropDownMenuVC2.m
//  MyTools
//
//  Created by SGX on 17/1/17.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "DropDownMenuVC2.h"
#import "DropDownListView.h"

@interface DropDownMenuVC2 ()
{
    NSMutableArray *chooseArray; //下拉列表数据源
}

@end

@implementation DropDownMenuVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"下拉列表";
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[@"洛龙区",@"西工区",@"老城区",@"涧西区",@"瀍河回族区",@"吉利区",@"伊滨区"],
                                                   @[@"香蕉",@"葡萄",@"苹果",@"橘子",@"西红柿"],@[@"爸爸",@"妈妈",@"儿子",@"女儿",@"孙子",@"孙女"]
                                                   ]];
    
    DropDownListView *dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 40) dataSource:self delegate:self];
    
    dropDownView.mSuperView = self.view;
    
    [self.view addSubview:dropDownView];
    
}

#pragma mark - dropDownList Delegate

-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"用户选了section:%lu ,index:%lu",section,index);
}


#pragma mark - dropdownList DataSource

-(NSInteger)numberOfSections
{
    return [chooseArray count];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}

-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}

-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

@end
