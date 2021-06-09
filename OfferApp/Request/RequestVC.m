//
//  RequestVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/6/11.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "RequestVC.h"
#import <AFNetworking/AFNetworking.h>
//#import <OHHTTPStubs/HTTPStubs.h>
//#import <OHHTTPStubs/HTTPStubsResponse.h>
//
@interface RequestVC ()

@end

@implementation RequestVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
//        return [request.URL.host isEqualToString:@"www.jianshu.com"];
//    } withStubResponse:^HTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
//        NSArray *array = @[@"Hello", @"world"];
//        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Empty" ofType:@"json"]];
//        return [HTTPStubsResponse responseWithData:data statusCode:200 headers:nil];
//    }];
    
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:@"http://www.jianshu.com/p/88719de97921" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",task);
    }];
}



@end
