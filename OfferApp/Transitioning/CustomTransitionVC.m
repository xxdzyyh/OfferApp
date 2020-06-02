//
//  CustomTransitionVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/26.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "CustomTransitionVC.h"
#import "BouncePresentAnimatedTransitioning.h"
#import <Masonry/Masonry.h>
#import "KeywordVC.h"
#import "CustomPushAnimatedTransitoning.h"

@interface CustomTransitionVC () <UIViewControllerTransitioningDelegate> {
	CustomPushAnimatedTransitoning *_animatedTransitioning;
}

@end

@implementation CustomTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	_animatedTransitioning = [[CustomPushAnimatedTransitoning alloc] init];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	
	[button setTitle:@"push" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(pushTo) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:button];
	
	[button mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.view);
	}];
}

- (void)pushTo {
	KeywordVC *vc = [KeywordVC new];
	
	self.navigationController.delegate = _animatedTransitioning;

	[self.navigationController pushViewController:vc animated:YES];
//	[self presentViewController:vc animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
	return [BouncePresentAnimatedTransitioning new];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//	return _animatedTransitioning;
//}
@end
