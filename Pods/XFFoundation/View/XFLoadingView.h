//
//  XFLoadingView.h
//  XFFoundation
//
//  Created by wangxuefeng on 16/7/21.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFInfoView.h"

@interface XFLoadingView : XFInfoView

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

+ (XFLoadingView *)loadingView;

@end
