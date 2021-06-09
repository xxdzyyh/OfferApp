//
//  XFTheme.m
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/9.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import "XFTheme.h"

@implementation XFTheme

SYNTHESIZE_SINGLETON_FOR_CLASS(XFTheme);

- (UIColor *)themeColor {
    if (_themeColor == nil) {
        _themeColor = [UIColor orangeColor];
    }
    return _themeColor;
}  

- (UIColor *)textBlackColor {
    if (_textBlackColor == nil) {
         // 0x999999
        _textBlackColor =  [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    }
    return _textBlackColor;
}

- (UIColor *)textGrayColor {
    if (_textGrayColor == nil) {
        // 0x666666
        _textGrayColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
    }
    return _textGrayColor;
}

- (UIColor *)borderColor {
    if (_borderColor == nil) {
        // 0xe0e0e0
        _borderColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    }
    return _borderColor;
}

- (UIColor *)seperatorColor {
    if (_seperatorColor == nil) {
        // 0xe0e0e0
        _seperatorColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    }
    return _seperatorColor;
}

- (UIColor *)backColor {
    if (_backColor == nil) {
        _backColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    }
    return _backColor;
}

@end
