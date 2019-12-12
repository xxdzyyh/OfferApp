//
//  XFViewHelper.h
//  Tao
//
//  Created by xiaoniu on 2019/7/16.
//  Copyright © 2019 App4life Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XFViewHelper : NSObject

+ (UIWindow *)keyWindow;
+ (UIImage *)capture:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
