//
//  XFRefreshTableViewController.h
//  CTQProject
//
//  Created by wangxuefeng on 16/7/4.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFTableViewController.h"

#import <MJRefresh.h>

@interface XFRefreshTableViewController : XFTableViewController

@property (strong, nonatomic) MJRefreshHeader *refreshHeader;
@property (strong, nonatomic) MJRefreshFooter *refreshFooter;

/*! page: 当前页码*/
@property (assign, nonatomic) NSInteger page;

/*! 翻页的第一页从哪里开始，默认1*/
- (NSInteger)startPage;

/*! 是否有更多数据，用来控制加载更多**/
@property (assign, nonatomic) BOOL hasMoreData;

/*! 能否上拉加载更多，默认YES */
@property (assign, nonatomic) BOOL canAppendData;

/*! 能否下拉刷新 ，默认YES */
@property (assign, nonatomic) BOOL canUpdateData;

/*！触发下拉刷新时调用该方法 */
- (void)updateData;

/* 触发上拉加载更多时调用该方法 */
- (void)appendData;


@end
