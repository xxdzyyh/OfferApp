//
//  XFLoadingView.m
//  XFFoundation
//
//  Created by wangxuefeng on 16/7/21.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFLoadingView.h"
#import "UIView+YYAdd.h"

@implementation XFLoadingView

+ (XFLoadingView *)loadingView {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    indicatorView.transform = transform;
    indicatorView.origin = CGPointZero;
    
    XFLoadingView *v = [[XFLoadingView alloc] initWithInfo:nil customView:indicatorView];
    
    v.indicatorView = indicatorView;
    
    return v;
}

- (void)showAtView:(UIView *)superview {
    [super showAtView:superview];
    
    [self.indicatorView startAnimating];
}

- (void)dismiss {
    [super dismiss];
    
    [self.indicatorView stopAnimating];
}

@end
