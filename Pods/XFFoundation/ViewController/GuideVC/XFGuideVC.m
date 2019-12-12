//
//  XFGuideVC.m
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/9.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import "XFGuideVC.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface XFGuideVC () <SDCycleScrollViewDelegate>

/** 跳过 */
@property (strong, nonatomic) UIButton *skipButton;

@property (strong, nonatomic) SDCycleScrollView *cycleView;

@end

@implementation XFGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Getter & Setter

- (SDCycleScrollView *)cycleView {
    if (_cycleView == nil) {
        _cycleView = [[SDCycleScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }

    return _cycleView;
}

- (UIButton *)skipButton {
    if (_skipButton == nil) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _skipButton;
}
@end
