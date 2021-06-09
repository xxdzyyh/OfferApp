//
//  XFTheme.h
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/9.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ThemeColor     [[XFTheme sharedXFTheme] themeColor]
#define TextBlackColor [[XFTheme sharedXFTheme] textBlackColor]
#define TextGrayColor  [[XFTheme sharedXFTheme] textGrayColor]
#define BorderColor    [[XFTheme sharedXFTheme] borderColor]
#define SeperatorColor [[XFTheme sharedXFTheme] seperatorColor]

#import "SynthesizeSingleton.h"

@interface XFTheme : NSObject

DECLARE_SINGLETON_FOR_CLASS(XFTheme);

/** 主题颜色*/
@property (strong, nonatomic) UIColor *themeColor;
/** 文字颜色-黑 */
@property (strong, nonatomic) UIColor *textBlackColor;
/** 文字颜色-灰 */
@property (strong, nonatomic) UIColor *textGrayColor;
/** 边框颜色*/
@property (strong, nonatomic) UIColor *borderColor;
/** 分割线颜色*/
@property (strong, nonatomic) UIColor *seperatorColor;
/** 背景颜色*/
@property (strong, nonatomic) UIColor *backColor;

@property (assign, nonatomic) NSInteger mainFontSize;

@property (assign, nonatomic) NSInteger subFontSize;


@end
