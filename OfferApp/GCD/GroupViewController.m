//
//  GroupViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/12.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "GroupViewController.h"

@interface BFUtils : NSObject 

+ (BFUtils *)shared;

@end

@implementation BFUtils

+ (BFUtils *)shared {
    static BFUtils *_share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[BFUtils alloc] init];
    });
    return _share;
}

- (NSString *)token {
    return @".....";
}

@end

@interface BFHttpClient : NSObject 

+ (BFHttpClient *)shareClient;

@end

@implementation BFHttpClient

+ (BFHttpClient *)shareClient {
    static BFHttpClient *_share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[BFHttpClient alloc] init];
        
        [_share test];
    });
    
    
    return _share;
}

- (void)test {
    NSString *token = [[BFUtils shared] token];
    
    NSLog(@"%@",token);
}

@end



@interface GroupViewController ()

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [BFHttpClient shareClient];
}

- (void)group {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"sleep(1) start");
        sleep(1);
        NSLog(@"sleep(1) end");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"sleep(3) start");
        sleep(3);
        NSLog(@"sleep(3) end");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"sleep(5) start");
        sleep(5);
        NSLog(@"sleep(5) end");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"GCD Group Tasks finish");
    });
}

@end
