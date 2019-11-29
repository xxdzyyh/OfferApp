//
//  RACObserverVC.m
//  OfferApp
//
//  Created by jmf66 on 2019/11/28.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "RACObserverVC.h"

@interface Anchor : NSObject

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *uid;

@end

@implementation Anchor

@end

@interface LiveRoom : NSObject

@property (nonatomic ,copy) NSString *anchorName;
@property (nonatomic ,copy) NSString *anchorUid;

@end

@implementation LiveRoom

@end

@interface RACObserverVC ()

@end

@implementation RACObserverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
