//
//	 ______    ______    ______
//	/\  __ \  /\  ___\  /\  ___\
//	\ \  __<  \ \  __\_ \ \  __\_
//	 \ \_____\ \ \_____\ \ \_____\
//	  \/_____/  \/_____/  \/_____/
//
//
//	Copyright (c) 2014-2015, Geek Zoo Studio
//	http://www.bee-framework.com
//
#import "SJLogger.h"
#import <Foundation/Foundation.h>

#pragma mark -

typedef enum
{
	SJLogLevelNone		= 0,
    SJLogLevelDebug     = 1,
	SJLogLevelInfo		= 2,
	SJLogLevelWarn		= 3,
	SJLogLevelError	    = 4 
} SJLogLevel;

#pragma mark -

#define SJLogInfo( ... )        [[SJLogger sharedInstance] logWithlevel:SJLogLevelInfo tag:nil func:NSStringFromSelector(_cmd) file:[NSString stringWithUTF8String:__FILE__] line:__LINE__ format:__VA_ARGS__];
#define SJLogDebug( ... )       [[SJLogger sharedInstance] logWithlevel:SJLogLevelDebug tag:nil func:NSStringFromSelector(_cmd) file:[NSString stringWithUTF8String:__FILE__] line:__LINE__ format:__VA_ARGS__];
#define SJLogWarn( ... )        [[SJLogger sharedInstance] logWithlevel:SJLogLevelWarn tag:nil func:NSStringFromSelector(_cmd) file:[NSString stringWithUTF8String:__FILE__] line:__LINE__ format:__VA_ARGS__];
#define SJLogError( ... )       [[SJLogger sharedInstance] logWithlevel:SJLogLevelError tag:nil func:NSStringFromSelector(_cmd) file:[NSString stringWithUTF8String:__FILE__] line:__LINE__ format:__VA_ARGS__];

@interface SJLogger : NSObject

@property (nonatomic, assign) BOOL				showLevel;
@property (nonatomic, assign) BOOL				showModule;
@property (nonatomic, assign) BOOL				enabled;
@property (nonatomic, assign) NSUInteger		indentTabs;

@property (nonatomic, assign) BOOL useLogInsight;
@property (nonatomic, assign) SJLogLevel logLevel;

+ (SJLogger *)sharedInstance;

- (void)toggle;
- (void)enable;
- (void)disable;

- (void)indent;
- (void)indent:(NSUInteger)tabs;
- (void)unindent;
- (void)unindent:(NSUInteger)tabs;

- (void)level:(SJLogLevel)level format:(NSString *)format, ...;
- (void)level:(SJLogLevel)level format:(NSString *)format args:(va_list)args;

- (void)logWithlevel:(SJLogLevel)level tag:(NSString *)tag func:(NSString *)func file:(NSString *)file line:(NSUInteger)line format:(NSString *)format, ...;

@end
