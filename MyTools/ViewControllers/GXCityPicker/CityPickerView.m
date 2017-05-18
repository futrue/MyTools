//
//  CityPickerView.m
//  CityPicker
//
//  Created by SGX on 16/5/9.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "CityPickerView.h"

@interface CityPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *pickerDic;
@property (nonatomic, strong) NSArray *provinceArr;
@property (nonatomic, strong) NSArray *cityArr;
@property (nonatomic, strong) NSArray *townArr;
@property (nonatomic, strong) NSArray *selectedArr;

@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation CityPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initData];
        [self initView];
    }
    return self;
}

- (void)initView {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 35)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    [self addSubview:_pickerView];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame = CGRectMake(0, CGRectGetMaxY(_pickerView.frame), self.bounds.size.width, 40);
    [chooseBtn setTitle:@"OK" forState:UIControlStateNormal];
    chooseBtn.backgroundColor = [UIColor redColor];
    [chooseBtn addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chooseBtn];
}

- (void)initData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    self.provinceArr = [self.pickerDic allKeys];
    // 默认选项
    self.selectedArr = [self.pickerDic objectForKey:[self.pickerDic allKeys][0]];
    if (self.provinceArr.count > 0) {
        self.cityArr = [self.selectedArr[0] allKeys];
    }
    if (self.cityArr.count > 0) {
        self.townArr = [self.selectedArr[0] objectForKey:self.cityArr[0]];
    }
                        
}

- (void)choose {
    NSString *City = [NSString stringWithFormat:@"%@%@%@",[self.provinceArr objectAtIndex:[self.pickerView selectedRowInComponent:0]],[self.cityArr objectAtIndex:[self.pickerView selectedRowInComponent:1]],[self.townArr objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
    if (self.delegate) {
        [self.delegate selectedCity:City];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArr.count;
    } else if (component == 1) {
        return self.cityArr.count;
    } else {
        return self.townArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return  self.provinceArr[row];
    } else if (component == 1) {
        return  self.cityArr[row];
    } else {
        return  self.townArr[row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return  80;
    } else if (component == 1) {
        return  self.bounds.size.width - 180;
    } else {
        return  90;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArr = [self.pickerDic objectForKey:self.provinceArr[row]];
        if (self.selectedArr.count > 0) {
            self.cityArr = [self.selectedArr[0] allKeys];
        }
        if (self.cityArr.count > 0) {
            self.townArr = [self.selectedArr[0] objectForKey:self.cityArr[0]];
        }
    }
    
//    [pickerView selectedRowInComponent:1];
//    [pickerView reloadComponent:1];
//    [pickerView selectedRowInComponent:2];
    if (component == 1) {
        if (self.selectedArr.count > 0 && self.cityArr.count > 0) {
            self.townArr = [self.selectedArr[0] objectForKey:self.cityArr[row]];
            [pickerView selectRow:1 inComponent:2 animated:YES];
        }
    }
//    [pickerView reloadComponent:2];
    [pickerView reloadAllComponents];
}







@end
