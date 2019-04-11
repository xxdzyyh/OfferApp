//
//  RuntimeVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/4/9.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "RuntimeVC.h"
#import "RPerson.h"

@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSources = @[@{ActionTypeString:@(ActionTypeNone),ActionValueString:@"test"}];
    
    id cls = [RPerson class];
    void *obj = &cls;
    [(__bridge id)obj sayHello];
}

- (void)test {
    id cls = [RPerson class];
    void *obj = &cls;
    [(__bridge id)obj sayHello];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * item = self.dataSources[indexPath.row];
    int type = [item[ActionTypeString] intValue];
    
    if (type == ActionTypeNone) {
        [self test];
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
