//
//  XFExcelViewTitleCell.m
//  CTQProject
//
//  Created by wangxuefeng on 16/6/16.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFExcelViewTitleCell.h"

@interface XFExcelViewTitleCell ()

@end


@implementation XFExcelViewTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setupWithStyle:(XFExcelViewTitleCellStyle)style {
    switch (style) {
        case XFExcelViewTitleCellStyleDefault:
            [self setupDefaultStyle];
            break;
        default:
            break;
    }
}

- (void)setupDefaultStyle {
    _lblTitle = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    
    _lblTitle.font = [UIFont systemFontOfSize:15];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.textColor = [UIColor colorWithRed:0.529 green:0.588 blue:0.647 alpha:1.00];
    
    [self.contentView addSubview:_lblTitle];
}

#pragma mark - setter & getter

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.lblTitle.text = title;
}

- (void)setTitleStyle:(XFExcelViewTitleCellStyle)titleStyle {
    _titleStyle = titleStyle;
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
    
    [self setupWithStyle:titleStyle];
}

@end
