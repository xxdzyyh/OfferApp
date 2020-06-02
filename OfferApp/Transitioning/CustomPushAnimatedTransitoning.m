//
//  CustomPushAnimatedTransitoning.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/26.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "CustomPushAnimatedTransitoning.h"

@implementation CustomPushAnimatedTransitoning

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
	NSLog(@"%s",__func__);
	return nil;
	
	/**
		UIScreenEdgePanGestureRecognizer
		UIPercentDrivenInteractiveTransition
	 */
	return [UIPercentDrivenInteractiveTransition new];
}


/**
	当 navigationController 进行特定的 operation时，动画要怎么做
	返回一个动画代理，在需要的时候调用代理的方法
 */
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
	NSLog(@"%s",__func__);
	if (operation == UINavigationControllerOperationPush) {
		return [CustomPushAnimatedTransitoning new];
	} else {
		return [CustomPushAnimatedTransitoning new];
	}
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
	NSLog(@"%s",__func__);
	return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	NSLog(@"%s",__func__);
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	CGRect screenBounds = [UIScreen mainScreen].bounds;

	toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);

	[containerView addSubview:toVC.view];

	NSTimeInterval duration = [self transitionDuration:transitionContext];

	// 改成弹性动画
	[UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
		toVC.view.frame = finalFrame;
	} completion:^(BOOL finished) {
		[transitionContext completeTransition:YES];
	}];
}

@end
