//
//  DropDownListView.m
//  DropDownList_test
//
//  Created by SGX on 17/2/6.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "DropDownListView.h"
// 角度转换弧度
//#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
// 弧度转换角度
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000

static NSTimeInterval animationDuration = 0.25;
static NSInteger rowInSection;

@interface DropDownListView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _sectionNum;
}
@property (nonatomic, weak) id<DropDownListDelegate> dropDownListDelegate;
@property (nonatomic, weak) id<DropDownListDataSource> dropDownListDataSource;
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;

@property (nonatomic, assign) NSInteger currentExtendedSection;
@end

@implementation DropDownListView

- (void)setDelegate:(id<DropDownListDelegate>)delegate dataSource:(id<DropDownListDataSource>)dataSource {
    self.dropDownListDelegate = delegate;
    self.dropDownListDataSource = dataSource;
    [self setupUI];
}

- (void)setTitle:(NSString *)title inSection:(NSInteger)section {
    UIButton *btn = (id)[self viewWithTag:SECTION_BTN_TAG_BEGIN +section];
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.currentExtendedSection = -1;
    _sectionNum = 1;// 默认是1
    if ([self.dropDownListDataSource respondsToSelector:@selector(numberOfSections)]) {
       _sectionNum = [self.dropDownListDataSource numberOfSections];
    }
    CGSize size = self.frame.size;
    CGFloat sectionWidth = size.width / _sectionNum;
    for (int i = 0; i < _sectionNum; i++) {
        UIButton *sectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth * i, 1, sectionWidth, size.height - 2)];
        sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
        NSString *sectionBtnTitle = @"title";
        if ([self.dropDownListDataSource respondsToSelector:@selector(titleForSection:index:)]) {
            sectionBtnTitle = [self.dropDownListDataSource titleForSection:i index:0];
        }
        [sectionBtn setTitle:sectionBtnTitle forState:UIControlStateNormal];
        [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sectionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sectionBtn addTarget:self action:@selector(sectionBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sectionBtn];
        
        UIImage *img = [UIImage imageNamed:@"down_dark.png"];
        UIImageView *sectionIndicator = [[UIImageView alloc] initWithImage:img];
        [sectionIndicator setContentMode:UIViewContentModeScaleToFill];
        sectionIndicator.tag = SECTION_IV_TAG_BEGIN + i;
        CGSize imgSize = img.size;
        sectionIndicator.frame = CGRectMake(sectionWidth * i + (sectionWidth - imgSize.width - 4), (size.height - imgSize.height) / 2, imgSize.width, imgSize.height);
        [self addSubview:sectionIndicator];
        
        if (i < _sectionNum && i > 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(sectionWidth * i, size.height / 4, 1, size.height / 2)];
            lineView.backgroundColor = [UIColor redColor];
            [self addSubview:lineView];
        }
    }
}

- (void)setAlignmentType:(AlignmentType)alignmentType {
    _alignmentType = alignmentType;
    if (alignmentType) {

    } else {
        
    }
}

- (void)setDefaultShowSection:(NSInteger)defaultShowSection {
    _defaultShowSection = defaultShowSection;
    // 自动展示的section满足条件
    if (_sectionNum != 0 && defaultShowSection >= 0 && defaultShowSection <= _sectionNum) {
        self.currentExtendedSection = defaultShowSection;
        [self _indicatorRotate];
        [self extendView];
    }
}

// 点击某个选项
- (void)sectionBtnTouched:(UIButton *)sender {
    NSInteger section = sender.tag - SECTION_BTN_TAG_BEGIN;
    [self _indicatorRotate];
    if (self.currentExtendedSection == section) {
        [self hideExtendedView];
    } else {
        self.currentExtendedSection = section;
        [self _indicatorRotate];
        [self extendView];
    }
}

// 图标转180°
- (void)_indicatorRotate {
    UIImageView *indicator = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + self.currentExtendedSection];
    [UIView animateWithDuration:0.25 animations:^{
        indicator.transform = CGAffineTransformRotate(indicator.transform, DEGREES_TO_RADIANS(180));
    }];
}

// 收起
- (void)hideExtendedView {
    if (self.currentExtendedSection != -1) {
        self.currentExtendedSection = -1;
        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:animationDuration animations:^{
            self.mTableBaseView.alpha = 1.0;
            self.mTableView.alpha = 1.0;

            self.mTableBaseView.alpha = 0.2;
            self.mTableView.alpha = 0.2;
            self.mTableView.frame = rect;
        } completion:^(BOOL finished) {
            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
}

// 展开
- (void)extendView {
    CGFloat sectionWidth = self.frame.size.width / _sectionNum;
    CGRect rect = self.mTableView.frame;
    rect.origin.x = sectionWidth * self.currentExtendedSection;
    rect.size.width = sectionWidth;
    rect.size.height = 0;
    self.mTableView.frame = rect;
//    [self.superview addSubview:self.mTableBaseView];
//    [self.superview addSubview:self.mTableView];

    if ([self.dropDownListDataSource respondsToSelector:@selector(numberOfRowsInSection:)]) {
       rowInSection = [self.dropDownListDataSource numberOfRowsInSection:self.currentExtendedSection];
    }
    
    rect.size.height = 45 * rowInSection;
    [UIView animateWithDuration:animationDuration animations:^{
        self.mTableBaseView.alpha = 0.2;
        self.mTableView.alpha = 0.2;
        
        self.mTableBaseView.alpha = 1.0;
        self.mTableView.alpha = 1.0;
        self.mTableView.frame =  rect;
    } completion:^(BOOL finished) {
        // 解决在隐藏动画过程中再次快速点击而不出现展开选择项的效果
        [self.superview addSubview:self.mTableBaseView];
        [self.superview addSubview:self.mTableView];
    }];
    [self.mTableView reloadData];
}

// 点击背景
- (void)bgTappedAction {
    [self _indicatorRotate];
    [self hideExtendedView];
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dropDownListDataSource numberOfRowsInSection:self.currentExtendedSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = [self.dropDownListDataSource titleForSection:self.currentExtendedSection index:indexPath.row];
    
    return cell;
}

//解决iOS7、8中tableView分割线缺少15像素（需要和上面一起使用才能达到效果）
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dropDownListDelegate respondsToSelector:@selector(didSelectedSection:index:)]) {
        NSString *selectedTitle = [self.dropDownListDataSource titleForSection:self.currentExtendedSection index:indexPath.row];
        UIButton *currentSectionBtn = [self viewWithTag:SECTION_BTN_TAG_BEGIN + self.currentExtendedSection];
        [currentSectionBtn setTitle:selectedTitle forState:UIControlStateNormal];
        [self.dropDownListDelegate didSelectedSection:self.currentExtendedSection index:indexPath.row
         ];
        [self hideExtendedView];
    }
}

- (UITableView *)mTableView {
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] init];
        _mTableView.rowHeight = 45.f;
        _mTableView.frame = CGRectMake(self.frame.origin.x, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), 300);
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        
        if ([_mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_mTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_mTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _mTableView;
}

- (UIView *)mTableBaseView {
    if (!_mTableBaseView) {
        _mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.superview.frame) - CGRectGetMaxY(self.frame))];
        _mTableBaseView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction)];
        [_mTableBaseView addGestureRecognizer:bgTap];
    }
    return _mTableBaseView;
}

@end
