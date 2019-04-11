//
//  XFLoopView.m
//  LoopView
//
//  Created by wangxuefeng on 2017/11/28.
//  Copyright © 2017年 wangxuefeng. All rights reserved.
//

#import "XFLoopView.h"

typedef NS_ENUM(NSUInteger,XFDirection) {
    XFDirectionNone,
    XFDirectionLeft,
    XFDirectionRight
};

@interface XFLoopView() <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIView *currentView;
@property (strong, nonatomic) UIView *nextView;

@property (nonatomic, assign) XFDirection direction;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger nextIndex;

// 定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XFLoopView

#pragma mark - control

- (void)setDataSource:(NSMutableArray<__kindof UIView *> *)dataSource {
    _dataSource = dataSource;
    
    if (_dataSource.count == 0) {
        [self clear];
    } else {
        [self reloadData];
    }
}

- (void)reloadData {
    [self.currentView addSubview:_dataSource.firstObject];
    self.currentIndex = 0;
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = _dataSource.count;
    
    if (_dataSource.count > 1) {
        self.scrollView.contentSize = CGSizeMake([self width] * 3, 0);
        [self startTimer];
    } else {
        self.scrollView.contentSize = CGSizeZero;
    }
}

- (void)clear {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [_dataSource removeAllObjects];
    
    [_currentView.subviews.firstObject removeFromSuperview];
    [_nextView.subviews.firstObject removeFromSuperview];
}

#pragma mark - core

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.scrollView.frame = self.bounds;
    self.pageControl.center = CGPointMake([self width] * 0.5, [self height] - 6);
    
    _scrollView.contentOffset = CGPointMake(self.width, 0);
    _currentView.frame = CGRectMake([self width], 0, [self width], [self height]);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.contentInset = UIEdgeInsetsZero;
    
    if (_currentView) {
        _currentView.frame = CGRectMake([self width], 0, [self width], [self height]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offX = scrollView.contentOffset.x;
    self.direction = offX > [self width] ? XFDirectionLeft : (offX < [self width] ? XFDirectionRight : XFDirectionNone);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)pauseScroll {
    if (_dataSource.count == 0) {
        return;
    }

    // 等于1表示没有滚动
    if (self.scrollView.contentOffset.x / [self width] == 1) return;
    
    self.currentIndex = self.nextIndex;
    self.pageControl.currentPage = self.currentIndex;
    self.currentView.frame = CGRectMake([self width], 0, [self width], [self height]);

    UIView *view = self.dataSource[_currentIndex];
    
    view.frame = self.currentView.bounds;
    
    [self.currentView addSubview:view];
    
    self.scrollView.contentOffset = CGPointMake([self width], 0);
}

- (void)setDirection:(XFDirection)direction {
    if (_direction == direction) {
        return;
    }
    
    _direction = direction;
    
    if (_direction == XFDirectionNone) {
        return;
    }
    
    if (_dataSource.count == 0) {
        return;
    }
    
    if (_direction == XFDirectionRight) {
        // 如果是向右滚动
        self.nextView.frame = CGRectMake(0, 0, self.width, self.height);
        self.nextIndex = self.currentIndex - 1;
        
        if (self.nextIndex < 0) {
            self.nextIndex = _dataSource.count - 1;
        }
    } else if (_direction == XFDirectionLeft) {
        // 如果是向左边滚动
        self.nextView.frame = CGRectMake(CGRectGetMaxX(_currentView.frame), 0, self.width, self.height);
        self.nextIndex = (self.currentIndex + 1) % _dataSource.count;
    }
    
    UIView *view = self.dataSource[_nextIndex];
    
    view.frame = self.nextView.bounds;
    
    [self.nextView addSubview:view];
    
    if (self.dataSource.count <= 1) {
        [self pauseScroll];
    }
}

#pragma mark - timer

// 关闭定时器
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)startTimer {
    // 如果定时器已经开启，则先停止再开启
    if (_timer) {
        [self stopTimer];
    }
    
    // 如果只有一张，直接放回，不需要开启定时器
    if (_dataSource.count <= 1) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval < 1 ? 5 : _timeInterval
                                                  target:self
                                                selector:@selector(nextPage)
                                                userInfo:nil
                                                 repeats:YES];
}

// 下一页
- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
    [self setNeedsLayout];
}

#pragma mark - helper

- (CGFloat)height {
    return self.scrollView.bounds.size.height;
}

- (CGFloat)width {
    return self.scrollView.bounds.size.width;
}

#pragma mark - getter & setter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        _currentView = [[UIView alloc] init];

        [_scrollView addSubview:_currentView];
        
        _nextView = [[UIView alloc] init];
        
        [_scrollView addSubview:_nextView];
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

@end
