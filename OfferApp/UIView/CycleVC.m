//
//  CycleVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/21.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "CycleVC.h"

@interface CycleVC ()

@end

@implementation CycleVC

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		NSLog(@"%s",__func__);
	}
	return self;
}

/**
 2020-05-21 16:44:32.062539+0800 OfferApp[51220:10127787] -[CycleVC initWithNibName:bundle:]
 2020-05-21 16:44:32.067097+0800 OfferApp[51220:10127787] -[CycleVC loadView]
 2020-05-21 16:44:32.075610+0800 OfferApp[51220:10127787] -[CycleVC viewDidLoad]
 2020-05-21 16:44:32.075896+0800 OfferApp[51220:10127787] -[CycleVC viewWillAppear:]
 
 注意布局时在 viewWillAppear 后，viewDidAppear 之前
 注意布局时在 viewWillAppear 后，viewDidAppear 之前
 注意布局时在 viewWillAppear 后，viewDidAppear 之前
 
 2020-05-21 16:44:32.164461+0800 OfferApp[51220:10127787] -[CycleVC viewWillLayoutSubviews]
 2020-05-21 16:44:32.164669+0800 OfferApp[51220:10127787] -[CycleVC viewDidLayoutSubviews]
 2020-05-21 16:44:32.717825+0800 OfferApp[51220:10127787] -[CycleVC viewDidAppear:]
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		NSLog(@"%s",__func__);
	}
	return self;
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	
	NSLog(@"%s",__func__);
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	NSLog(@"%s",__func__);
}

- (void)loadView {
	[super loadView];
	NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	NSLog(@"%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	NSLog(@"%s",__func__);
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	NSLog(@"%s",__func__);
}

@end
