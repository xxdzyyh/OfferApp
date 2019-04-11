//
//  XFTableViewController.m
//  CTQProject
//
//  Created by wangxuefeng on 16/5/28.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFTableViewController.h"
#import "YYKit.h"
#import "XFLineHelper.h"
#import "XFInfoView.h"
#import "Masonry.h"

@interface XFTableViewController () {
    UITableView *_tableView;
    XFEmptyView *_emptyView;
}

@end

@implementation XFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - 使用cell作为分割区域

- (UITableViewCell *)seperatorCell {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [XFLineHelper addBottomLineToView:cell.contentView];
    
    return cell;
}

- (float)seperatorCellHeight {
    return 10;
}

#pragma mark - 表格顶部的留白

- (UIView *)tableHeaderWithBackgroundColor:(UIColor *)color height:(float)height {
    
    if (height <= 0) {
        height = 10;
    }
    
    if (color == nil) {
        color = [UIColor clearColor];
    }
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, height)];
    
    view.backgroundColor = color;
    
    return view;
}

- (UIView *)defaultTableHeaderView {
    return [self tableHeaderWithBackgroundColor:[UIColor clearColor] height:10];
}

#pragma mark - 高度计算

+ (float)heightForString:(NSString *)string font:(UIFont *)font perferWidth:(float)width {
    
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    return rect.size.height;
}

+ (float)heightForLableWithText:(NSString *)text font:(UIFont *)font perferWidth:(float)width {
    
    UILabel *lable = [[UILabel alloc] init];
    
    lable.text = text;
    lable.font = font;
    lable.preferredMaxLayoutWidth = width;
    lable.numberOfLines = 0;
    
    return lable.intrinsicContentSize.height;
}

#pragma mark - 使用cell提示内容为空

- (UITableViewCell *)emptyCellWithImageName:(NSString *)imageName title:(NSString *)title {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XFEmptyCell"];
    
    XFInfoView *info = [[XFInfoView alloc] initWithInfo:title imageName:imageName];
    
    [info showAtView:cell.contentView];
    
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    return cell;
}

#pragma mark - 空白视图

- (void)showEmptyView {
    
    if (self.emptyView.superview && self.emptyView.superview != self.tableView) {
        
        [self.emptyView removeFromSuperview];
    }
    
    [self.tableView addSubview:self.emptyView];
}

- (void)hiddenEmptyView {
    [self.emptyView removeFromSuperview];
}

#pragma mark - setter & getter 

- (UITableView *)tableView {

        if (nil == _tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            
            _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.showsVerticalScrollIndicator = NO;
            _tableView.showsHorizontalScrollIndicator = NO;
            _tableView.tableFooterView = [UIView new];
            _tableView.directionalLockEnabled = YES;
            
            [self.view addSubview:_tableView];
        }
    return _tableView;
}

- (XFEmptyView *)emptyView {
    if (_emptyView == nil) {
        _emptyView = [[XFEmptyView alloc] initWithTitle:self.emptyTitle
                                                  image:self.emptyImageName];
        _emptyView.backgroundColor = [UIColor clearColor];
    }
    return _emptyView;
}


- (void)setDataSource:(NSMutableArray *)dataSource {
    if (_dataSource != dataSource) {
        
        _dataSource = dataSource;
        
        [self.tableView reloadData];
        
        if (dataSource.count == 0) {
            
            [self showEmptyView];
        } else {
            
            [self hiddenEmptyView];
        }
    }
}

@end
