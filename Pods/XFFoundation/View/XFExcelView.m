//
//  CTQFinanceView.m
//  CTQProject
//
//  Created by wangxuefeng on 16/6/16.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFExcelView.h"
#import "XFExcelViewTitleCell.h"

@interface XFExcelView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *data;

@end

@implementation XFExcelView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.collectionView registerClass:[XFExcelViewTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([XFExcelViewTitleCell class])];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.collectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSString *reuseIdentifier = NSStringFromClass([XFExcelViewTitleCell class]);
        
        XFExcelViewTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        cell.titleStyle = UITableViewCellStyleDefault;
        
        [cell setTitle:self.titles[indexPath.row]];

        return cell;
    } else {
        NSString *reuseIdentifier = NSStringFromClass([XFExcelViewTitleCell class]);
        
        XFExcelViewTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        cell.titleStyle = UITableViewCellStyleDefault;
        
        NSArray *temp = self.data[indexPath.row/self.titles.count];
        
        id obj = temp[indexPath.row % self.titles.count];
        
        if ([obj isKindOfClass:[NSString class]]) {
            cell.title = obj;
        } else {
            cell.title = @"";
        }
        
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return section==0 ? self.titles.count : self.data.count * self.titles.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    float w = screenWidth/self.titles.count -1;
    
    return CGSizeMake(w, 30);
}

#pragma mark - setter & getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}

- (NSArray *)titles {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleForExcelView:)]) {
        
        _titles = [self.dataSource titleForExcelView:self];
    }
    return _titles;
}

- (NSArray *)data {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dataForExcelView:)]) {
        
        _data = [self.dataSource dataForExcelView:self];
    }
    return _data;
}

@end
