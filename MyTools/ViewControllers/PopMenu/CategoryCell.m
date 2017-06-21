//
//  CategoryCell.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/20.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell ()
@property (nonatomic, strong) UIView *selectedTag;
@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         // UI
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

- (UIView *)selectedTag {
    if (!_selectedTag) {
        _selectedTag = [[UIView alloc] init];
        
    }
    return _selectedTag;
}

@end
