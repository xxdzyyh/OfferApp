//
//  SDWebImageTestVC.m
//  OfferApp
//
//  Created by xiaoniu on 10/21/19.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "SDWebImageTestVC.h"
#import <Masonry/Masonry.h>
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>

#import <ReactiveObjC/ReactiveObjC.h>

@interface SDWebImageTestVC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SDWebImageTestVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[[SDImageCache sharedImageCache] clearMemory];
	[[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
		
	}];
	
	
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.equalTo(self.view);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
	[self.navigationController popViewControllerAnimated:NO];
    /**
     不是所有的图片都可以使用 SDWebImageProgressiveLoad 。Progressive JPEG
     */
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img.alicdn.com/imgextra/i4/1716499517/O1CN01nm8ud62KApqtVhVbI_!!1716499517.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
		NSLog(@"111");
	}];
	
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img.alicdn.com/imgextra/i4/1716499517/O1CN01nm8ud62KApqtVhVbI_!!1716499517.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
		NSLog(@"222");
	}];
	
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img.alicdn.com/imgextra/i4/1716499517/O1CN01nm8ud62KApqtVhVbI_!!1716499517.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
		NSLog(@"333");
	}];
}

#pragma mark - Setter & Getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

- (void)dealloc {
	NSLog(@"SDWebImageTestVC dealloc");
}

@end
