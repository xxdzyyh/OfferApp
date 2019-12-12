//
//  XFButton.m
//  CTQProject
//
//  Created by wangxuefeng on 16/9/22.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFButton.h"
#import "UIView+Utils.h"

@implementation XFButton

- (void)setText:(NSString *)text {
    _text = text;
    
    [self setTitle:text forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    [self setImage:image forState:UIControlStateNormal];
}


@end
