//
//  RequestVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/6/11.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "RequestVC.h"
#import <AFNetworking/AFNetworking.h>

@interface RequestVC ()

@end

@implementation RequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
	
	[manager setDataTaskWillCacheResponseBlock:^NSCachedURLResponse * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSCachedURLResponse * _Nonnull proposedResponse) {
		NSLog(@"%@",proposedResponse);
		return  proposedResponse;
	}];
	
	[manager GET:@"http://www.jianshu.com/p/88719de97921" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSLog(@"%@",responseObject);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"%@",error);
	}];
}



@end
