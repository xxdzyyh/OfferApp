//
//  XFLineView.h
//
//

#import <UIKit/UIKit.h>

/*!  * @typedef XFLineStyle
 
 * @brief 线样式
 
 * @constant XFLineStyle_Normal 实线
 * @constant XFLineStyle_Dash 点线
 */

typedef NS_ENUM(NSInteger, XFLineStyle) {
    ///实线
    XFLineStyle_Normal,
    
    ///点线
    XFLineStyle_Dash,
};

#define kXFLineStyle_Solid @"solid"

#define kXFLineStyle_Dash @"dash"

typedef NS_ENUM(NSInteger, XFLineDirection) {
    XFLineDirection_Line,
    XFLineDirection_LeftTop2RightBottom,
};

@interface XFLineView : UIView

/*!  * @brief 线样式 */
@property(copy, nonatomic) NSNumber* lineStyle;

@property(copy, nonatomic) NSNumber* lineWidth;

@property(copy, nonatomic) NSNumber* margin1;

@property(copy, nonatomic) NSNumber* margin2;

@property(copy, nonatomic) UIColor* lineColor;

@property(assign, nonatomic) BOOL isBottomLine;

@property(assign, nonatomic) XFLineDirection lineDirection;

+ (NSNumber*)styleForName:(NSString*)name;

@end
