//
//  GCDHomeVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/4/2.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "GCDHomeVC.h"

@interface GCDHomeVC ()

@end

@implementation GCDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.dataSources = @[@{ActionTypeString:@(ActionTypeController),ActionValueString:@"GroupViewController"},
						 @{ActionTypeString:@(ActionTypeController),ActionValueString:@"SyncAndAsyncVC"}];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * item = self.dataSources[indexPath.row];
    int type = [item[ActionTypeString] intValue];
    NSString *methodName = item[ActionValueString];
    
    if (type == ActionTypeNone) {
        [self performSelector:NSSelectorFromString(methodName)];
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
