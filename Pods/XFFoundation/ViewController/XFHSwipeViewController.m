//
//  XFHSwipeViewController.m
//  XFHSwipe
//
//  Created by wangxuefeng on 16/7/30.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFHSwipeViewController.h"
#import "XFTopTabBar.h"
#import "XFCardViewController.h"
#import "UIView+Utils.h"
#import "View+MASShorthandAdditions.h"

@interface XFHSwipeViewController () <XFCardViewControllerDelegate>

@property (strong, nonatomic) NSArray *topbarTitles;

@property (strong, nonatomic) XFCardViewController *cardVC;

@property (strong, nonatomic) NSArray *contentViewControllers;

@property (assign, nonatomic) float topBarHeight;

@end

@implementation XFHSwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.topbar];
    [self.view addSubview:self.cardVC.view];
    
    self.topbar.backgroundColor = [UIColor whiteColor];
    
    [self.topbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(self.topBarHeight);
    }];
    
    [self.cardVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topbar.mas_bottom);
        make.left.right.and.bottom.equalTo(self.view);
    }];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}

#pragma mark - XFTopTabBarDelegate

- (NSArray *)titlesForTopTabbar:(XFTopTabBar *)topTabBar {
    return self.topbarTitles;
}

- (void)topTabbar:(XFTopTabBar *)topTabBar didSelectedItemAtIndex:(NSInteger)index {
    
    [self.cardVC selectedViewControllerAtIndex:index];
}

#pragma mark - JXCardViewControllerDelegate

- (NSArray *)viewControllersForCardViewController {
    return self.contentViewControllers;
}

// 等价scrollViewDidEndDecelerating
- (void)didSelectedViewControllerAtIndex:(NSUInteger)index {
    
    [self.topbar updateToSelectedStatus:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    float x = scrollView.contentOffset.x;
    
    if (_topbar.titles.count == 0) {
        return;
    }
    
    if ((int)x%(int)self.topbar.width == 0) {
        return;
    }
    
    // 计算每个topBar Item 的宽度。
    float w = _topbar.width/_topbar.titles.count;
    
    if (_topbar.selectedIndex == 0) {
        // 0 - 320
        [_topbar setIndicatorCenterX:x/_topbar.width*w+w/2];
    } else if (_topbar.selectedIndex == _topbar.titles.count-1) {
        // 320 - 0
        
        // 需要移动的距离
        float distance = (_topbar.width-x)/_topbar.width*w;
        
        [_topbar setIndicatorCenterX:self.topbar.width-w/2-distance];
    } else {
    
        float currentX = _topbar.selectedIndex*w+w/2;
        // 需要移动的距离
        float distance = (x-_topbar.width)/_topbar.width*w+currentX;
        
        [_topbar setIndicatorCenterX:distance];
    }
}

#pragma mark - UIScrollViewDelegate

#pragma mark - setter & getter

- (XFTopTabBar *)topbar {
    if (_topbar == nil) {
        float w = [UIScreen mainScreen].bounds.size.width;
        
        _topbar = [[XFTopTabBar alloc] initWithFrame:CGRectMake(0, 0, w, 45)];
    }
    return _topbar;
}

- (XFCardViewController *)cardVC {
    if (_cardVC == nil) {
        CGRect rect = CGRectMake(0, self.topBarHeight, self.view.width, self.view.height - self.topBarHeight);
        
        _cardVC = [[XFCardViewController alloc] initWithFrame:rect delegate:self];
        
        [self addChildViewController:_cardVC];
    }
    return _cardVC;
}

- (NSArray *)contentViewControllers {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(viewControllersInSwipeView:)]) {
        _contentViewControllers = [self.dataSource viewControllersInSwipeView:self];
    }
    
    return _contentViewControllers;
}

- (NSArray *)topbarTitles {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesInSwipeView:)]) {
        _topbarTitles = [self.dataSource titlesInSwipeView:self];
    }
    
    return _topbarTitles;
}

- (float)topBarHeight {
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForTopbarInSwipeView:)]) {
        return [self.delegate heightForTopbarInSwipeView:self];
    } else {
        return 45;
    }
}

@end
