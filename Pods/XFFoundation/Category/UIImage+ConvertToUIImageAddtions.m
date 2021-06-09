//
//  UIImage+ConvertToUIImageAddtions.m
//  BFMoney
//
//  Created by Liuyu on 15/4/2.
//  Copyright (c) 2015年 xiaoniu88. All rights reserved.
//

#import "UIImage+ConvertToUIImageAddtions.h"

@implementation UIImage (ConvertToUIImageAddtions)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)getImageWithBorderColor:(UIColor *)borderColor defaultColor:(UIColor *)defaultColor roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (borderColor) {
        CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor);
    }
    else {
        if (defaultColor) {
            CGContextSetStrokeColorWithColor(ctx, defaultColor.CGColor);
        }
        else {
            CGContextSetStrokeColorWithColor(ctx, [UIColor clearColor].CGColor);
        }
    }
    CGContextSetLineWidth(ctx, 1);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)getImageWithFillColor:(UIColor *)fillColor defaultColor:(UIColor *)defaultColor roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    if (fillColor) {
        [fillColor setFill];
    }
    else {
        if (defaultColor) {
            [defaultColor setFill];
        }
        else {
            [[UIColor clearColor] setFill];
        }
    }
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
