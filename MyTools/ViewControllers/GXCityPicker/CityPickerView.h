//
//  CityPickerView.h
//  CityPicker
//
//  Created by SGX on 16/5/9.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityPickerView;
@protocol  CityPickerViewDelegate<NSObject>

- (void)selectedCity:(NSString *)city;

@end

@interface CityPickerView : UIView

@property (nonatomic, weak) id <CityPickerViewDelegate>delegate;

@end
