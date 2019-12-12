//
//  XFCollectionVC.h
//  MoreFollows
//
//  Created by xiaoniu on 2019/1/17.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "XFViewController.h"

@protocol XFCollectionCellDelegate <NSObject>

@optional

- (void)registerCell;

- (Class)cellClass;
- (Class)cellClassForCellAtIndexPath:(NSIndexPath *)indexPath;

- (Class)modelClass;
- (Class)modelClassForCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XFCollectionVC : XFViewController <UICollectionViewDelegate,UICollectionViewDataSource,XFCollectionCellDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *viewLayout;

@end


