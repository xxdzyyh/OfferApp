//
//  CollectionOffsetBugVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/5/22.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "CollectionOffsetBugVC.h"

@interface CollectionOffsetBugVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;    
    
@end

@implementation CollectionOffsetBugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
    

    
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
    
@end
