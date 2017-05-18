//
//  CityPickerVC.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CityPickerVC.h"
#import "CityPickerView.h"

@interface CityPickerVC ()<CityPickerViewDelegate>
@property (nonatomic, strong) CityPickerView *pickerView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation CityPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 44)];
    label.backgroundColor = [UIColor grayColor];
    label.textAlignment = 1;
    self.label = label;
    [self.view addSubview:label];
    
    
    _pickerView = [[CityPickerView alloc] initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width, 200)];
    _pickerView.delegate = self;
    _pickerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [self.view addSubview:_pickerView];
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
}

- (void)selectedCity:(NSString *)city {
    self.label.text = city;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
