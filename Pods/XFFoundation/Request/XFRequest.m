//
//  XFRequest.m
//  CTQProject
//
//  Created by wangxuefeng on 16/6/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFRequest.h"
#import <AFNetworking/AFNetworking.h>

static NSMutableDictionary *_publicParameters = nil;
static NSMutableDictionary *_publicHeaderFields = nil;

static NSString *_domain = nil;
static BOOL _staticUseJSONRequestSerializer = false;

@interface XFRequest () {
    BOOL _useJSONRequestSerializerReady;
}

@end

@implementation XFRequest

#pragma mark - life cycle

- (instancetype)initWithPath:(NSString *)path finish:(XFRequestBlock)finishBlock {
    self = [super init];
    if (self) {
        _path = path;
        _finishBlock = finishBlock;
        _method = @"GET";
        [self setUseJSONRequestSerializer:YES];
    }
    return self;
}

+ (XFRequest *)url:(NSString *)url finish:(XFRequestBlock)finishBlock {
    
    XFRequest *request = [XFRequest new];
    
    request.finishBlock = finishBlock;
    request.url = url;
    request.method = @"GET";
    return request;
}

+ (instancetype)path:(NSString *)path finish:(XFRequestBlock)finishBlock {
    
    XFRequest *request = [[self class] new];
    
    request.finishBlock = finishBlock;
    request.path = path;
    request.useJSONRequestSerializer = YES;
    
    return request;
}

- (void)start {
    [self execute:nil];
}

- (void)cancel {
	_cancel = YES;
}

#pragma mark - subclass should override

+ (NSString *)domain {
	return _domain;
}

+ (void)setDomain:(NSString *)domain {
	_domain = domain;
}

+ (void)setUseJSONRequestSerializer:(BOOL)useJSONRequestSerializer {
    _staticUseJSONRequestSerializer = useJSONRequestSerializer;
}

- (void)setUseJSONRequestSerializer:(BOOL)useJSONRequestSerializer {
    _useJSONRequestSerializer = useJSONRequestSerializer;
    _useJSONRequestSerializerReady = YES;
}

- (NSDictionary *)totalParameters {
    if (_totalParameters == nil) {
        if (self.notUsePublicParameters) {
            _totalParameters = [self.parameters copy];
        } else {
            NSMutableDictionary *dict = [_publicParameters mutableCopy] ?: [NSMutableDictionary dictionary];
            NSMutableDictionary *para = self.parameters;
            
            if (para.allValues.count > 0) {
                [dict addEntriesFromDictionary:para];
            }
            _totalParameters = dict;
        }
    }
    return _totalParameters;
}

- (void)execute:(void (^)(XFRequest *request, ResponseStatus status))completion {
    
    NSString *path = self.path;
    
    NSString *url = nil;
    
    if (self.path) {
        url = [NSString stringWithFormat:@"%@%@",[[self class] domain],path];
		self.url = url;
    } else {
        url = self.url;
    }
	
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 如果设置了属性useJSONRequestSerializer，属性优先
    BOOL useJSONRequestSerializer = self.useJSONRequestSerializer;
    
    // 如果没有设置属性，使用类配置
    if (_useJSONRequestSerializerReady == false) {
        useJSONRequestSerializer = _staticUseJSONRequestSerializer;
    }
    
    if (useJSONRequestSerializer) {
        manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    } else {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =
    [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/plain",@"text/html"]];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // 添加公共HeadField
    if (_publicHeaderFields.allKeys.count > 0) {
        for (NSString *key in _publicHeaderFields.allKeys) {
            [manager.requestSerializer setValue:_publicHeaderFields[key] forHTTPHeaderField:key];
        }
    }
    
    manager.requestSerializer.timeoutInterval = 60;
    
    id successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        
        if (result == nil) {
            result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]; 
        }
        
#ifdef DEBUG
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",self.totalParameters);
        NSLog(@"result:%@",result);
#endif
		[self requestDidFinished:result];
		
        if (self.finishBlock) {
            self.finishBlock(self,result);
        }
        
        // 通知 requestQueue
        if (completion) {
            completion(self,ResponseStatusSuccess);
        }
    };
    
    id failureBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = @{ @"msg" : [error.userInfo objectForKey:NSLocalizedDescriptionKey] ?: @"",
                                @"error_code" : @(error.code) };
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
		
		[self requestDidFinished:dict];
        
        if (self.finishBlock) {
            self.finishBlock(self,dict);
        }
        
        // 通知 requestQueue
        if (completion) {
            if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
                completion(self,ResponseStatusBadNetwork);
            } else {
                completion(self,ResponseStatusUrlNotFound);
            }
        }
        
#ifdef DEBUG
        NSLog(@"url:%@",url);
        NSLog(@"parameters:%@",self.totalParameters);
        NSLog(@"error:%@",error);
#endif
    };

    if ([self.method isEqualToString:@"GET"]) {
        [manager GET:url parameters:self.totalParameters headers:nil progress:nil success:successBlock failure:failureBlock];
    } else {
        [manager POST:url parameters:self.totalParameters headers:nil progress:nil success:successBlock failure:failureBlock];
    }
}

#pragma mark - 公共参数

+ (NSMutableDictionary *)publicParameters {
	return _publicParameters;
}

+ (void)addPublicParameter:(NSString *)name value:(id)value {
    if (_publicParameters == nil) {
        _publicParameters = [NSMutableDictionary dictionary];
    }
    
    if (name.length == 0 || value == nil) {
        return;
    }
    
    [_publicParameters setObject:value forKey:name];
}

+ (void)addPublicParameters:(NSDictionary *)parameters {
	for (NSString *key in parameters.allKeys) {
		[self addPublicParameter:key value:parameters[key]];
	}
}

+ (void)removePublicParameter:(NSString *)name {
	[_publicParameters removeObjectForKey:name];
}

#pragma mark - 添加参数

-(void)addParameter:(NSString *)name value:(id)value {
	// 防止参数名为空，插入值nil
    if (name.length == 0 || value == nil) {
        return;
    }
	
	if (self.parameters == nil) {
		self.parameters = [NSMutableDictionary dictionary];
	}
	
    [self.parameters setObject:value forKey:name];
}

- (void)addParameters:(NSDictionary *)parameters {
    for (NSString *key in parameters.allKeys) {
        [self addParameter:key value:parameters[key]];
    }
}

#pragma mark - 公共头部

+ (NSMutableDictionary *)publicHeaderFields {
    return _publicHeaderFields;
}

+ (void)addPublicHeaderField:(NSDictionary *)headFields {
    for (NSString *key in headFields) {
        [self addPublicHeaderField:key value:headFields];
    }
}

+ (void)addPublicHeaderField:(NSString *)key value:(id)value {
    if (_publicHeaderFields == nil) {
        _publicHeaderFields = [NSMutableDictionary dictionary];
    }
    
    if (key.length == 0 || value == nil) {
        return;
    }
    [_publicHeaderFields setObject:value forKey:key];
}

+ (void)removePublicHeaderFieldForKey:(NSString *)key {
    [_publicHeaderFields removeObjectForKey:key];
}

#pragma mark - 运行状态监听

- (void)requestDidFinished:(id)result {
	
}

@end
