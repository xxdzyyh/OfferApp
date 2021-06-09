//
//  DTTrackingSDK.h
//  DTTrackingSDK
//
//  Created by Delfin Pereiro Parejo on 25/08/16.
//  Copyright © 2016 Dynatrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Dynatrace/Dynatrace.h>

//! Project version number for DTTrackingSDK.
FOUNDATION_EXPORT double DTTrackingSDKVersionNumber;

//! Project version string for DTTrackingSDK.
FOUNDATION_EXPORT const unsigned char DTTrackingSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DTTrackingSDK/PublicHeader.h>
#import <DynatraceSessionReplay/CommonCryptoWrapper.h>

@interface Dynatrace (MRALogging)
    + (DTX_StatusCode)logMessage:(NSString *)message withLevel:(NSInteger)logLevel andCategory:(NSInteger)diagCategory force:(BOOL)force;
@end
