//
//  ADBannerView.m
//  CTQProject
//
//  Created by wangxuefeng on 16/9/24.
//  Copyright © 2016年 code. All rights reserved.
//

#import "ADBannerView.h"
#import <YYKit/YYKit.h>

@implementation ADBannerView

- (void)setAdDataSouce:(id<ADBannerViewDataSouce>)adDataSouce {
    _adDataSouce = adDataSouce;
    
    if (adDataSouce && [adDataSouce respondsToSelector:@selector(imageSouceForBannerView:)]) {
        
        NSArray *urls = [adDataSouce imageSouceForBannerView:self];
        
        if (urls.count > 0) {
            
            for (int i=0; i<urls.count; i++) {
                NSString *url = urls[i];
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
                
                imageView.left = i * self.width;
                
                if ([url hasPrefix:@"http"]) {
                    imageView.imageURL = [NSURL URLWithString:url];
                
                } else {
                    
                    imageView.image = [UIImage imageNamed:url];
                }
                
                [self addSubview:imageView];
            }
            
            self.contentSize = CGSizeMake(urls.count * self.width, self.height);
        }
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapHappened:)];
    
    [self addGestureRecognizer:tap];
}

- (void)tapHappened:(UITapGestureRecognizer *)tap {
    CGPoint offset = self.contentOffset;
    
    NSInteger index = floorf(offset.x/self.width);
    
    if (self.adDelegate && [self.adDelegate respondsToSelector:@selector(bannerView:didSelectedItemAtIndex:)]) {
        
        [self.adDelegate bannerView:self didSelectedItemAtIndex:index];
    }
}

@end
