//
//
//  Created by mc008 on 16/1/27.
//  Copyright © 2016年 wxf. All rights reserved.
//

#import "XFCardViewController.h"
#import "UIView+Utils.h"
#import "Masonry.h"

#define SWidth [[UIScreen mainScreen] bounds].size.width

#define SHeight [[UIScreen mainScreen] bounds].size.height

typedef enum
{
    PositionTypeLeft=0,/**< 第一张图和第二张图 */
    PositionTypeMid=1,/**< 中间部分，三张图 */
    PositionTypeRight=2  /**< 最后两张图 */
}PositionType;

@interface XFCardViewController ()<UIScrollViewDelegate>
{
    /**< _count 总共的页数 */
    int _count;
    /**< _index 当前页码 */
    NSInteger _index;
    /**< _currentType 表示scrollView的类型 */
    PositionType _currentType;
}

@property (strong, nonatomic) UIView * viewLeft;
@property (strong, nonatomic) UIView * viewMid;
@property (strong, nonatomic) UIView * viewRight;

@property (strong, nonatomic) NSMutableArray * dataSource;

@end

@implementation XFCardViewController

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<XFCardViewControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        self.view.frame = frame;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.scrollView.autoresizesSubviews = NO;
        
        [self prepareLeftViews];
        
        self.scrollView.contentOffset = CGPointZero;
        
        [self.view layoutIfNeeded];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.viewLeft.height = self.view.height;
}

#pragma mark - event response

- (void)selectedViewControllerAtIndex:(NSInteger)index {
    if (index == _index) {
        return;
    }

    if (index - _index == 1) {
        CGPoint p1= _scrollView.contentOffset;
        
        [UIView animateWithDuration:0.30f animations:^{
            
            _scrollView.contentOffset=CGPointMake(p1.x+self.view.width, p1.y);
        } completion:^(BOOL finished) {
            
            [self creatView];
        }];
    } else if (index - _index == -1) {
        
        CGPoint p1= _scrollView.contentOffset;
        
        [UIView animateWithDuration:0.30f animations:^{
            
            _scrollView.contentOffset=CGPointMake(p1.x-self.view.width, p1.y);
            
         } completion:^(BOOL finished) {
            
             [self creatView];
         
         }];
    } else if (index - _index > 1) {
        
        if (_index == 0) {
            
            [self replaceViewMidWithView:self.dataSource[index]];
        } else {
            
            [self replaceViewRightWithView:self.dataSource[index]];
        }
        
        _index = index;

        CGPoint p1= _scrollView.contentOffset;
        
        [UIView animateWithDuration:0.30f animations:^{
            
            _scrollView.contentOffset=CGPointMake(p1.x+self.view.width,p1.y);
            
         } completion:^(BOOL finished) {
            
             if (_index == self.dataSource.count - 1) {
                 
                 [self prepareRightViews];
             } else {
                 
                 [self prepareMidViews];
             }
         }];
    } else if (index - _index < -1) {
        
        [self replaceViewLeftWithView:self.dataSource[index]];

        _index = index;

        CGPoint p1= _scrollView.contentOffset;
        
        // 动画不会触发scrollViewDidEndDecelerating
        [UIView animateWithDuration:0.30f animations:^{
            
            _scrollView.contentOffset=CGPointMake(p1.x-self.view.width, p1.y);
         
        } completion:^(BOOL finished) {
            if (_index == 0) {

                [self prepareLeftViews];

            } else {
            
                [self prepareMidViews];
            }
        }];
    }
}

#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self creatView];
}

#pragma mark - private mothod 

/**
 *	@brief	设置将要显示到_scrollView的视图
 *
 *	@returns viod
 */
-(void)creatView {
    CGFloat pageWidth = _scrollView.frame.size.width;
    
    //pageIndex 为 0、1、2
    int pageIndex = floor((_scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    
    switch (_currentType) {
        case PositionTypeLeft:
        {
            _index = _index + pageIndex;
            
            //0 -> 1 prepareMidViews
            //0 -> 0 不变
            if (pageIndex == 1) {
                [self prepareMidViews];
            }
            break;
        }
        case PositionTypeMid:
        {
            _index = _index + pageIndex - 1;
            
            if (_index == 0) {
                
                [self prepareLeftViews];
                
            } else if (_index == self.dataSource.count - 1){
                
                [self prepareRightViews];
                
            } else {
                
                [self prepareMidViews];
            }
        }
            break;
        case PositionTypeRight:
        {
            _index = _index + pageIndex - 1;

            if (pageIndex == 0) {
                [self prepareMidViews];
            }
            break;
        }
        
        default:
            break;
    }
    
    _scrollView.userInteractionEnabled = YES;
    
    [self notifyIndexChanged];
}

- (void)notifyIndexChanged {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedViewControllerAtIndex:)]) {
        [self.delegate didSelectedViewControllerAtIndex:_index];
    }
}

- (void)prepareLeftViews {
    
    for (UIView * view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (self.dataSource.count < 2) {
        return;
    }
    
    self.viewLeft = self.dataSource[_index];
    self.viewMid  = self.dataSource[_index + 1];
   
    self.viewLeft.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.viewMid.frame  = CGRectMake(self.view.width, 0, self.view.width, self.view.height);
    
    [_scrollView addSubview:self.viewLeft];
    [_scrollView addSubview:self.viewMid];
    
    _scrollView.contentSize = CGSizeMake(self.view.width *2, self.view.height);

    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    _currentType = PositionTypeLeft;
}

- (void)prepareMidViews {
    for (UIView * view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (self.dataSource.count<3) {
        return;
    }
    
    self.viewLeft  = self.dataSource[_index - 1];
    self.viewMid   = self.dataSource[_index];
    self.viewRight = self.dataSource[_index + 1];
    
    self.viewLeft.frame = CGRectMake(0, 0, _scrollView.width, _scrollView.height);
    self.viewMid.frame = CGRectMake(self.view.width, 0, self.view.width, self.view.height);
    self.viewRight.frame = CGRectMake(self.view.width * 2, 0, self.view.width, self.view.height);
    
    [_scrollView addSubview:self.viewLeft];
    [_scrollView addSubview:self.viewMid];
    [_scrollView addSubview:self.viewRight];
    
    _scrollView.contentSize = CGSizeMake(self.view.width *3, self.view.height);

    [_scrollView setContentOffset:CGPointMake(self.view.width, 0) animated:NO];
    
    _currentType = PositionTypeMid;
}

- (void)prepareRightViews {
    for (UIView * view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
    }
    
    self.viewLeft = self.dataSource[_index -1];
    self.viewMid  = self.dataSource[_index ];
    
    self.viewLeft.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.viewMid.frame = CGRectMake(self.view.width, 0, self.view.width, self.view.height);
    
    [_scrollView addSubview:self.viewLeft];
    [_scrollView addSubview:self.viewMid];
    
    _scrollView.contentSize = CGSizeMake(self.view.width *2, self.view.height);
//    [_scrollView scrollRectToVisible:CGRectMake(self.view.width, 0, self.view.width, self.view.height) animated:NO];
    
    [_scrollView setContentOffset:CGPointMake(self.view.width, 0) animated:NO];
    
    _currentType = PositionTypeRight;
}

- (void)replaceViewLeftWithView:(UIView *)view {
    
    if (self.viewLeft.superview) {
        
        CGRect frame = self.viewLeft.frame;
        
        view.frame = frame;
        
        [self.viewLeft removeFromSuperview];
        
        [self.scrollView addSubview:view];
        
        self.viewLeft = view;
    }
}

- (void)replaceViewMidWithView:(UIView *)view {
    if (self.viewMid.superview) {
        
        CGRect frame = self.viewMid.frame;
        
        view.frame = frame;
        
        [self.viewMid removeFromSuperview];
        [self.scrollView addSubview:view];
        
        self.viewMid = view;
    }
}

- (void)replaceViewRightWithView:(UIView *)view {
    if (self.viewRight.superview) {
        
        CGRect frame = self.viewRight.frame;

        view.frame = frame;
        
        [self.viewRight removeFromSuperview];
        [self.scrollView addSubview:view];
        
        self.viewRight = view;
    }
}
#pragma mark - setter & getter

- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces=NO;
        _scrollView.directionalLockEnabled = YES;
    }
    
    return _scrollView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        if (self.delegate) {
            NSArray * array = [self.delegate viewControllersForCardViewController];
            
            _dataSource = [NSMutableArray array];
            
            for (UIViewController * vc in array) {
                
                vc.automaticallyAdjustsScrollViewInsets = NO;
                
                [self addChildViewController:vc];
                
                [_dataSource addObject:vc.view];
            }
        }
    }
    return _dataSource;
}

@end
