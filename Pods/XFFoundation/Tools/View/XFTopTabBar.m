//
//  XFTopTabBar.m
//  CTQProject
//
//  Created by wangxuefeng on 16/6/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFTopTabBar.h"
#import <Masonry/Masonry.h>
#import "UIView+Utils.h"
#import "XFMarco.h"


@interface XFTopTabBarItem : UICollectionViewCell

@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation XFTopTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleButton];
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView); 
        }];
    }
    return self;
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [[UIButton alloc] init];
    }
    return _titleButton;
}

@end

@interface XFTopTabBar () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIScrollView *itemsContainer;
@property (strong, nonatomic) UIView *indicatorView;
@property (weak  , nonatomic) UIButton *currentBtn;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XFTopTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认值
        _indicatorHeight = 2;
        _indicatorColor = [UIColor blackColor];
        _normalStateFont = [UIFont systemFontOfSize:13];
        _selectedStateFont = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setupTitles {
    if (self.delegate && [self.delegate respondsToSelector:@selector(titlesForTopTabbar:)]) {
        self.titles = [self.delegate titlesForTopTabbar:self];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(attributeTitlesForTopbar:)]) {
        self.titles = [self.delegate attributeTitlesForTopbar:self];
    }
}

- (void)setup {
    [self setupTitles];

    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height-self.indicatorHeight);
        
    [self addSubview:self.collectionView];
    [self addSubview:self.indicatorView];
    
    [self.collectionView reloadData];
}

- (void)onItemClick:(UIButton *)sender {
    NSInteger index = sender.tag;
	
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
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
        [self.delegate topTabbar:self didSelectedItemAtIndex:index];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [self.delegate topTabbar:self widthForItemAtIndex:indexPath.row];
    return CGSizeMake(width, self.height-self.indicatorHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XFTopTabBarItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XFTopTabBarItem" forIndexPath:indexPath];
    
    UIButton *btn = cell.titleButton;
    
    btn.enabled = NO;
    btn.tag = indexPath.row;
    btn.titleLabel.font = self.normalStateFont;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [btn setTitleColor:self.normalStateColor forState:UIControlStateNormal|UIControlStateDisabled];
    [btn setTitleColor:self.selectedStateColor forState:UIControlStateSelected|UIControlStateDisabled];
    
    NSString *title = self.titles[indexPath.row];
    
    if ([title isKindOfClass:[NSMutableAttributedString class]]) {
        NSMutableAttributedString * s = (NSMutableAttributedString *)title;
        [s addAttribute:NSForegroundColorAttributeName value:self.normalStateColor range:NSMakeRange(0, s.length)];
        [btn setAttributedTitle:s forState:UIControlStateNormal|UIControlStateDisabled];
        
        NSMutableAttributedString *s1 = [s mutableCopy];
        [s1 addAttribute:NSForegroundColorAttributeName value:self.selectedStateColor range:NSMakeRange(0, s1.length)];
        [btn setAttributedTitle:s1 forState:UIControlStateSelected|UIControlStateDisabled];
    } else {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    if (indexPath.row == self.selectedIndex) {
        btn.selected = YES;
        self.currentBtn.selected = NO;
        self.currentBtn = btn;
    }
    
    return cell;
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
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	
	XFTopTabBarItem *cell = (XFTopTabBarItem *)[self.collectionView cellForItemAtIndexPath:indexPath];
	
	self.currentBtn.selected = NO;
	cell.titleButton.selected = YES;
	self.currentBtn = cell.titleButton;
	
	[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
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
	
	XFTopTabBarItem *cell = (XFTopTabBarItem *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];

	[self onItemClick:cell.titleButton];
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
        float y = self.height - self.indicatorHeight/2;
        
        if (self.indicatorType == XFTopBarIndicatorTypeShortLine) {
            y -= 8;
        }

        CGRect rect = CGRectMake(0, y,self.indicatorWidth, self.indicatorHeight);
        
        _indicatorView = [[UIView alloc] initWithFrame:rect];
        
        _indicatorView.center = CGPointMake(self.width/self.titles.count/2, y);
        _indicatorView.backgroundColor = self.indicatorColor;
    }
    return _indicatorView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake((XFScreenWidth-scaleX(17*2)), scaleY(83*2+12));
        layout.minimumLineSpacing = scaleY(12);
        layout.minimumInteritemSpacing = scaleX(13);

        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:[XFTopTabBarItem class] forCellWithReuseIdentifier:@"XFTopTabBarItem"];

        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
