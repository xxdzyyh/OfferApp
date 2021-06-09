//
//  XFButton.m
//  CTQProject
//
//  Created by wangxuefeng on 16/9/22.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFButton.h"
#import "UIView+Utils.h"

@implementation XFButton

@synthesize text = _text;

- (CGSize)intrinsicContentSize {
    float imageH = self.imageView.intrinsicContentSize.height;
    float imageW = self.imageView.intrinsicContentSize.width;
    float titleH = self.titleLabel.intrinsicContentSize.height;
    float titleW = self.titleLabel.intrinsicContentSize.width;
    
    float maxW = MAX(titleW, imageW);
    float maxH = MAX(titleH, imageH);
    
    switch (self.imagePostion) {
        case XFButtonImagePostionTop:
        case XFButtonImagePostionBottom: {
            
            return CGSizeMake(maxW, imageH+self.padding+titleH);
        
            break;
        }
        case XFButtonImagePostionLeft:
        case XFButtonImagePostionRight: {
            
            return CGSizeMake(imageW+self.padding+titleW,maxH);
            break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];// 调用super来设置大小
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    float x = self.width - self.imageView.width - self.padding - self.titleLabel.width;
    float y = self.height - self.imageView.height - self.padding - self.titleLabel.height;
    
    x = x/2;
    y = y/2;
    
    switch (self.imagePostion) {
        case XFButtonImagePostionTop: {
            [self makeImageTop:y];
            break;
        }
        case XFButtonImagePostionLeft: {
            [self makeImageLeft:x];
            break;
        }
        case XFButtonImagePostionRight: {
            [self makeImageRight:x];
            break;
        }
        case XFButtonImagePostionBottom: {
            [self makeImageBottom:y];
            break;
        }
    }
}

- (void)makeImageTop:(float)y {
    self.imageView.center  = CGPointMake(self.width/2, y+self.imageView.height/2);
    self.titleLabel.center = CGPointMake(self.width/2, self.height-y-self.titleLabel.height/2);
}

- (void)makeImageLeft:(float)x {
    self.imageView.center  = CGPointMake(x+self.imageView.width/2, self.bounds.size.height/2);
    self.titleLabel.center = CGPointMake(self.width-x-self.titleLabel.width/2,self.bounds.size.height/2);
}

- (void)makeImageRight:(float)x {
    self.titleLabel.center = CGPointMake(x+self.titleLabel.width/2,self.bounds.size.height/2);
    self.imageView.center  = CGPointMake(self.width-x-self.imageView.width/2, self.bounds.size.height/2);
}

- (void)makeImageBottom:(float)y {
    self.titleLabel.center = CGPointMake(self.width/2, y+self.imageView.height/2);
    self.imageView.center  = CGPointMake(self.width/2, self.height-y-self.imageView.height/2);
}

#pragma mark - setter & getter

- (void)setText:(NSString *)text {
    _text = text;
    
    [self setTitle:text forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (NSString *)text {
    return self.titleLabel.text;
}

@end
