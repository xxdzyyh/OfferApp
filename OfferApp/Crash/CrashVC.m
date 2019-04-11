//
//  CrashVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/28.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "CrashVC.h"

@interface CrashVC ()

@end

@implementation CrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSources = @[@{ActionTypeString:@(ActionTypeNone),ActionValueString:@"for in crash",ActionDescString:@"for in crash"}
                         
                         ];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    NSString *value = dict[ActionValueString];
    NSUInteger type = [dict[ActionTypeString] integerValue];
    
    if (type == ActionTypeNone) {
        
        if ([value isEqualToString:@"for in crash"]) {
            [self forinCrash];
        }
        
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)forinCrash {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"aaa",@"bbb",@"ccc", nil];
    
    // 1.crash was mutated while being enumerated.
    //    for (NSString *obj in array) {
    //        NSLog(@"%@",obj);
    //        [array addObject:@"ddd"];
    //    }
    
    for (NSString *obj in [array copy]) {
        NSLog(@"%@",obj);
        [array addObject:@"ddd"];
    }
}

@end
