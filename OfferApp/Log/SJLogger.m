//
//     ______    ______    ______
//    /\  __ \  /\  ___\  /\  ___\
//    \ \  __<  \ \  __\_ \ \  __\_
//     \ \_____\ \ \_____\ \ \_____\
//      \/_____/  \/_____/  \/_____/
//
//
//    Copyright (c) 2014-2015, Geek Zoo Studio
//    http://www.bee-framework.com
//
#import "SJLogger.h"

static NSInteger _interval = 0;
@interface SJLogger()

@end

#pragma mark -

@implementation SJLogger

static SJLogger *_logger = nil;

+ (SJLogger *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _logger = [[SJLogger alloc] init];
    });
    return _logger;
}

- (id)init {
	self = [super init];
	if ( self ) {
		self.showLevel = YES;
		self.showModule = YES;
		self.enabled = NO;
		self.indentTabs = 0;
#ifdef DEBUG
        self.logLevel = SJLogLevelInfo;
#else
        self.logLevel = SJLogLevelInfo;
#endif
        _interval = [[NSTimeZone systemTimeZone] secondsFromGMT];
	}
	return self;
}

- (void)toggle {
	_enabled = _enabled ? NO : YES;
}

- (void)enable {
	_enabled = YES;
}

- (void)disable {
	_enabled = NO;
}

- (void)indent {
	_indentTabs += 1;
}

- (void)indent:(NSUInteger)tabs {
	_indentTabs += tabs;
}

- (void)unindent {
	if ( _indentTabs > 0 ) {
		_indentTabs -= 1;
	}
}

- (void)unindent:(NSUInteger)tabs {
	if ( _indentTabs < tabs ) {
		_indentTabs = 0;
	} else {
		_indentTabs -= tabs;
	}
}

- (void)level:(SJLogLevel)level format:(NSString *)format, ... {
    if ( nil == format || NO == [format isKindOfClass:[NSString class]] )
        return;
    
    if ( NO == _enabled )
        return;
    
    if (level < self.logLevel) {
        return;
    }

    va_list args;
    va_start( args, format );
    [self level:level format:format args:args];
    va_end( args );
}

- (void)logWithlevel:(SJLogLevel)level tag:(NSString *)tag func:(NSString *)func file:(NSString *)file line:(NSUInteger)line format:(NSString *)format, ... {
    NSMutableString * text = [NSMutableString string];
    NSMutableString * tabs = nil;
    
    
    va_list args;
    va_start( args, format );
    NSString * content = [[NSString alloc] initWithFormat:(NSString *)format arguments:args];
    va_end( args );
    
    if ( _indentTabs > 0 ) {
        tabs = [NSMutableString string];
        
        for ( int i = 0; i < _indentTabs; ++i )
        {
            [tabs appendString:@"\t"];
        }
    }
    
    NSString *desc = [self getLocalDateWithDate:[NSDate date]].description;
    if (desc.length > 19) {
        desc = [desc substringWithRange:NSMakeRange(5, 14)];
    }
#ifdef APPINSIGHT
    NSString * module = [NSString stringWithFormat:@"AppInsight %@",desc];
#else
    NSString * module = [NSString stringWithFormat:@"BugInsight %@",desc];
#endif

    if ( self.showLevel || self.showModule ) {
        NSMutableString * temp = [NSMutableString string];

        if ( self.showLevel ) {
            if ( SJLogLevelInfo == level ) {
                [temp appendString:@"[INFO ]"];
            } else if ( SJLogLevelDebug == level ) {
                [temp appendString:@"[DEBUG]"];
            } else if ( SJLogLevelWarn == level ) {
                [temp appendString:@"[WARN ]"];
            } else if ( SJLogLevelError == level ) {
                [temp appendString:@"[ERROR]"];
            }
        }

        if ( self.showModule ) {
            if ( module && module.length ) {
                [temp appendFormat:@" [%@]", module];
            }
        }
        
        if ( temp.length ) {
            NSString * temp2 = [temp stringByPaddingToLength:temp.length + 2 withString:@" " startingAtIndex:0];
            [text appendString:temp2];
        }
    }
    
    [text appendString:[NSString stringWithFormat:@"[%lu]",line]];

    if ( tabs && tabs.length ) {
        [text appendString:tabs];
    }
    
    if ( content && content.length ) {
        [text appendString:content];
    }
    
    if ( [text rangeOfString:@"\n"].length ) {
        [text replaceOccurrencesOfString:@"\n"
                              withString:[NSString stringWithFormat:@"\n%@", tabs ? tabs : @"\t\t"]
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange( 0, text.length )];
    }

    if ( [text rangeOfString:@"%"].length ) {
        [text replaceOccurrencesOfString:@"%"
                              withString:@"%%"
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange( 0, text.length )];
    }

    fprintf( stderr, [text UTF8String], NULL );
    fprintf( stderr, "\n", NULL );
}

- (NSDate *)getLocalDateWithDate:(NSDate *)date {
    return [date dateByAddingTimeInterval: _interval];
}

@end
