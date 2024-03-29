//
//  SDCycleScrollViewDemoVC.m
//  OfferApp
//
//  Created by MAC on 2021/2/20.
//  Copyright © 2021 com.learn. All rights reserved.
//

#import "SDCycleScrollViewDemoVC.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <Masonry/Masonry.h>

@interface SDCycleScrollViewDemoVC ()

@property(strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation SDCycleScrollViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.cycleScrollView];
    
    self.cycleScrollView.autoScroll = YES;
    self.cycleScrollView.autoScrollTimeInterval = 3;
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(150);
    }];
}

- (SDCycleScrollView *)cycleScrollView {
    if (_cycleScrollView == nil) {
        // 网络图片数组
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:imagesURLStrings];
    }
    return _cycleScrollView;
}

@end
