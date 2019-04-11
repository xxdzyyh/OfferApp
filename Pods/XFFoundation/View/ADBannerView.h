//
//  ADBannerView.h
//  CTQProject
//
//  Created by wangxuefeng on 16/9/24.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADBannerView;

@protocol ADBannerViewDataSouce <NSObject>

// 可以是mainBundle中文件名，也可以是http开头的地址
- (NSArray *)imageSouceForBannerView:(ADBannerView *)bannerView;

@end

@protocol ADBannerViewDelegate <NSObject>

- (void)bannerView:(ADBannerView *)bannerView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface ADBannerView : UIScrollView

@property (weak, nonatomic) id<ADBannerViewDataSouce> adDataSouce;

@property (weak, nonatomic) id<ADBannerViewDelegate> adDelegate;

@end
