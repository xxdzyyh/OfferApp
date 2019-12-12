//
//  RACObserverVC.m
//  OfferApp
//
//  Created by jmf66 on 2019/11/28.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "RACObserverVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface Anchor : NSObject

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *uid;

@end

@implementation Anchor

- (void)updateUid {
    [self willChangeValueForKey:@"uid"];
    _uid = @"002";
    [self didChangeValueForKey:@"uid"];
}

- (void)setUid:(NSString *)uid {
    [self willChangeValueForKey:@"uid"];
    _uid = uid;
    [self didChangeValueForKey:@"uid"];
}

@end

@interface LiveRoom : NSObject

@property (strong, nonatomic) Anchor *anchor;
@property (nonatomic ,copy) NSString *anchorName;
@property (nonatomic ,copy) NSString *anchorUid;

@end

@implementation LiveRoom

- (instancetype)initWithAnchor:(Anchor *)anchor {
	self = [super init];
	if (self) {
		self.anchor = anchor;
		
		[self bind];
	}
	return self;
}

- (void)bind {
	RAC(self,anchorName) = RACObserve(self.anchor, name);
	RAC(self, anchorUid) = RACObserve(self, anchor.uid);
}

@end

@interface RACObserverVC ()

@property (strong, nonatomic) LiveRoom *liveRoom;

@end

@implementation RACObserverVC

- (void)viewDidLoad {
    [super viewDidLoad];

	self.liveRoom = [[LiveRoom alloc] initWithAnchor:nil];
	
	NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
	
	Anchor *anchor = [[Anchor alloc] init];
	
	anchor.name = @"Saber";
	anchor.uid = @"001";
	
	self.liveRoom.anchor = anchor;
    
    RAC(self.liveRoom,anchorName) = RACObserve(self.liveRoom.anchor, name);
	
	NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
    
    [anchor updateUid];
    
    NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
    
    Anchor *anchor2 = [[Anchor alloc] init];
    
    anchor2.name = @"Anch0r";
    anchor2.uid = @"003";
    
    self.liveRoom.anchor = anchor2;
    
    NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
    
}


@end
