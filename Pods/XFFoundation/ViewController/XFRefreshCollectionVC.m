//
//  XFRefreshCollectionVC.m
//  MoreFollows
//
//  Created by xiaoniu on 2019/1/17.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "XFRefreshCollectionVC.h"

@interface XFRefreshCollectionVC ()

@end

@implementation XFRefreshCollectionVC

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
    
    self.page = [self startPage];
    
    // default
    if (_canUpdateData) {
        MJRefreshHeader *header = nil;
    
        if (header == nil) {
            header =  [[MJRefreshNormalHeader alloc] init];
        }
        
        [header setRefreshingTarget:self refreshingAction:@selector(updateData)];
        
        self.refreshHeader =  header;
    } else {
        self.refreshHeader = nil;
    }
    
    if (_canAppendData) {
        MJRefreshFooter *footer = nil;
        
        if (footer == nil) {
            footer = [[MJRefreshBackNormalFooter alloc] init];
        }
        
        [footer setRefreshingTarget:self refreshingAction:@selector(appendData)];
        
        self.refreshFooter = footer;
    } else {
        self.refreshFooter = nil;
    }
}

#pragma mark - override point

- (NSInteger)startPage {
    return 1;
}

- (void)appendData {
    if (self.hasMoreData) {
        self.page++;
        [self sendDefaultRequest];
    } else {
        [self.refreshFooter endRefreshingWithNoMoreData];
    }
}

- (void)updateData {
    self.page = [self startPage];
    [self sendDefaultRequest];
}

- (void)mainRequestStart {
    if (self.collectionView.mj_header.isRefreshing || self.collectionView.mj_footer.isRefreshing) {
        [self closeLoadingView];
    } else {
        [self closeLoadingView];
        [self showLoadingView];
    }
}

#pragma mark - setter & getter

- (void)setCanUpdateData:(BOOL)canUpdateData {
    _canUpdateData = canUpdateData;
    
    if (canUpdateData) {
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
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
    
    self.collectionView.mj_header = _refreshHeader;
}

- (void)setRefreshFooter:(MJRefreshFooter *)refreshFooter {
    _refreshFooter = refreshFooter;
    
    self.collectionView.mj_footer = _refreshFooter;
}

@end
