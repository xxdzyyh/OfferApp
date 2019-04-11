//
//  XFRefreshTableViewController.m
//  CTQProject
//
//  Created by wangxuefeng on 16/7/4.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFRefreshTableViewController.h"

#import <MJRefresh/MJRefresh.h>

#import "XFConfig.h"

@interface XFRefreshTableViewController ()

@end

@implementation XFRefreshTableViewController

@synthesize refreshHeader = _refreshHeader;
@synthesize refreshFooter = _refreshFooter;

- (instancetype)init {
    self = [super init];
    if (self) {
        _canUpdateData = YES;
        _canAppendData = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    // default
    if (_canUpdateData) {
        MJRefreshHeader *header = [XFConfig sharedXFConfig].refreshHeader;
        
        if (header == nil) {
            header =  [[MJRefreshNormalHeader alloc] init];
        }
        
        [header setRefreshingTarget:self refreshingAction:@selector(updateData)];
        
        self.tableView.mj_header =  header;
    } else {
        
        [self.tableView setMj_header:nil];
    }
    
    if (_canAppendData) {
        MJRefreshFooter *footer = [XFConfig sharedXFConfig].refreshFooter;
        
        if (footer == nil) {
            footer = [[MJRefreshBackNormalFooter alloc] init];
        }
        
        [footer setRefreshingTarget:self refreshingAction:@selector(appendData)];
        
        self.refreshFooter = footer;
    } else {
        
        [self.tableView setMj_footer:nil];
    }
}

#pragma mark - override point

- (void)appendData {
    self.page = 1;
    [self sendDefaultRequest];
}

- (void)updateData {
    if (self.hasMoreData) {
        self.page++;
        [self sendDefaultRequest];
    }
}

#pragma mark - setter & getter

- (void)setCanUpdateData:(BOOL)canUpdateData {
    _canUpdateData = canUpdateData;
    
    if (canUpdateData) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    } else {
        self.refreshHeader = self.refreshHeader;
    }
}

- (void)setCanAppendData:(BOOL)canAppendData {
    _canAppendData = canAppendData;
    
    if (canAppendData) {
        self.refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(appendData)];
    } else {
        self.refreshFooter = nil;
    }
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    [super setDataSource:dataSource];
    
    if (dataSource.count == 0) {
        self.hasMoreData = NO;
    }
}

- (void)setRefreshHeader:(MJRefreshHeader *)refreshHeader {
    _refreshHeader = refreshHeader;
    
    self.tableView.mj_header = _refreshHeader;
}

- (void)setRefreshFooter:(MJRefreshFooter *)refreshFooter {
    _refreshFooter = refreshFooter;
    
    self.tableView.mj_footer = _refreshFooter;
}

@end
