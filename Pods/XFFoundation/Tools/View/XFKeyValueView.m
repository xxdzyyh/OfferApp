//
//  XFKeyValueView.m
//  Tao
//
//  Created by wangxuefeng on 2019/7/6.
//  Copyright © 2019年 App4life Inc. All rights reserved.
//

#import "XFKeyValueView.h"
#import <Masonry/Masonry.h>
#import "UIView+Utils.h"

@implementation XFKeyValueView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupSubviews];
		[self setupContraints];
	}
	return self;
}

- (void)setupSubviews {
	[self addSubview:self.keyLabel];
	[self addSubview:self.valueLabel];
	
}
- (void)setupContraints {
	[self.keyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[self.keyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self);
		make.centerX.equalTo(self);
		make.right.lessThanOrEqualTo(self.mas_right);
		make.left.greaterThanOrEqualTo(self.mas_left);
	}];
	
	[self.valueLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[self.valueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.keyLabel.mas_bottom).offset(self.padding);
		make.centerX.equalTo(self.keyLabel);
		make.right.lessThanOrEqualTo(self.mas_right);
		make.left.greaterThanOrEqualTo(self.mas_left);
		make.bottom.equalTo(self.mas_bottom);
	}];
}

- (UILabel *)keyLabel{
	if (!_keyLabel) {
		_keyLabel = [[UILabel alloc] init];
		
		_keyLabel.font = kFontSize(14);
	}
	return _keyLabel;
}

- (UILabel *)valueLabel{
	if (!_valueLabel) {
		_valueLabel = [[UILabel alloc] init];
		
		_valueLabel.font = kFontSize(14);
	}
	return _valueLabel;
}

@end
