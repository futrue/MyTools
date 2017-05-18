//
//  GXAlertView.m
//  GXAlertView
//
//  Created by SGX on 16/4/22.
//  Copyright © 2016年 Xing. All rights reserved.
//

#import "GXAlertView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define XRGB(r,g,b) [UIColor colorWithRed:(0x##r)/255.0 green:(0x##g)/255.0 blue:(0x##b)/255.0 alpha:1]
#define XRGBA(r,g,b,a) [UIColor colorWithRed:(0x##r)/255.0 green:(0x##g)/255.0 blue:(0x##b)/255.0 alpha:(a)]

@implementation GXAlertAction

- (id)initWithTitle:(NSString *)title withAction:(AlertActionHandler)action {
    self = [super init];
    if (self) {
        _title = [title copy];
        _handler = [action copy];
    }
    return self;
}

- (void)invoke {
    if (_handler) {
        _handler(self);
    }
}
@end


@implementation GXAlertView

- (void)show {
    if (!_hasInit) {
        
        [self setBackgroundColor: [UIColor whiteColor]];
        [[self layer] setCornerRadius:4.0];
        [[self layer] setShadowColor:[UIColor blackColor].CGColor];
        [[self layer] setShadowOpacity:0.5];
        [[self layer] setShadowRadius:0.5];
        [[self layer] setShadowOffset:CGSizeMake(0, 0)];
        
        if (!_title && !_titleImageName) {
            if (_content) {
                _title = @"提示";
            }
        } else if (_title) {    // title
            _titleLabel = [[UILabel alloc] init];
            [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            [_titleLabel setTextColor:[UIColor darkTextColor]];
            [_titleLabel setText:_title];
            [self addSubview:_titleLabel];
            if (_titleColor) {
                [_titleLabel setTextColor:_titleColor];
            }
        } else if (_titleImageName.length > 0) { // image as title
            UIImage *image = [UIImage imageNamed:_titleImageName];
            _titleImageView = [[UIImageView alloc] initWithImage:image];
            _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_titleImageView];
        }
        
        if (_content) {                                           // normal content
            _contentLabel = [[UILabel alloc] init];
            [_contentLabel setText:_content];
            [_contentLabel setTextAlignment:NSTextAlignmentCenter];
            [_contentLabel setNumberOfLines:0];
            [_contentLabel setFont:[UIFont systemFontOfSize:15]];
            [_contentLabel setTextColor:[UIColor darkGrayColor]];
            [self addSubview:_contentLabel];
        } else if (_attributedContent){                           // attributed content
            _contentLabel = [[UILabel alloc] init];
            [_contentLabel setNumberOfLines:0];
            [_contentLabel setAttributedText:_attributedContent];
            [self addSubview:_contentLabel];
        } else  if (_customContentView) {                         // custom content view
            [self addSubview:_customContentView];
        }
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        if (_cancelText) {
            [_cancelBtn setTitle:_cancelText forState:UIControlStateNormal];
        }
        [_cancelBtn setBackgroundColor: [UIColor whiteColor]];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitleColor:XRGB(ff, 8b, 0f) forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        if (_confirmText) {
            [_cancelBtn setTitle:_cancelText forState:UIControlStateNormal];
        }
        [_confirmBtn setBackgroundColor:[UIColor whiteColor]];
        [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitleColor:XRGB(ff, 8b, 0f) forState:UIControlStateNormal];
        [self addSubview:_confirmBtn];

        if (_btnTextColor) {
            [_cancelBtn setTitleColor:_btnTextColor forState:UIControlStateNormal];
            [_confirmBtn setTitleColor:_btnTextColor forState:UIControlStateNormal];
        }
/*
  ——————————
   ** | **
 */
        UIView *hLine = [[UIView alloc] init];
        [hLine setBackgroundColor: XRGB(f2, f2, f2)];
        [self addSubview:hLine];
        _horizontalLine = hLine;
        
        _verticalLine = [[UIView alloc] init];
        [_verticalLine setBackgroundColor: XRGB(f2, f2, f2)];
        [self addSubview:_verticalLine];

        _hasInit = true;

        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
    _hostView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_hostView addSubview:self];
    [self setCenter:_hostView.center];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_hostView];
    [self setTransform:CGAffineTransformMakeTranslation(0, _hostView.bounds.size.height)];
    [_hostView setBackgroundColor:[UIColor clearColor]];
    [self setAlpha:0];
    _visible = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self setAlpha:1];
        [self setTransform:CGAffineTransformIdentity];
        [_hostView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.333]];
    }];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textMaxWidth = 230;
    CGFloat width = SCREEN_WIDTH/2;
    /*
     *  计算宽度
     */
    CGFloat actualWith = 0.0;
    if (_titleLabel) {
        actualWith = [_titleLabel sizeThatFits:CGSizeMake(textMaxWidth, CGFLOAT_MAX)].width+30;
    } else if (_titleImageView) {
        actualWith = _titleImageView.frame.size.width;
    }
    
    if (_customContentView) {
        actualWith = _customContentView.bounds.size.width;
    }else if(_contentLabel ){
        actualWith = [_contentLabel sizeThatFits:CGSizeMake(textMaxWidth, CGFLOAT_MAX)].width+40;
    }
    width = MAX(width, actualWith);
    
   //- - - - - -^^^^^^- - - - -\\

    width = MIN(width, SCREEN_WIDTH*0.8);
    /*
     *  计算高度
     */
    CGFloat height = 20;
    if (_titleLabel) {
        [_titleLabel setFrame:CGRectMake(15, 15, width-30, 20)];
        height += CGRectGetMaxY(_titleLabel.frame) ;
    } else if (_titleImageView) {
        [_titleImageView setFrame:CGRectMake((width - _titleImageView.bounds.size.width) / 2, height, _titleImageView.bounds.size.width, _titleImageView.bounds.size.height)];
        height += CGRectGetHeight(_titleImageView.frame) + 15;
    }
    
    if (_customContentView) {
        [_customContentView setFrame:CGRectMake((width-_customContentView.bounds.size.width)/2, height, _customContentView.bounds.size.width, _customContentView.bounds.size.height)];
        height = CGRectGetMaxY(_customContentView.frame) + 15;
    }else if(_contentLabel){
        [_contentLabel setFrame:CGRectMake(0, 0, width-40, CGFLOAT_MAX) ];
        [_contentLabel sizeToFit];
        [_contentLabel setFrame:CGRectMake(20, height, width-40, _contentLabel.bounds.size.height+15)];
        height = CGRectGetMaxY(_contentLabel.frame) + 15;
    }
    
    if (_buttonArr) {
        for (UIButton *btn in _buttonArr) {
            [btn setFrame:CGRectMake(4, height, width-8, 44)];
            height += 44;
        }
    }
    
    if (_hideConfirm) {
        [_cancelBtn setFrame:CGRectMake(4, height, width-8, 44)];
        [_confirmBtn setHidden:YES];
        [_horizontalLine setHidden:YES];
    }else{
        [_cancelBtn setFrame:CGRectMake(4, height, width/2-4, 44)];
        [_confirmBtn setFrame:CGRectMake(width/2, height, width/2-4, 44)];
        [_horizontalLine setHidden:NO];
        [_confirmBtn setHidden:NO];
    }
    
    if (_verticalLine) {
        [_verticalLine setFrame:CGRectMake(0, height, width, 1)];
    }
    if (_horizontalLine) {
        [_horizontalLine setFrame:CGRectMake(CGRectGetMaxX(_cancelBtn.bounds), height, 0.5, 44)];
    }
    
    // 最后课件的 self 的 frame
    [self setFrame:CGRectMake(0, 0, width, height+44)];
}

#pragma mark - cancel
- (void)dismiss {
    [self viewDismiss];
    if (_alertDelegate) {
        [_alertDelegate alert:self dismissBy:AlertCancelled];
    }
}

#pragma mark - confirm
- (void)confirm {
    [self viewDismiss];
    if (_alertDelegate) {
        [_alertDelegate alert:self dismissBy:AlertConfirmed];
    }
}

// remove self
- (void)viewDismiss {
    [UIView animateWithDuration:0.25 animations:^{
        [self setTransform:CGAffineTransformMakeTranslation(0, _hostView.bounds.size.height)];
        [self setAlpha:0];
        [_hostView setBackgroundColor: [UIColor clearColor]];
    } completion:^(BOOL finished) {
        _visible = NO;
        [_hostView removeFromSuperview];
    }];
//    for (UIButton *btn in _buttonArr) {
//        NSInteger indedx = [_buttonArr indexOfObject:btn];
//        if (indedx != NSNotFound) {
//            GXAlertAction *action = [_buttonActions objectAtIndex:indedx];
//            [action invoke];
//        }
//    }
}

















@end
