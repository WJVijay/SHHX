//
//  UIView+WJSetOriginExtension.h
//  WJBS
//
//  Created by vijay on 2017/4/2.
//  Copyright © 2017年 vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, MasonryLayoutType) {
//    MasonryLayoutTopLeadingBottomTrainling,  //上 左 下 右
//    MasonryLayoutTopLeadingTrainlingHeight,  //上 左 右 高
//    MasonryLayoutTopLeadingWidthHeight,      //上 左 宽 高
//    MasonryLayoutTopLeading                  //上 左
//};
//
//
//struct MassoryLayout {
//    CGFloat value1;
//    CGFloat value2;
//    CGFloat value3;
//    CGFloat value4;
//};

typedef struct WJConstraints
{
    float  value1;        //第一个约束值
    float  value2;        //第二个约束值
    float  value3;        //第三个约束值
    float  value4;        //第四个约束值
    
}WJConstraints;

typedef NS_OPTIONS(NSInteger, WJConstraintType)
{
    WJConstraintTypeTopLeftWidthHeight      = 1,      //设置约束为 上 左 宽 高
    WJConstraintTypeWidthHeightCenter       = 2,      //设置约束为 宽 高 中 心
    WJConstraintTypeTopRightWidthHeight     = 3,      //设置约束为 上 右 宽 高
    WJConstraintTypeTopLeftBottomRight      = 4,      //设置约束为 上 左 下 右
    WJConstraintTypeTopLeftRightHeight      = 5,      //设置约束为 上 左 右 高
    WJConstraintTypeLeftBottomRightHeight   = 6,      //设置约束为 左 下 右 高
    WJConstraintTypeTopWidthHeightCenterX   = 7,      //设置约束为 上 宽 高 中 心 x
    WJConstraintTypeLeftWidthHeightCenterY  = 8       //设置约束为 左 宽 高 中心y
};

@interface UIView (WJCategory)

#pragma mark -获取view布局位置的值-
@property (nonatomic, assign) CGFloat wj_x;
@property (nonatomic, assign) CGFloat wj_y;
@property (nonatomic, assign) CGFloat wj_width;
@property (nonatomic, assign) CGFloat wj_height;
@property (nonatomic, assign) CGFloat wj_centerX;
@property (nonatomic, assign) CGFloat wj_centerY;

/**  顶部  */
@property (nonatomic, assign) CGFloat wj_top;
/**  底部  */
@property (nonatomic, assign) CGFloat wj_bottom;
/**  左边  */
@property (nonatomic, assign) CGFloat wj_left;
/**  右边  */
@property (nonatomic, assign) CGFloat wj_right;
/**  size  */
@property (nonatomic, assign) CGSize wj_size;
/**  origin */
@property (nonatomic, assign) CGPoint wj_origin;
/**  是否能够响应touch事件  */
//@property (nonatomic, assign) BOOL unTouch;
/**  不响应touch事件的区域  */
//@property (nonatomic, assign) CGRect unTouchRect;

#pragma mark -实例函数-

/**
 根据framet创建并g添加view

 @param rect framef
 @param superView 父view
 @param subView 子view
 @return 子view
 */
+ (UIView *)viewWithRect:(CGRect)rect superView:(UIView *)superView  subView:(UIView *)subView;


/**
 根据masonry布局view

 @param constraints 值
 @param superView 父view
 @param subView 子viewe
 @return 子view
 */
+ (UIView *)viewWithMasonryLayoutRect:(WJConstraints)constraints superView:(UIView *)superView  subView:(UIView *)subView constraintsType:(WJConstraintType)type;


/**  设置圆角  */
- (void)rounded:(CGFloat)cornerRadius;

/**  设置圆角和边框  */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**  设置边框  */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**   给哪几个角设置圆角  */
-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;

/**  设置阴影  */
-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

- (UIViewController *)viewController;


/**
 *		删除所有子对象
 */
- (void)removeAllSubviews;

/**
 *  快速修改对象的单个属性值
 *
 *  @param key   要修改的属性，例如：@"x",@"y",@"w",@"h"
 *  @param value 被修改属性的新值
 */
- (void)frameSet:(NSString *)key value:(CGFloat)value;

/**
 *  快速修改对象的多个属性值
 *
 *  @param key1   要修改的属性1，例如：@"x",@"y",@"w",@"h"
 *  @param value1 属性1的新值
 *  @param key2   要修改的属性2，例如：@"x",@"y",@"w",@"h"
 *  @param value2 属性2的新值
 */
- (void)frameSet:(NSString *)key1 value1:(CGFloat)value1 key2:(NSString *)key2 value2:(CGFloat)value2;

/**
 *  从 bundle 加载一个 view
 *
 *  @return 返回一个 view
 */
+ (instancetype)viewFromBundle;

- (BOOL)intersectWithView:(UIView *)view;

@end
