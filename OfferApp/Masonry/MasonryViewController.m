//
//  MasonryViewController.m
//  OfferApp
//
//  Created by jmf66 on 2019/12/11.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "MasonryViewController.h"
#import <Masonry/Masonry.h>

@interface MasonryViewController ()

@property (nonatomic, strong) UIButton *orangeView;

@property (nonatomic, strong) UIButton *redView;
@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.orangeView];
    [self.view addSubview:self.redView];
    
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.mas_equalTo(100);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(200);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.mas_equalTo(100);
    }];
}

- (void)buttonClicked {
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.mas_equalTo(100);
    }];
}

- (UIButton *)orangeView {
    if (_orangeView == nil) {
        _orangeView = [[UIButton alloc] init];
        
        [_orangeView setBackgroundColor:[UIColor orangeColor]];
        [_orangeView setTitle:@"变变变" forState:UIControlStateNormal];
        [_orangeView addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orangeView;
}

- (UIButton *)redView {
    if (_redView == nil) {
        _redView = [[UIButton alloc] init];
        
        [_redView setBackgroundColor:[UIColor redColor]];
        [_redView setTitle:@"变变变" forState:UIControlStateNormal];
        [_redView addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _redView;
}


@end
