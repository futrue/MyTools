//
//  GXCustomButton.h
//  GXCustomButton
//
//  Created by SGX on 16/10/20.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ImageAlignmentType) {
    ImageAlignmentTypeLeft = 0,  // image left and title right (system)
    ImageAlignmentTypeRight,     // image right and title left
    ImageAlignmentTypeUp,        // image up and title down
    ImageAlignmentTypeDown       // image down and title up
};

@interface GXCustomButton : UIButton

/**
 * distance between image and title, default is 5
 */
@property (nonatomic) CGFloat imageTextDistance;

/**
 * imageView cornerRadius only
 */
@property (nonatomic) CGFloat imageCornerRadius;

/**
 * image and titleLabel layout type, default is the system
 */
@property (nonatomic, assign) ImageAlignmentType imageAlignmentType;

/**
 init method

 @param imageName  the name of the image
 @param title      text of titleLabel
 @param type       imageView and titleLabel layout type
 @return the custom button
 */
- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title imageAlignmentType:(ImageAlignmentType)type;\

/**
 <#Description#>

 @param type <#type description#>

 @return <#return value description#>
 */
- (instancetype)initWithAlignmentType:(ImageAlignmentType)type;
@end
