//
//  XFNavigationController.h
//  CTQProject
//
//  Created byhuang on 16/3/15.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFNavigationController : UINavigationController

/**
 *  如果仅仅希望接管导航栏返回事件，而不自己定义back item，viewController可以自己实现
 *  onCustomBackItemClicked：
 *
 *  XFNavigationController会优先调用viewController的onCustomBackItemClicked:，否则调用
 *  自己的onCustomBackItemClicked:
 */
//- (void)onCustomBackItemClicked:(id)sender;

@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *barBackColor;

+ (UIImage*)createImageWithColor:(UIColor*) color;


@end
