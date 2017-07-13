//
//  DropDownMenuVC2.m
//  MyTools
//
//  Created by SGX on 17/1/17.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "DropDownMenuVC2.h"
#import "DropDownListView.h"

@interface DropDownMenuVC2 ()<DropDownListDelegate,DropDownListDataSource>
@property (nonatomic, strong) DropDownListView *listView;
@property (nonatomic, strong) UIStackView *sectionView;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UIImageView *indicator;
@property (nonatomic, strong) UILabel *secTitle;
@end

@implementation DropDownMenuVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"drop down";
    self.type = 1;
    [self.view addSubview:self.sectionView];
    
    [self.view addSubview:self.listView];
    [_listView setDefaultShowSection:1];
    
}

- (NSArray *)array {
    return  @[@[@"洛龙区",@"西工区",@"老城区",@"涧西区",@"瀍河回族区",@"吉利区",@"伊滨区"],
              @[@"香蕉",@"葡萄",@"苹果",@"橘子",@"西红柿"],
              @[@"爸爸",@"妈妈",@"儿子",@"女儿",@"孙子",@"孙女"]
              ];
}
- (DropDownListView *)listView {
    if (!_listView) {
        DropDownListView *listView = [[DropDownListView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, 40)];
        listView.backgroundColor = [UIColor lightGrayColor];
        [listView setDelegate:self dataSource:self];
        _listView = listView;
    }
    return _listView;
}

- (void)didSelectedSection:(NSInteger)section index:(NSInteger)index {
    NSLog(@"用户选了section:%lu ,index:%lu",section,index);
}

- (NSInteger)numberOfSections {
    return [[self array] count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [[self array][section] count];
}

- (NSString *)titleForSection:(NSInteger)section index:(NSInteger)index {
    return [self array][section][index];
}

- (UIStackView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[UIStackView alloc] initWithFrame:CGRectMake(10, 65, 300, 40)];
        _sectionView.backgroundColor = [UIColor orangeColor];
        _sectionView.axis = UILayoutConstraintAxisHorizontal;
        _sectionView.distribution = UIStackViewDistributionFillEqually;
        _sectionView.spacing = 1;
        _sectionView.alignment= UIStackViewAlignmentFill;
        
        for (int i = 0; i < 3; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            view.tag = i;
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
            view.backgroundColor = [UIColor lightGrayColor];
            NSString *sectionBtnTitle = @"title";
            UILabel *label = [[UILabel alloc] init];
            label.tag = 100 + i;
            label.text =sectionBtnTitle;
            [label sizeToFit];
            self.secTitle = label;
            [view addSubview:label];
            
            UIImage *img = [UIImage imageNamed:@"down_dark.png"];
            UIImageView *sectionIndicator = [[UIImageView alloc] initWithImage:img];
            sectionIndicator.tag = 200 + i;
            [sectionIndicator setContentMode:UIViewContentModeScaleToFill];
            [view addSubview:sectionIndicator];
            self.indicator = sectionIndicator;
            [self install];
            [_sectionView addArrangedSubview:view];
        }
    }
    return _sectionView;
}

- (void)clicked:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    UIImageView *indicator = (UIImageView *)[self.sectionView viewWithTag:200 + index];
    [UIView animateWithDuration:0.25 animations:^{
        indicator.transform = CGAffineTransformRotate(indicator.transform, ((180)/180.0 *M_PI));
    }];
}

- (void)install {
    CGSize imgSize = self.indicator.image.size;
    
    if (self.type) {
        [self.secTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.secTitle.superview);
            make.leading.mas_equalTo(5);
        }];
        
        [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.secTitle.superview);
            make.trailing.mas_equalTo(-5);
        }];
    } else {
        CGFloat x = (self.secTitle.superview.bounds.size.width - imgSize.width - 5 - self.secTitle.bounds.size.width) / 2;
        [self.secTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.secTitle.superview);
            make.leading.mas_equalTo(x);
        }];
        
        [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.secTitle.superview);
            make.leading.equalTo(self.secTitle.mas_trailing).offset(5);
        }];
    }
}

@end
