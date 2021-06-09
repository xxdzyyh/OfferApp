//
//  XFEmptyView.m
//  XFFoundation
//
//  Created by wangxuefeng on 16/7/11.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFEmptyView.h"
#import "UIView+Utils.h"

#define kPadding 15

@interface XFEmptyView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel     *label;
@property (strong, nonatomic) UIView      *container;

@end

@implementation XFEmptyView

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)imageName {
    _title = title;
    _imageName = imageName;
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.frame = newSuperview.bounds;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
}

- (void)layoutSubviews {
    self.container.center = CGPointMake(self.width/2, self.height/2);
    self.imageView.centerX = self.container.width/2;
    self.label.centerX = self.container.width/2;
}

- (void)setup {
    if (_imageName) {
        
        if (_imageView == nil) {
            _imageView = [[UIImageView alloc] init];
        }
        
        UIImage *image = [UIImage imageNamed:_imageName];
        
        _imageView.image = image;
        _imageView.size = _imageView.intrinsicContentSize;
    } else {
        
        _imageView = nil;
    }
    
    if (_title) {
        
        if (_label == nil) {
            _label = [[UILabel alloc] init];
            _label.font = [UIFont systemFontOfSize:14];
            _label.textColor = [UIColor colorWithRed:0.600 green:0.600 blue:0.600 alpha:1.00];
        }
        
        _label.text = _title;
        _label.size = _label.intrinsicContentSize;
    } else {
        
        _label = nil;
    }
    
    if (_container == nil) {
        _container = [[UIView alloc] init];
    }
    
    if (_imageView && _label) {
        
        [_container addSubview:_imageView];
        [_container addSubview:_label];
        
        float w = MAX(_imageView.width, _label.width);
        float h = _imageView.height + kPadding + _label.height;
        
        _container.size = CGSizeMake(w, h);
        _container.center = self.center;
        
        _imageView.centerX = _container.centerX;
        _label.top = _imageView.height + kPadding;
        _label.centerX = _container.centerX;
        
    } else if (_label) {
        _container.size = _label.size;
        
        [_container addSubview:_label];
    } else {
        _container.size = _imageView.intrinsicContentSize;
        [_container addSubview:_imageView];
    }
    
    [self addSubview:_container];
}

#pragma mark - setter & getter

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
        
        [self setup];
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        [self setup];
    }
}

@end

