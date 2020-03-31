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
#import "AtomicTest.h"

@interface MultiThreadVC ()

@property (strong, nonatomic) NSString *target;

@end

@implementation MultiThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = @[@{ActionTypeString : @(ActionTypeNone),ActionDescString:@"setter多线程闪退",ActionValueString:@"setter多线程闪退"},
	@{ActionTypeString : @(ActionTypeNone),ActionDescString:@"Atomic",ActionValueString:@"Atomic"}];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    ActionType type = [dict[ActionTypeString] integerValue];
    NSString *value = dict[ActionValueString];
    
    if (type == ActionTypeNone) {
        if ([value isEqualToString:@"setter多线程闪退"]) {
            [self testProperty];
		} else if ([value isEqualToString:@"Atomic"]) {
			[self testAtomic];
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

- (void)testAtomic {
	// atomic 使得setter是原子操作，所以是线程安全的，但是从属性的读写看，这个属性并不是线程安全的。
	// 多个线程进行写操作，最后的结果是不缺定的，因为线程执行的顺序是不确定的。
	
	AtomicTest *obj = [AtomicTest new];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		obj.lastName = @"Tom";
		NSLog(@"%@",obj.lastName);
	});
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		obj.lastName = @"sam";
		NSLog(@"%@",obj.lastName);
	});
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		obj.lastName = @"tony";
		NSLog(@"%@",obj.lastName);
	});
	
	// 上面三个线程执行的顺序是不确定的
	/**
	 2020-03-31 16:24:59.318210+0800 OfferApp[18136:2183049] Tom
	 2020-03-31 16:24:59.318307+0800 OfferApp[18136:2183050] sam
	 2020-03-31 16:24:59.318392+0800 OfferApp[18136:2183372] tony
	 
	 2020-03-31 16:25:02.762292+0800 OfferApp[18136:2183049] Tom
	 2020-03-31 16:25:02.762310+0800 OfferApp[18136:2183050] tony
	 2020-03-31 16:25:02.762331+0800 OfferApp[18136:2183372] sam
	 */
}

@end
