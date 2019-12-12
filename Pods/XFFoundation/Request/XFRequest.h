//
//  XFRequest.h
//  CTQProject
//
//  Created by wangxuefeng on 16/6/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRequestResult.h"
#import "XFRequestQueue.h"

typedef NS_ENUM(NSUInteger,ResponseStatus) {
    ResponseStatusSuccess,
    ResponseStatusBadNetwork,
    ResponseStatusUrlNotFound,
};

@class XFRequest;

typedef void(^XFRequestBlock)(XFRequest *request,id result);

@interface XFRequest : NSObject

#pragma mark - init

/**
 domain+path = 完整Url
 
 @param path        路径
 @param finishBlock 请求回调
 
 @return XFRequest实例对象
 */
- (instancetype)initWithPath:(NSString *)path finish:(XFRequestBlock)finishBlock;

+ (instancetype)url:(NSString *)url finish:(XFRequestBlock)finishBlock;
+ (instancetype)path:(NSString *)path finish:(XFRequestBlock)finishBlock;


#pragma mark - url

+ (NSString *)domain;
+ (void)setDomain:(NSString *)domain;

@property (copy  , nonatomic) NSString *path;
@property (copy  , nonatomic) NSString *url;

#pragma mark - parameters

+ (void)setUseJSONRequestSerializer:(BOOL)useJSONRequestSerializer;

/**
 接口不使用公共参数，默认使用
 */
@property (assign, nonatomic) BOOL notUsePublicParameters;

/**
 如果服务器要求参数使用json格式，设置为YES；默认为NO，普通的表单提交
 */
@property (assign, nonatomic) BOOL useJSONRequestSerializer;

// POST GET
@property (nonatomic, copy) NSString *method;

// 完整的参数，包括公共参数和私有参数
@property (strong, nonatomic) NSDictionary *totalParameters;
@property (strong, nonatomic) NSMutableDictionary *parameters;

/*!  * @brief 添加参数
 * @param value 暂时只支持基本数据类型
 * @param name 参数名
 */
- (void)addParameter:(NSString*)name value:(id)value;

/**
 参数封装成字典，一次性添加多个参数
 
 @param parameters
 */
- (void)addParameters:(NSDictionary*)parameters;

@property (strong, nonatomic) XFRequestBlock finishBlock;
@property (assign, nonatomic, getter=isCancel) BOOL cancel;

/**
 公共参数
 
 @return 公共参数
 */
+ (NSMutableDictionary *)publicParameters;
+ (void)addPublicParameter:(NSString *)name value:(id)value;
+ (void)addPublicParameters:(NSDictionary *)parameters;
+ (void)removePublicParameter:(NSString *)name;

/**
 公共头部
 
 @return 公共头部
 */
+ (NSMutableDictionary *)publicHeaderFields;
+ (void)addPublicHeaderField:(NSString *)key value:(id)value;
+ (void)addPublicHeaderField:(NSDictionary *)headFields;
+ (void)removePublicHeaderFieldForKey:(NSString *)key;

#pragma mark - 执行

/**
 *  调用执行，才会真正开始请求数据
 */
- (void)start;

/**
 暂时没有实现
 */
- (void)cancel;

/**
 真正的发送请求

 @param completion 
 */
- (void)execute:(void(^)(XFRequest *request,ResponseStatus status))completion;

#pragma mark - 运行状态监听,避免hook才能获取

- (void)requestDidFinished:(id)result;

@end
