//
//  MyURLProtocol.m
//  OfferApp
//
//  Created by MAC on 2020/11/26.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "MyURLProtocol.h"

@implementation MyURLProtocol

+ (void)load {
//    [NSURLProtocol registerClass:MyURLProtocol.class];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"canInitWithRequest --- %@",request);
    return YES;
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    NSLog(@"canInitWithTask --- %@",task);
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSLog(@"canonicalRequestForRequest --- %@",request);
    return request;
}

//- (void)startLoading {
////    NSURLSession *session = [NSURLSession sessionWithConfiguration:[[NSURLSessionConfiguration alloc] init] delegate:self delegateQueue:nil];
////    NSURLSessionDataTask *task = [session dataTaskWithRequest:self.request];
////    [task resume];
//}
//
//- (void)stopLoading {
//    
//}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return false;
}


- (instancetype)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client {
    NSLog(@"%s",__func__);
    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

@end
