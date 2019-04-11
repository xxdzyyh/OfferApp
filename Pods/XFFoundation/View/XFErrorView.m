//
//  XFErrorView.m
//  XFFoundation
//
//  Created by wangxuefeng on 16/7/21.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFErrorView.h"

@implementation XFErrorView

- (instancetype)initWithInfo:(NSString *)info imageName:(NSString *)imageName {
    self = [super initWithInfo:info imageName:imageName];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithInfo:(NSString *)info customView:(UIView *)customView {
    self = [super initWithInfo:info customView:customView];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(recoveryFromError:)]) {
        [self.delegate recoveryFromError:self];
    }
}

@end
