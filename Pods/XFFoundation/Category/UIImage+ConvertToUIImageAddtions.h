//
//  UIImage+ConvertToUIImageAddtions.h
//  BFMoney
//
//  Created by Liuyu on 15/4/2.
//  Copyright (c) 2015年 xiaoniu88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ConvertToUIImageAddtions)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithView:(UIView *)view;
+ (UIImage *)getImageWithBorderColor:(UIColor *)borderColor defaultColor:(UIColor *)defaultColor roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius;
+ (UIImage *)getImageWithFillColor:(UIColor *)fillColor defaultColor:(UIColor *)defaultColor roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius;


@end
