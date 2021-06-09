//
//  XFMarco.h
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/12.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#ifndef XFMarco_h
#define XFMarco_h

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#define XFUserDefaults [NSUserDefaults standardUserDefaults]
#define XFScreenSize  [UIScreen mainScreen].bounds.size

#define UIColorFromRGBA(rgbValue, iAlpha)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:iAlpha]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0f)



#endif /* XFMarco_h */
