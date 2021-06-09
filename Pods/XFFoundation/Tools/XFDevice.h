//
//  XFDevice.h
//  AFNetworking
//
//  Created by xiaoniu on 2018/11/15.
//

#import <UIKit/UIKit.h>

@interface XFDevice : NSObject

+ (XFDevice *)shareDevice;

/**
 手机型号 "iPhone 7" "iPhone 7 Plus"
 */
@property (nonatomic, copy, readonly) NSString *iPhoneModel;

/**
 uuid+Keychain
 */
@property (nonatomic, copy, readonly) NSString *deviceId;

/**
 广告标识码，如果不支持idfa或者用户将idfa关闭，则返回uuid
 */
@property (nonatomic, copy, readonly) NSString *idfa;

/**
 uuid
 */
@property (nonatomic, copy, readonly) NSString *idfv;

/**
 WIFI名称
 */
@property (nonatomic, copy, readonly) NSString *ssid;

/**
 bundleID
 */
@property (nonatomic, copy, readonly) NSString *bundleID;

/**
 系统版本
 */
@property (nonatomic, copy, readonly) NSString *osVersion;

/**
 应用版本号version
 */
@property (nonatomic, copy, readonly) NSString *appVersion;


@end

