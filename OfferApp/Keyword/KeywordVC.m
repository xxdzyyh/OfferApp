//
//  KeywordVC.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/12.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "KeywordVC.h"
#import "Son.h"

#define SuperDesc @"super关键字理解"

@interface KeywordVC ()

@end

@implementation KeywordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = @[@{ActionTypeString : @(ActionTypeNone),ActionDescString:SuperDesc,ActionValueString:SuperDesc}];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSDictionary *dict = self.dataSources[indexPath.row];
    
    ActionType type = [dict[ActionTypeString] integerValue];
    NSString *value = dict[ActionValueString];
    
    if (type == ActionTypeNone) {
        if ([value isEqualToString:SuperDesc]) {
            [Son new];
        }  
    } 
}
@end
