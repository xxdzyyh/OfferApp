//
//  XFHSwipeViewController.h
//  XFHSwipe
//
//  Created by wangxuefeng on 16/7/30.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTopTabBar.h"
#import "XFViewController.h"

@class XFHSwipeViewController;

@protocol XFHSwipeViewControllerDataSource <NSObject>

/**
 *  需要切换的viewController
 *
 *  @param swipe 需要在哪个swipe view controller上显示
 *
 *  @return <#return value description#>
 */
- (NSArray *)viewControllersInSwipeView:(XFHSwipeViewController *)swipe;

/**
 *  topbar需要显示的title
 *
 *  @param swipe topbar所属的swipeViewController
 *
 *  @return <#return value description#>
 */
- (NSArray *)titlesInSwipeView:(XFHSwipeViewController *)swipe;

@end

@protocol XFHSwipeViewControllerDelegate <NSObject>

@optional 
/*! 默认为45 */
- (float)heightForTopbarInSwipeView:(XFHSwipeViewController *)swipe;

/*! 默认为2  */
- (float)heightForTopbarIndictorInSwipeView:(XFHSwipeViewController *)swipe;

@end

@interface XFHSwipeViewController : XFViewController<XFTopTabBarDelegate>

@property (strong, nonatomic) XFTopTabBar *topbar;

@property (weak, nonatomic) id<XFHSwipeViewControllerDataSource> dataSource;

@property (weak, nonatomic) id<XFHSwipeViewControllerDelegate> delegate;

@end
