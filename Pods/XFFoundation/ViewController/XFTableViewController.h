//
//  XFTableViewController.h
//  CTQProject
//
//  Created by wangxuefeng on 16/5/28.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFViewController.h"
#import "XFEmptyView.h"
#import "XFSeperatorCell.h"

@protocol XFCellDelegate <NSObject>

@optional

/**
 返回cell对应的class,必须是XFTableViewCell子类
 
 @return XFTableViewCell 子类
 */
- (Class)cellClass;

/**
 
 返回cell对应的class,必须是 XFTableViewCell 子类

 @param indexPath cell indexPath
 @return XFTableViewCell 子类
 */
- (Class)cellClassForCellAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)cellHeight;
- (CGFloat)cellHeigthForCellAtIndexPath:(NSIndexPath *)indexPath;

- (Class)modelClass;
- (Class)modelClassForCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XFTableViewController : XFViewController <UITableViewDelegate, UITableViewDataSource, XFCellDelegate>

// getter
- (UITableView *)tableView;
- (XFEmptyView *)emptyView;

- (void)showEmptyView;

- (void)hiddenEmptyView;

@property (copy  , nonatomic) NSString *emptyTitle;
@property (copy  , nonatomic) NSString *emptyImageName;
@property (strong, nonatomic) NSMutableArray *dataSource;

+ (float)heightForLableWithText:(NSString *)text font:(UIFont *)font perferWidth:(float)width;

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
