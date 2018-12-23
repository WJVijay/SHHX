//
//  UILabel+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WJCategory)


/**
 每次返回新对象

 */
+ (UILabel *)labelWithRect:(CGRect)rect name:(NSString *)text fontSize:(CGFloat)font alignment:(NSTextAlignment)alignment testColor:(UIColor *)color superView:(UIView *)superView;

/**
 懒加载
 
 */
+ (UILabel *)lazy_labelWithRect:(CGRect)rect name:(NSString *)text fontSize:(CGFloat)font Alignment:(NSTextAlignment)alignment testColor:(UIColor *)color superView:(UIView *)superView subView:(UILabel *)subView;

/**
 根据label的宽度,文字的字号获取label的高度

 @param width label的宽度
 @param title 文字
 @param font 字号
 @return label的高度
 */
+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;

#pragma mark -自定义label弹窗-
+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView;

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView afterDelay:(NSTimeInterval )time;

@end
