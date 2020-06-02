//
//  BouncePresentAnimatedTransitioning.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/26.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "BouncePresentAnimatedTransitioning.h"

@implementation BouncePresentAnimatedTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
	
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	CGRect screenBounds = [UIScreen mainScreen].bounds;
	toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
	[containerView addSubview:toVC.view];
	
	NSTimeInterval duration = [self transitionDuration:transitionContext];
	
//	// 改成弹性动画
//    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        fromVC.view.alpha = 0.5;
//        toVC.view.frame = finalFrame;
//    } completion:^(BOOL finished) {
//		fromVC.view.alpha = 1.0;
//		[transitionContext completeTransition:YES];
//	}];
	
	// 将动画改为p类似push动画
	toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, 0);
	[UIView animateWithDuration:duration animations:^{
		fromVC.view.alpha = 0.5;
		toVC.view.frame = finalFrame;
	} completion:^(BOOL finished) {
		fromVC.view.alpha = 1.0;
		[transitionContext completeTransition:YES];
	}];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
	return 1.0;
}


@end
