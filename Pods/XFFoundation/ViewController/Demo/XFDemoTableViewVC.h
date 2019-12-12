//
//  BaseTableViewVC.h
//  LearnRAC
//
//  Created by xiaoniu on 2018/7/5.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 dataSources的结构
 [
    {
        "type" : ActionType,
        "desc" : "desc",
        "value" : "ClassName"
    }
 ]
 */

extern NSString * const ActionTypeString;
extern NSString * const ActionDescString;
extern NSString * const ActionValueString;

typedef NS_ENUM(NSUInteger,ActionType) {
    ActionTypeNone,
    ActionTypeController,
    ActionTypeView,
};

@interface XFDemoTableViewVC : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSources;

@end
