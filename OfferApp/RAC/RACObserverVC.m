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
	
	// 如果self.anchor为nil，这个绑定就是无效的
	// self.anchor不为nil时，设置新的值，self.anchorName不会改变
	RAC(self,anchorName) = RACObserve(self.anchor, name);
	
	// 当self.anchor发生改变时，self.anchorUid会及时变更
	RAC(self, anchorUid) = RACObserve(self, anchor.uid);
}

@end

@interface RACObserverVC ()

@property (strong, nonatomic) LiveRoom *liveRoom;

@end

@implementation RACObserverVC

- (void)viewDidLoad {
    [super viewDidLoad];

	Anchor *anchor0 = [[Anchor alloc] init];
	
	anchor0.name = @"zero";
	anchor0.uid = @"000";
	
	self.liveRoom = [[LiveRoom alloc] initWithAnchor:anchor0];
	
	NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
	
	Anchor *anchor = [[Anchor alloc] init];
	
	anchor.name = @"Saber";
	anchor.uid = @"001";
	
	self.liveRoom.anchor = anchor;
    
    RAC(self.liveRoom,anchorName) = RACObserve(self.liveRoom.anchor, name);
	
	NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
	
	anchor.name = @"tony";
	anchor.uid = @"002";
	
	NSLog(@"anchorName=%@  anchorUid=%@",self.liveRoom.anchorName,self.liveRoom.anchorUid);
	
}


@end
