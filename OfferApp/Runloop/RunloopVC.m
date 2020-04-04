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
    
	/**
	 在线程刚创建的时候，对鹰应的runloop是没有的，[NSRunLoop currentRunLoop]执行的时候，如果没有会创建一个NSRunloop。
	 子线程的Runloop是没有开启的,子线程的Runloop是存在的。
	 
	 Runloop和线程的关系保存在一个全局的字典里面，key 是 pthread_t, value 是 CFRunloopRef。
	 
	 static CFMutableDictionaryRef loopsDic;
	 static CFSpinLock_t loopsLock;
	 CFRunloopRef _CGRunloopGet(pthread_t thread) {
		CFSpinLockLock(&loopsLock);
	 
		if (!loopsDic) {
			// 第一次进入，初始化全局Dict,并为主线程创建Runloop
			loopsDic = CFDictionaryCreatMutable();
			CFRunloopRef mainLoop = _CFRunloopCreate();
			CFDictarySetValue(loopsDic,pthread_main_thread_np(),mainLoop);
		}
	 
		CFRunloopRef loop = CFDictionaryGetValue(loopsDic,thread);
	 
		if (!loop) {
			// 取不到是创建一个
			loop = _CFRunloopCreate();
			CFDictionarySetValue(loopsDic,thread,loop);
			// 注册回调，当线程销毁时，销毁对应的Runloop
			_CFSetTSD(...,thread,loop,__CFFinlizeRunloop);
		}
	 
		OSSpinLockUnlock(&loopsLock);
		
		return loop;
	 }
	 
	 */
    [self test4];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // test3 会占用主线程非常长的一段时间，这个时候runloop没有时间去搞别的，
    // 没法触发timer source,导致定时器不准
//    [self test3];
    


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
	[self test5];
}


/**
 VSync ：垂直同步信息有由硬件产生，通过source1 -> mach port 传递给 runloop，
 
 CADisplayLink 基于屏幕刷新频率，如果CPU不堪重负而影响了屏幕刷新，那么我们的触发事件也会受到相应影响。如果test3和test5同时运行，
 在执行test3的时候，cup使用率会升到近100%，此时界面卡主，CADisplayLink的回调也不会触发。
 */
- (void)test5 {
	NSLog(@"%@",[NSRunLoop currentRunLoop]);
	
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink)];
    
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[displayLink invalidate];
	});
}

- (void)displayLink {
    NSLog(@"displayLink");
}

@end
