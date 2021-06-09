//
//  XFCodeButton.m
//  TourGuide
//
//  Created by xiaoniu on 2018/9/3.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "XFCodeButton.h"

@interface XFCodeButton() {
    
    dispatch_source_t _timer;
}

@end

@implementation XFCodeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup {
    self.totolCount = 60;
    self.countFormat = @"重新获取(%d)s";
    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click {
    if (self.onClickBlock) {
        self.onClickBlock();
    }
    [self startCount];
}

- (void)startCount {
    
    __block NSUInteger timeout = self.totolCount;
    
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0.0f * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            [self stopCount];
        } else {
            NSString *timeString = [NSString stringWithFormat:self.countFormat,timeout];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setTitle:timeString forState:UIControlStateNormal]; 
                self.userInteractionEnabled = NO;
            });
            
            timeout--;
        }
    
    });
    
    dispatch_resume(_timer); 
}

- (void)stopCount {
    if (_timer) {
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTitle:@"获取验证码" forState:UIControlStateNormal];
            
            self.userInteractionEnabled = YES;
        });
        
        _timer = nil;
    }
}

- (void)dealloc {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
