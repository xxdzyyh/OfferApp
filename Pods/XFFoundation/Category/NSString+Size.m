//
//  NSString+Size.m
//  Tao
//
//  Created by wangxuefeng on 2019/7/10.
//  Copyright © 2019年 App4life Inc. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGFloat)heightWithFont:(UIFont *)font perferWidth:(float)width {
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	
	// UILabel默认换行模式 NSLineBreakByCharWrapping
	paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
	
	NSDictionary * attributes = @{
								  NSFontAttributeName:font,
								  NSParagraphStyleAttributeName: paragraphStyle
								  };
	
	return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
							  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
						   attributes:attributes
							  context:nil].size.height;
}

@end
