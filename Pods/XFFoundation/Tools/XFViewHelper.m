//
//  XFViewHelper.m
//  Tao
//
//  Created by xiaoniu on 2019/7/16.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import "XFViewHelper.h"

@implementation XFViewHelper

+ (UIWindow *)keyWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        if ([windows count] > 0) {
            window = windows[0];
        }
    }
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    return window;
}

+ (UIImage *)capture:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
