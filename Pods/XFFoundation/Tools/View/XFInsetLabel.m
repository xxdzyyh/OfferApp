//
//  XFInsetLabel.m
//  XFFoundation
//
//  Created by xiaoniu on 2019/1/7.
//  Copyright © 2019 wangxuefeng. All rights reserved.
//

#import "XFInsetLabel.h"

@implementation XFInsetLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.insets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.insets = UIEdgeInsetsZero;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    
    size.width += (self.insets.left + self.insets.right);
    size.height += (self.insets.top + self.insets.bottom);
    
    return size;
}

@end
