//
//  RunloopVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/18.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "RunloopVC.h"
#import "MemoryObj.h"

@interface RunloopVC () {
    CFRunLoopObserverRef observer;
}

@end

@implementation RunloopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self test];
    
    [self test5];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // test3 会占用主线程非常长的一段时间，这个时候runloop没有时间去搞别的，
    // 没法触发timer source,导致定时器不准
//    [self test3];
    
//    [self test4];
}

/**
 监听 Runloop 状态变化
 */
- (void)test {

    observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), 
                                       kCFRunLoopAllActivities, 
                                       YES, 0,
                                       ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity){
        
                                           switch (activity) {
                                               case kCFRunLoopEntry:
                                                   NSLog(@"即将进入runloop");
                                                   break;
                                               case kCFRunLoopBeforeTimers:
                                                   NSLog(@"即将处理timer事件");
                                                   break;
                                               case kCFRunLoopBeforeSources:
                                                   NSLog(@"即将处理source事件");
                                                   break;
                                               case kCFRunLoopBeforeWaiting:
                                                   NSLog(@"即将进入睡眠");
                                                   break;
                                               case kCFRunLoopAfterWaiting:
                                                   NSLog(@"被唤醒");
                                                   break;
                                               case kCFRunLoopExit:
                                                   NSLog(@"runloop退出");
                                                   break;
                                                   
                                               default:
                                                   break; 
                                           }
                                           
    });
    
    // 主线程卡顿监测
    // 如果 runloop kCFRunLoopAfterWaiting到 kCFRunLoopBeforeWaiting 中间间隔了很长一段时间，就可以肯定主线程卡顿了
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
}

- (void)dealloc {
    if (observer) {
        CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
        CFRelease(observer);
    }
}

/**
 耗时操作会影响 runloop 状态转换
 */
- (void)test3 {
    int count = 0;
    for (int i=0; i<1000000000; i++) {
        count++;
//        NSString *string = @"wwww";
//        NSLog(@"%@",string);
    }
    NSLog(@"test 3");
}

/**
 子线程 runloop 默认不会开启
 */
- (void)test4 {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(asyncTask) object:nil];
    
    thread.name = @"www";
    
    [thread start];
}

- (void)asyncTask {
    NSLog(@"%@",[NSThread currentThread]);
   id __autoreleasing obj = [MemoryObj memoryObj];
    
    
    [self test3];
    
    NSLog(@"%@",obj);
    NSLog(@"%@",[NSThread currentThread]);
}


/**
 VSync ：垂直同步信息有由硬件产生，通过source1 -> mach port 传递给 runloop，
 
 CADisplayLink 基于屏幕刷新频率，如果CPU不堪重负而影响了屏幕刷新，那么我们的触发事件也会受到相应影响。如果test3和test5同时运行，
 在执行test3的时候，cup使用率会升到近100%，此时界面卡主，CADisplayLink的回调也不会触发。
 */
- (void)test5 {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink)];
    
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode]; 
}

- (void)displayLink {
    NSLog(@"displayLink");
}

@end
