//
//  JXCardViewController.h
//  SMScrollView
//
//  Created by mc008 on 16/1/27.
//  Copyright © 2016年 wxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFCardViewController;

@protocol XFCardViewControllerDelegate <NSObject>

- (NSArray *)viewControllersForCardViewController;

- (void)didSelectedViewControllerAtIndex:(NSUInteger)index;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface XFCardViewController : UIViewController

@property (strong, nonatomic) UIScrollView * scrollView;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<XFCardViewControllerDelegate>)delegate;

@property (weak, nonatomic) id<XFCardViewControllerDelegate> delegate;

- (void)selectedViewControllerAtIndex:(NSInteger)index;

@end
