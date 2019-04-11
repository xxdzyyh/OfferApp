//
//  XFBannerScrollView.m
//  CTQProject
//
//  Created by wangxuefeng on 16/5/30.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFBannerScrollView.h"
#import "UIImageView+YYWebImage.h"

@interface XFBannerScrollView () <UIScrollViewDelegate> {
    CGRect _expectFrame;
    NSUInteger _currentIndex;
    BOOL _hasTapGesture;
}

@property (strong, nonatomic) NSArray *imageViews;

@property (strong, nonatomic) UIImageView *imgvLef;
@property (strong, nonatomic) UIImageView *imgvMid;
@property (strong, nonatomic) UIImageView *imgvRig;

@property (assign, nonatomic) NSUInteger numberOfPages;

@property (strong, nonatomic) NSArray *imageURLs;

@property (strong, nonatomic) UIPageControl *pageControl;

@end


@implementation XFBannerScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float w = CGRectGetWidth(self.frame);
    float h = CGRectGetHeight(self.frame);
    
    self.contentSize = CGSizeMake(w * 3, h);
    
    _imgvLef.frame = CGRectMake(0, 0, w, h);
    _imgvMid.frame = CGRectMake(w, 0, w, h);
    _imgvRig.frame = CGRectMake(w*2, 0, w, h);
    
    [self updatePageControlPostion];
}

- (void)reloadData {
    if ([_dataSource respondsToSelector:@selector(imageURLsForBannerScrollView:)]) {
        NSArray *array = [_dataSource imageURLsForBannerScrollView:self];
        if (array.count > 0) {
            self.imageURLs = array;
        }
    }

    _numberOfPages = _imageURLs.count;
    
    self.pageControl.numberOfPages = _numberOfPages;
    self.pageControl.frame = CGRectMake(0, 0, 20*_numberOfPages, 20);
    
    XFPageControlPostion p = self.pageControlPostion;
    
    [self setPageControlPostion:p];
    
    if (_imageViews.count > 0 && _imageURLs.count > 0) {
        for (int i=0; i<_imageURLs.count && i < 3; i++) {
            UIImageView *imageView = _imageViews[i];
            
            [self setImageForImageView:imageView withImageURL:_imageURLs[i]];
        }
    }
}

- (void)setUp {
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.delegate = self;
    
    float w = CGRectGetWidth(self.frame);
    float h = CGRectGetHeight(self.frame);
    
    _imgvLef = [[UIImageView alloc]init];
    _imgvMid = [[UIImageView alloc]init];
    _imgvRig = [[UIImageView alloc]init];
    
    _imgvLef.tag = 0;
    _imgvMid.tag = 1;
    _imgvRig.tag = 2;
    
    _imageViews = @[_imgvLef, _imgvMid, _imgvRig];
    
    _currentIndex = 1;
    
    [self setContentOffset:CGPointMake(w, 0)];
    [self.pageControl setCurrentPage:1];
    
    for (UIView *v in self.imageViews) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedImage:)];
        [v addGestureRecognizer:tap];
        
        [self addSubview:v];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview addSubview:self.pageControl];
    
    if (self.autoScroll) {
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollByTimer) userInfo:nil repeats:YES];
        
        //触摸的时候就不要跳了
        //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    for (UIView *v in self.imageViews) {
        
        v.userInteractionEnabled = self.acceptTap;
        v.contentMode = self.imageContentMode;
    }
}

- (void)dealloc {
    //timer会自动置nil
}

#pragma mark - event resopnse 

- (void)scrollByTimer {
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*2, 0) animated:YES];
    [self scrollViewDidEndDecelerating:self];
}

- (void)tapedImage:(UITapGestureRecognizer *)tap {
    if (self.bannerDelegate && [self.bannerDelegate respondsToSelector:@selector(bannerScrollView:didTapImageAtIndex:)]) {
        
        [self.bannerDelegate bannerScrollView:self didTapImageAtIndex:_currentIndex];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float w       = CGRectGetWidth(self.frame);
    float offsetX = scrollView.contentOffset.x;
    
    if (offsetX == 0) {
        
        _currentIndex = _currentIndex == 0 ? _numberOfPages-1 : _currentIndex-1;
    } else if (offsetX == w*2){
        
        _currentIndex = _currentIndex == _numberOfPages-1 ? 0 : _currentIndex+1;
    } else {
        
        return;
    }
    
    self.pageControl.currentPage = _currentIndex;
    
    NSInteger lefIndex = _currentIndex == 0 ? _numberOfPages-1 : _currentIndex-1;
    NSInteger rigIndex = _currentIndex == _numberOfPages-1 ? 0 : _currentIndex+1;
    
    NSString *lefURL = _imageURLs[lefIndex];
    NSString *midURL = _imageURLs[_currentIndex];
    NSString *rigURL = _imageURLs[rigIndex];
    
    [self setImageForImageView:_imgvLef withImageURL:lefURL];
    [self setImageForImageView:_imgvMid withImageURL:midURL];
    [self setImageForImageView:_imgvRig withImageURL:rigURL];
    
    self.contentOffset = CGPointMake(w, 0);
}

- (void)setImageForImageView:(UIImageView *)imageView withImageURL:(NSString *)URL {
    if ([URL hasPrefix:@"http"]) {
        [imageView setImageWithURL:[NSURL URLWithString:URL]
                           placeholder:self.placeHolderImage];
    } else {
        
        UIImage *image = [UIImage imageNamed:URL];
        
        if (image == nil) {
            imageView.image = self.placeHolderImage;
        } else {
            imageView.image = image;
        }
    }
}

#pragma mark - setter & getter 

- (void)setBannerDelegate:(id<XFBannerScrollViewDelegate>)bannerDelegate {
    _bannerDelegate = bannerDelegate;
    
    if (_bannerDelegate && [_bannerDelegate respondsToSelector:@selector(shouldAcceptTapEvent)]) {
        _acceptTap = [_bannerDelegate shouldAcceptTapEvent];
    }
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.enabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

- (void)setDataSource:(id<XFBannerScrollViewDataSource>)dataSource {
    _dataSource = dataSource;
    
    if ([_dataSource respondsToSelector:@selector(imageURLsForBannerScrollView:)]) {
        NSArray *array = [_dataSource imageURLsForBannerScrollView:self];
        if (array.count > 0) {
            self.imageURLs = array;
        }
    }
}

- (void)updatePageControlPostion {
    
    float w = CGRectGetWidth(self.frame);
    float h = CGRectGetHeight(self.frame);
    
    float width = CGRectGetWidth(self.pageControl.frame);
    float height = CGRectGetHeight(self.pageControl.frame);
    
    switch (_pageControlPostion) {
        case XFPageControlPostionNone: {
            self.pageControl.hidden = YES;
            break;
        }
        case XFPageControlPostionDefault: {
            self.pageControl.hidden = NO;
            self.pageControl.center = CGPointMake(w - width/2.0, h - height/2.0);
            break;
        }
        case XFPageControlPostionLeft: {
            self.pageControl.hidden = NO;
            self.pageControl.center = CGPointMake(width/2.0, h - height/2.0);
            break;
        }
        case XFPageControlPostionCenter: {
            self.pageControl.hidden = NO;
            self.pageControl.center = CGPointMake(w/2, h - height/2.0);
            break;
        }
        case XFPageControlPostionRight: {
            self.pageControl.hidden = NO;
            self.pageControl.center = CGPointMake(w - width/2.0, h - height/2.0);
            break;
        }
    }
}

- (void)setPageControlPostion:(XFPageControlPostion)pageControlPostion {
    _pageControlPostion = pageControlPostion;
    
    [self updatePageControlPostion];
}

@end
