//
//  MultiThreadVCViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/11.
//  Copyright © 2018年 com.learn. All rights reserved.
//

//  NSRunLoopCommonModes {
//    NSDefaultRunLoopMode,
//    NSEventTrackingRunLoopMode
//  }

#import "MultiThreadVC.h"

@interface MultiThreadVC ()

@property (strong, nonatomic) NSString *target;

@end

@implementation MultiThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = @[@{ActionTypeString : @(ActionTypeNone),ActionDescString:@"setter多线程闪退",ActionValueString:@"setter多线程闪退"}];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    ActionType type = [dict[ActionTypeString] integerValue];
    NSString *value = dict[ActionValueString];
    
    if (type == ActionTypeNone) {
        if ([value isEqualToString:@"setter多线程闪退"]) {
            [self testProperty];
        }  
    } 
}

- (void)testProperty {
    /**
     
     1    - (void)setTarget:(NSString *)target {
     2      [target retain];
     3      [_target release];
     4      _target = target;
     }
     
     *    如果连个线程同时进行 [_target release]
     */
    
    dispatch_queue_t queue = dispatch_queue_create("parallel", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 1000000 ; i++) {
        dispatch_async(queue, ^{
            self.target = [NSString stringWithFormat:@"ksddkjalkjd%d",i];
        });
    }
}

- (void)testPerformSelector:(id)arg {
    NSLog(@"arg = %@",arg);
}

- (void)test {
    [self performSelector:@selector(testProperty) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
}
@end
