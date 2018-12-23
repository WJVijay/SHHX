//
//  UIButton+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    /// 图片在左，文字在右
    WJImagePositionStyleDefault,
    /// 图片在右，文字在左
    WJImagePositionStyleRight,
    /// 图片在上，文字在下
    WJImagePositionStyleTop,
    /// 图片在下，文字在上
    WJImagePositionStyleBottom,
    
} WJImagePositionStyle;



@interface UIButton (WJCategory)


/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)WJ_imagePositionStyle:(WJImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;


/**
 实例化button(图片或者文字)

 @param rect frame
 @param type 0-图片
 @param title 文字
 @param imageName 图片名称
 @param target 监听者
 @param selector 监听方法
 @param event event
 @param state state
 @return uibutton
 */
+ (UIButton *)buttonWithFrame:(CGRect)rect andType:(UIButtonType)type andTitle:(NSString *)title andImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL)selector andEvent:(UIControlEvents)event andState:(UIControlState)state superView:(UIView *)superView;

+ (UIButton *)lazy_buttonWithFrame:(CGRect)rect andType:(UIButtonType)type andTitle:(NSString *)title andImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL)selector andEvent:(UIControlEvents)event andState:(UIControlState)state superView:(UIView *)superView subView:(UIButton *)subView;

@end
