//
//  XFDevice.m
//  AFNetworking
//
//  Created by xiaoniu on 2018/11/15.
//

#import "XFDevice.h"

#import <SAMKeychain/SAMKeychain.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>
#import <stdio.h>
#import <stdlib.h>
#import <AdSupport/AdSupport.h>

@implementation XFDevice

+ (XFDevice *)shareDevice {
    static XFDevice *_share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [XFDevice new];
    });
    return _share;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _iPhoneModel    = [self getNotEmptyString:[self getiPhoneModel]];
        _deviceId       = [self getNotEmptyString:[self getDeviceId]];
        _idfa           = [self getNotEmptyString:[self getIDFA]];
        _idfv           = [self getNotEmptyString:[self getIDFV]];
        _ssid           = [self getNotEmptyString:[self getSSID]];
        _bundleID       = [self getNotEmptyString:[self getBundleID]];
        _appVersion     = [self getNotEmptyString:[self getLocalAppVersion]];
        _osVersion      = [self getNotEmptyString:[self getIOSVersion]];
    }
    return self;
}

- (NSString *)getNotEmptyString:(NSString *)string {
    if (string && [string isKindOfClass:[NSString class]] && string.length) {
        return string;
    } else {
        return @"";
    }
}

#pragma mark - private
- (NSString *)getIOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)getLocalAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)getBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)getiPhoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])
    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])
    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])
    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])
    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])
    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])
    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])
    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])
    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])
    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])
    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])
    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])
    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])
    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])
    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])
    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])
    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])
    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"] ||
        [deviceString isEqualToString:@"iPhone9,3"])
    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"] ||
        [deviceString isEqualToString:@"iPhone9,4"])
    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPod1,1"])
    return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])
    return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])
    return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])
    return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])
    return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPad1,1"])
    return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])
    return @"iPad 2 Wi-Fi";
    if ([deviceString isEqualToString:@"iPad2,2"])
    return @"iPad 2 Wi-Fi+3G+GSM";
    if ([deviceString isEqualToString:@"iPad2,3"])
    return @"iPad 2 Wi-Fi+3G+GSM+CDMA";
    if ([deviceString isEqualToString:@"iPad2,4"])
    return @"iPad 2 Wi-Fi";
    if ([deviceString isEqualToString:@"iPad2,5"])
    return @"iPad mini Wi-Fi";
    if ([deviceString isEqualToString:@"iPad2,6"])
    return @"iPad mini Wi-Fi+3G+4G+GSM";
    if ([deviceString isEqualToString:@"iPad2,7"])
    return @"iPad mini Wi-Fi+3G+4G+GSM+CDMA";
    if ([deviceString isEqualToString:@"iPad3,1"])
    return @"iPad 3 Wi-Fi";
    if ([deviceString isEqualToString:@"iPad3,2"])
    return @"iPad 3 Wi-Fi+3G+GSM+CDMA";
    if ([deviceString isEqualToString:@"iPad3,3"])
    return @"iPad 3 Wi-Fi+3G+GSM";
    if ([deviceString isEqualToString:@"iPad3,4"])
    return @"iPad 4 Wi-Fi";
    if ([deviceString isEqualToString:@"iPad3,5"])
    return @"iPad 4 Wi-Fi+3G+4G+GSM";
    if ([deviceString isEqualToString:@"iPad3,6"])
    return @"iPad 4 Wi-Fi+3G+4G+GSM+CDMA ";
    return deviceString;
}

- (NSString *)getDeviceId {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *currentDeviceUUIDStr = [SAMKeychain passwordForService:bundleIdentifier account:@"uuid"];
    
    if (currentDeviceUUIDStr == nil || !currentDeviceUUIDStr.length) {
        NSUUID *currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword:currentDeviceUUIDStr forService:bundleIdentifier account:@"uuid"];
    }
    
    return currentDeviceUUIDStr;
}

- (NSString *)getIDFA {
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (idfa && idfa.length) {
            return idfa;
        } else {
            return [self getIDFV];
        }
    } else {
        return [self getIDFV];
    }
}

- (NSString *)getIDFV {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)getSSID {
    NSString *wifiName = @"";
    NSArray *interFaceNames = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *name in interFaceNames) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)name);
        if (info && [info isKindOfClass:[NSDictionary class]]) {
            NSString *ssid = info[@"SSID"];
            if (ssid && [ssid isKindOfClass:[NSString class]] && ssid.length) {
                wifiName = ssid;
                break;
            }
        }
    }
    return wifiName;
}


@end
