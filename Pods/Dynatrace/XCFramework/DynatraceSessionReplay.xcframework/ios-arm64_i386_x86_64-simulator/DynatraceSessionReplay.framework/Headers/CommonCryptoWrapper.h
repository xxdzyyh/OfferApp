//
//  CommonCryptoWrapper.h
//  DTTrackingSDK
//
//  Created by Delfin Pereiro Parejo on 25/04/2017.
//  Copyright © 2017 Dynatrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonCryptoWrapper : NSObject

+(NSString*) md5:(NSData *)data;

@end
