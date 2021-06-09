//
//  XFInfoView.m
//  CTQProject
//
//  Created by wangxuefeng on 16/7/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFInfoView.h" 
#import "UIView+Utils.h"
#import <Masonry.h>
#define kPadding 15

@interface XFInfoView () {
    UIView *_vContainer;
}
@end

@implementation XFInfoView

- (instancetype)initWithInfo:(NSString *)info imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.info = info;
        self.imageName = imageName;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithInfo:(NSString *)info customView:(UIView *)customView {
    self = [super init];
    if (self) {
        self.info = info;
        _customView = customView;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)showAtView:(UIView *)superview {
    if (_vContainer == nil) {
        _vContainer = [UIView new];

        [self addSubview:_vContainer];
    } else {
        [_vContainer removeAllSubviews];
    }
    
    if (_label) {
        [_vContainer addSubview:_label];
    }
    
    if (_imageView && _customView == nil) {
        [_vContainer addSubview:_imageView];
    }
    
    if (_customView) {
        [_vContainer addSubview:_customView];
    }
    
    [self configContainerViewSize];
    
    self.frame = superview.bounds;
    
    _vContainer.center = CGPointMake(self.width/2, self.height/2);

    [superview addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _vContainer.center = self.center;
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)configContainerViewSize {
    UIView *v = _customView;
    
    if (v == nil) {
        v = _imageView;
    }
    
    if (v && _label) {
        float w = MAX(v.width, _label.width);
        float h = v.height + self.padding + _label.height;
        
        v.centerX = w/2;
        _label.top = v.height + self.padding;
        _label.centerX = w/2;
        
        _vContainer.size = CGSizeMake(w, h);
    } else if (v) {
        _vContainer.size = v.size;
    } else {
        _vContainer.size = _label.size;
    }
}

#pragma mark - setter & getter

- (void)setInfo:(NSString *)info {
    _info = info;
    
    if (_info.length > 0) {
        if (_label == nil) {
            _label = [[UILabel alloc] init];
        }
        _label.text = _info;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor colorWithRed:0.600 green:0.600 blue:0.600 alpha:1.00];
        _label.size = _label.intrinsicContentSize;
    } else {
        _label = nil;
    }
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    if (_imageName && _customView == nil) {
        UIImage *image = [UIImage imageNamed:_imageName];
        
        if (_imageView == nil) {
            _imageView = [[UIImageView alloc] init];
        }
        _imageView.image = image;
        _imageView.size  = image.size;
    } else {
        _imageView = nil;
    }
}

- (float)padding {
    if (_padding == 0) {
        _padding = 15;
    }
    return _padding;
}

@end
