//
//  CTQFinanceView.h
//  CTQProject
//
//  Created by wangxuefeng on 16/6/16.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFExcelView;

@protocol XFExcelViewDataSource  <NSObject>

- (NSArray *)titleForExcelView:(XFExcelView *)excleView;

- (NSArray *)dataForExcelView:(XFExcelView *)excleView;

@end

@interface XFExcelView : UIView

@property (strong, nonatomic) UICollectionView *collectionView;

@property (weak  , nonatomic) id<XFExcelViewDataSource> dataSource;

@end
