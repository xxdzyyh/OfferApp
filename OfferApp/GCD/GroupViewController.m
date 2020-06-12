//
//  GroupViewController.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/12.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "GroupViewController.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageDownloader.h>

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

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
	
	[self case1];
}

- (void)group {
	
	// 将任务进行组合，可以监听组内任务的状态，如组内任务都完成了。
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
        NSLog(@"GCD Group 所有的任务都完成了，可以进行下一步操作了");
		
		// 这里才是上面任务都完成了的回调

    });
	
	/**
	 虽然放在 dispatch_group_notify 后面，但是并不是在dispatch_group_notify的回调后执行
	 
	 dispatch_group_enter(group);
	 dispatch_group_async(group, queue, ^{
		 void(^block)(void) = ^{
			 sleep(3);
			 dispatch_group_leave(group);
			 NSLog(@"finish");
		 };
		 
		 block();
	 });
	 
	 dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		 NSLog(@"GCD Group 所有的任务都完成了，可以进行下一步操作了");
	 });
	 */
}

- (void)enterLeave {
	dispatch_group_t group = dispatch_group_create();

	void(^block)(NSString *a) = ^(NSString *a){
		sleep(3);
		NSLog(@"%@",a);
		dispatch_group_leave(group);
	};

	dispatch_group_enter(group);
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		block(@"finish 0");
	});


	dispatch_group_enter(group);
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		block(@"finish 1");
	});

	// 因为是异步执行，所以上面两个block几乎是同一时间执行完，这个可以用来完成多个网络请求完成后进行下一步动作
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		NSLog(@"GCD Group 所有的任务都完成了，可以进行下一步操作了");
	});
}

- (void)case1 {
	dispatch_group_t group = dispatch_group_create();

	dispatch_group_enter(group);
	[self asyncTaskWithCompletion:^{
		dispatch_group_leave(group);
	}];


	dispatch_group_enter(group);
	[self asyncTaskWithCompletion:^{
		dispatch_group_leave(group);
	}];

	// 因为是异步执行，所以上面两个block几乎是同一时间执行完，这个可以用来完成多个网络请求完成后进行下一步动作
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		NSLog(@"GCD Group 所有的任务都完成了，可以进行下一步操作了");
	});
}

- (void)asyncTaskWithCompletion:(void(^)(void))completionBlock {
	NSLog(@"asyncTask start");
	[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"https://img.alicdn.com/imgextra/i4/1716499517/O1CN01nm8ud62KApqtVhVbI_!!1716499517.jpg"] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
		NSLog(@"asyncTask finish %@",image);
		if (completionBlock) {
			completionBlock();
		}
	}];
}

- (UIImageView *)imageView {
	if (_imageView == nil) {
		_imageView = [[UIImageView alloc] init];
	}
	return _imageView;
}

@end
