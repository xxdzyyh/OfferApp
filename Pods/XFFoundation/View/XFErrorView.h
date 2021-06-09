//
//  XFErrorView.h
//  XFFoundation
//
//  Created by wangxuefeng on 16/7/21.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFInfoView.h"

@class XFErrorView;

@protocol XFErrorViewDelegate <NSObject>

- (void)recoveryFromError:(XFErrorView *)errorView;

@end

@interface XFErrorView : XFInfoView

@property (weak  , nonatomic) id<XFErrorViewDelegate> delegate;

@end
