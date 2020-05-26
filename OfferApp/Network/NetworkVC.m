//
//  NetworkVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/20.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "NetworkVC.h"
#import <AFNetworking/AFNetworking.h>

@interface NetworkVC () <NSURLSessionDelegate>

@end

@implementation NetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self urlSession];
}

/**
 关于 AFHTTPSessionManager 内存释放问题，manager持有属性session，session的delegate被设置为
 manager,注意这个delegate释放的前提是delegate收到消息URLSession:didBecomeInvalidWithError:.
 这里是循环引用，要打断这个这个循环，需要调用 -[AFHTTPSessionManager invalidateSessionCancelingTasks:YES]
 
 manager ----> session
 session.delegate = manager

  * Customization of NSURLSession occurs during creation of a new session.
  * If you only need to use the convenience routines with custom
  * configuration options it is not necessary to specify a delegate.
  * If you do specify a delegate, the delegate will be retained until after
  * the delegate has been sent the URLSession:didBecomeInvalidWithError: message.
  
 + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
 
 
 从设计上来讲，session在多个请求中是可以共用的，不需要每次都重新开始TCP握手那一套，所以建议AFHTTPSessionManager
 设置为单例模式。
 */
- (void)whyShareManager {
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	
	[manager GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		// 如果manager出了这个代码块就被释放，那回调的block就不会执行，现在回调已经被执行了。
		NSLog(@"%@",responseObject);
		
		// 不调用下面的方法，manager就不会释放，引起内存泄漏
		[manager invalidateSessionCancelingTasks:YES];
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"%@",error);
	}];
}


- (void)urlSession {
	/**
	 如果只是常规的请求，不需要设置delegate
	 */
	NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
														  delegate:self
													 delegateQueue:[NSOperationQueue mainQueue]];
	
	NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.baidu.com"]
										completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		id obj = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
		NSLog(@"%@",obj);
		// 下面2选1实现，如果没有实现session也不会被释放
		// [session invalidateAndCancel];
		[session finishTasksAndInvalidate];
	}];
	
	[task resume];
	
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
	NSLog(@"%s",__func__);
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
	NSLog(@"%s",__func__);
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
	NSLog(@"%s",__func__);
}

@end
