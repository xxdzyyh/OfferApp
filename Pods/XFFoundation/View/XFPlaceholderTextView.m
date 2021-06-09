//
//  XFPlaceholderTextView.m
//  CTQProject
//
//  Created by wangxuefeng on 16/9/9.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFPlaceholderTextView.h"

@interface XFPlaceholderTextView ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation XFPlaceholderTextView

@synthesize placeholderColor = _placeholderColor;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
         [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setup {
    // 监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self]; //通知:监听文字的改变
}

- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - setter & getter

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    CGSize size = self.placeholderLabel.intrinsicContentSize;

    CGRect rect = CGRectMake(8, 8, size.width, size.height);
    
    self.placeholderLabel.frame = rect;
    self.placeholderLabel.hidden = self.hasText;
    
    [self addSubview:self.placeholderLabel];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    _placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    if (_placeholderColor == nil) {
        _placeholderColor = [UIColor grayColor];
    }
    return _placeholderColor;
}

- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        
        _placeholderLabel.font = [UIFont systemFontOfSize:12];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = self.placeholderColor;
        _placeholderLabel.preferredMaxLayoutWidth = self.bounds.size.width - 2*8;
    }
    return _placeholderLabel;
}

@end
