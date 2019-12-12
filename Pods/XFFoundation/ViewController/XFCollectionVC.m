//
//  XFCollectionVC.m
//  MoreFollows
//
//  Created by xiaoniu on 2019/1/17.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "XFCollectionVC.h"
#import "XFCollectionCell.h"
#import "UIView+Utils.h"

@interface XFCollectionVC ()

@end

@implementation XFCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerCell];
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - override

- (void)registerCell {
    if ([self respondsToSelector:@selector(cellClassForCellAtIndexPath:)]) {
        
    } else {
        Class class = [self cellClass];
        [class performSelector:@selector(registerForCollectionView:) withObject:self.collectionView];
    }    
}

- (Class)cellClass {
    return [XFCollectionCell class];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Class class = nil;
    
    if ([self respondsToSelector:@selector(cellClassForCellAtIndexPath:)]) {
        class = [self cellClassForCellAtIndexPath:indexPath];
    } else {
        class = [self cellClass];
    }
    
    if (class == nil) {
        class = [XFCollectionCell class];
    }
    
    XFCollectionCell *cell = [class performSelector:@selector(cellForCollectionView:indexPath:) withObject:collectionView withObject:indexPath];
    
    [cell configCellWithData:self.dataSource[indexPath.row]];
    
    return cell;
};

#pragma mark - Private

#pragma mark - setter & getter

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    [self.collectionView reloadData];
}

- (UICollectionViewFlowLayout *)viewLayout {
    if (_viewLayout == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(XFScreenWidth/3.0, XFScreenWidth/3.0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _viewLayout = layout;
    }
    return _viewLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.viewLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

@end
