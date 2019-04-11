//
//  XFTableViewController.h
//  CTQProject
//
//  Created by wangxuefeng on 16/5/28.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFViewController.h"
#import "XFEmptyView.h"

@interface XFTableViewController : XFViewController <UITableViewDelegate, UITableViewDataSource>

// getter
- (UITableView *)tableView;
- (XFEmptyView *)emptyView;

- (void)showEmptyView;

- (void)hiddenEmptyView;

@property (copy  , nonatomic) NSString *emptyTitle;
@property (copy  , nonatomic) NSString *emptyImageName;
@property (strong, nonatomic) NSMutableArray *dataSource;

- (UITableViewCell *)seperatorCell;

- (float)seperatorCellHeight;

+ (float)heightForLableWithText:(NSString *)text font:(UIFont *)font perferWidth:(float)width;

- (void)refreshTableView;

- (UITableViewCell *)emptyCellWithImageName:(NSString *)imageName title:(NSString *)title;


/**
 表格顶部的留白，使用tableHeaderView来使用

 @param color  背景颜色
 @param height 高度

 @return 返回的view
 */
- (UIView *)tableHeaderWithBackgroundColor:(UIColor *)color height:(float)height;


- (UIView *)defaultTableHeaderView;
@end
