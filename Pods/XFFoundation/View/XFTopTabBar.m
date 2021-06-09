//
//  XFTopTabBar.m
//  CTQProject
//
//  Created by wangxuefeng on 16/6/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFTopTabBar.h"

@interface XFTopTabBar () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *itemsContainer;
@property (strong, nonatomic) UIView *indicatorView;
@property (assign, nonatomic) UIButton *currentBtn;

@end

@implementation XFTopTabBar

- (void)setup {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesForTopTabbar:)]) {
        self.titles = [self.delegate titlesForTopTabbar:self];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(attributeTitlesForTopbar:)]) {
        self.titles = [self.delegate attributeTitlesForTopbar:self];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i=0; i<self.titles.count; i++) {
        id title = self.titles[i];
        
        float w = [self w]/self.titles.count;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = i;
        btn.frame = CGRectMake(w*i, 0, w, self.itemsContainer.bounds.size.height);
        btn.titleLabel.font = self.normalStateFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [btn setTitleColor:self.normalStateColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedStateColor forState:UIControlStateSelected];
        
        if ([title isKindOfClass:[NSMutableAttributedString class]]) {
            
            NSMutableAttributedString * s = (NSMutableAttributedString *)title;
            
            [s addAttribute:NSForegroundColorAttributeName value:self.normalStateColor range:NSMakeRange(0, s.length)];
            
            [btn setAttributedTitle:s forState:UIControlStateNormal];
            
            NSMutableAttributedString *s1 = [s mutableCopy];
            
            [s1 addAttribute:NSForegroundColorAttributeName value:self.selectedStateColor range:NSMakeRange(0, s1.length)];
            
            [btn setAttributedTitle:s1 forState:UIControlStateSelected];
        } else {
            [btn setTitle:title forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(onItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [array addObject:btn];
        
        [self.itemsContainer addSubview:btn];
        
        // 将第一个设置为默认选中
        if (i == 0) {
            _currentBtn = btn;
            _currentBtn.selected = YES;
            _currentBtn.titleLabel.font = self.selectedStateFont;
        }
    }
    
    _buttons = array;
    
    [self addSubview:self.itemsContainer];
    [self addSubview:self.indicatorView];
}

- (void)onItemClick:(UIButton *)sender {
    NSInteger index = sender.tag;
    
    if (_selectedIndex == index) {
        return;
    }
    
    [self updateSelectedIndexTo:index];
    [self updateSelectedItemTo:index];
    
    // 始终通过scrollView的滑动来控制indicatorView的滑动
    if (self.scrollView) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topTabbar:didSelectedItemAtIndex:)]) {
        [self.delegate topTabbar:self didSelectedItemAtIndex:sender.tag];
    }
}

#pragma mark - UIScrollViewDelegate

// setContentOffset: animated: 会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.scrollView]) {
        if (scrollView.bounds.size.width == 0) {
            return;
        }
        
        float x = scrollView.contentOffset.x ;
        float w = self.bounds.size.width/self.titles.count;
        
        if (w == 0) {
            return;
        }
        
        [self setIndicatorCenterX:x/scrollView.bounds.size.width*w+w/2];
    }
}

// 直接滑动scrollView会触发，setContentOffset: animated: 不会触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.scrollView]) {
        
        NSUInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
        
        if (index == self.selectedIndex) {
            return;
        }
        
        [self updateSelectedIndexTo:index];
        [self updateSelectedItemTo:index];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(topTabbar:didSelectedItemAtIndex:)]) {
            [self.delegate topTabbar:self didSelectedItemAtIndex:index];
        }
    }
}

- (void)selectItemAtIndex:(NSUInteger)index {
    if (_selectedIndex == index) {
        return;
    }
    
    UIButton *btn = [self.itemsContainer viewWithTag:index];
    
    [self onItemClick:btn];
}

#pragma mark - private method

- (void)updateSelectedIndexTo:(NSUInteger)index {
    _selectedIndex = index;
}

- (void)updateSelectedItemTo:(NSUInteger)index {

    UIButton *btn = [self.itemsContainer viewWithTag:index];
    
    btn.selected = YES;
    btn.titleLabel.font = self.selectedStateFont;
    
    _currentBtn.selected = NO;
    _currentBtn.titleLabel.font = self.normalStateFont;
    
    _currentBtn = btn;
}

- (void)updateIndicatorToIndex:(NSUInteger)index {
    UIButton *btn = [self.itemsContainer viewWithTag:index];
    
    float x = index * btn.bounds.size.width+btn.bounds.size.width/2;
    
    if (self.indicatorView.center.x != x) {
        
        float y = self.indicatorView.center.y;

        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.center = CGPointMake(x, y);
        }];
        
    }
}

- (void)updateToSelectedStatus:(NSUInteger)index {
    if (_selectedIndex == index) {
            return;
        }
    _selectedIndex = index;

    [self updateSelectedItemTo:_selectedIndex];
}

#pragma mark - setter & getter

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (_selectedIndex == selectedIndex) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    for (UIButton *btn in self.buttons) {
        if (btn.tag == selectedIndex) {
            [self onItemClick:btn];
            break;
        }
    }
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    scrollView.delegate = self;
}

- (void)setDelegate:(id<XFTopTabBarDelegate>)delegate {
    _delegate = delegate;
    
    [self setup];
}

- (void)setIndicatorCenterX:(float)x {
    float y = self.indicatorView.center.y;
    
    self.indicatorView.center = CGPointMake(x, y);
}

- (UIScrollView *)itemsContainer {
    if (_itemsContainer == nil) {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.indicatorHeight);
        
        _itemsContainer = [[UIScrollView alloc] initWithFrame:rect];
        
        // 设置为10000,避免viewWithTag找到自己
        _itemsContainer.tag = 10000;
        _itemsContainer.showsVerticalScrollIndicator = NO;
        _itemsContainer.showsHorizontalScrollIndicator = NO;
    }
    return _itemsContainer;
}

- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        float y = [self h] - self.indicatorHeight/2;
        
        if (self.indicatorType == XFTopBarIndicatorTypeShortLine) {
            y -= 8;
        }

        CGRect rect = CGRectMake(0, y,self.indicatorWidth, self.indicatorHeight);
        
        _indicatorView = [[UIView alloc] initWithFrame:rect];
        
        _indicatorView.center = CGPointMake([self w]/self.titles.count/2, y);
        _indicatorView.backgroundColor = self.indicatorColor;
    }
    return _indicatorView;
}

- (float)indicatorHeight {
    if (_indicatorHeight == 0) {
        _indicatorHeight = 2;
    }
    return _indicatorHeight;
}

- (float)indicatorWidth {
    if (_indicatorWidth == 0) {
        switch (self.indicatorType) {
            case XFTopBarIndicatorTypeDefault:
                _indicatorWidth = [self w]/self.titles.count;
                break;
            case XFTopBarIndicatorTypeLongLine: {
                _indicatorWidth = [self w]/self.titles.count;
                break;
            }
            case XFTopBarIndicatorTypeShortLine: {
                _indicatorWidth = 10;
                break;
            }
            default:
                _indicatorWidth = [self w]/self.titles.count;
                break;
        }
    }

    return _indicatorWidth;
}

- (float)w {
    return self.bounds.size.width;
}

- (float)h {
    return self.bounds.size.height;
}

- (UIColor *)indicatorColor {
    if (_indicatorColor == nil) {
        _indicatorColor = [UIColor blackColor];
    }
    return _indicatorColor;
}

- (UIFont *)normalStateFont {
    if (_normalStateFont == nil) {
        _normalStateFont = [UIFont systemFontOfSize:13];
    }
    return _normalStateFont;
}

- (UIFont *)selectedStateFont {
    if (_selectedStateFont == nil) {
        _selectedStateFont = [UIFont systemFontOfSize:14];
    }
    return _selectedStateFont;
}

@end
