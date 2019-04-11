//
//  MyViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/26.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (instancetype)init {
    self = [super init];

    return self;
}

- (void)loadView {
    [super loadView];
    
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
}

@end
