//
//  XFExcelViewTitleCell.h
//  CTQProject
//
//  Created by wangxuefeng on 16/6/16.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XFExcelViewTitleCellStyle) {
    XFExcelViewTitleCellStyleDefault
};

@interface XFExcelViewTitleCell : UICollectionViewCell

@property (assign, nonatomic) XFExcelViewTitleCellStyle titleStyle;

@property (strong, nonatomic) UILabel *lblTitle;

@property (copy  , nonatomic) NSString *title;

@end
