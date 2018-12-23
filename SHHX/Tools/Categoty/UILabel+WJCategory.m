//
//  UILabel+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UILabel+WJCategory.h"
#import "UIColor+WJCategory.h"

#define kLabSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define kLabSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

// 屏幕适配
#define kLabScreen(value) ((value) * [UIScreen mainScreen].bounds.size.width/375)
#define hLabScreen(value) ((value) * ([UIScreen mainScreen].bounds.size.height)/(667))

@implementation UILabel (WJCategory)

+ (UILabel *)labelWithRect:(CGRect)rect name:(NSString *)text fontSize:(CGFloat)font alignment:(NSTextAlignment)alignment testColor:(UIColor *)color superView:(UIView *)superView{
    UILabel *label = [UILabel new];
    label.frame = rect;
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    label.textColor = color;
    label.numberOfLines = 0;
    [superView addSubview:label];
    return label;
}

+ (UILabel *)lazy_labelWithRect:(CGRect)rect name:(NSString *)text fontSize:(CGFloat)font Alignment:(NSTextAlignment)alignment testColor:(UIColor *)color superView:(UIView *)superView subView:(UILabel *)subView{
    
    if (subView == nil) {
        subView = [UILabel new];
        subView.frame = rect;
        subView.text = text;
        subView.font = [UIFont systemFontOfSize:font];
        subView.textAlignment = alignment;
        subView.textColor = color;
        subView.numberOfLines = 0;
        [superView addSubview:subView];
    }
    return subView;
}

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kLabSCREENWIDTH / 2 - kLabScreen(150), kLabSCREENHEIGHT - kLabScreen(200), kLabScreen(300), hLabScreen(35))];
    [subView addSubview:lable];
    lable.text = reason;
    // lable.alpha = 0.8;
    lable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    lable.font = [UIFont systemFontOfSize:16];
    lable.layer.cornerRadius = 5;
    lable.textAlignment = NSTextAlignmentCenter;
    if (kLabSCREENHEIGHT > 1000) {
        lable.font = [UIFont systemFontOfSize:18];
    }
    
    [lable performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

+ (void)showAlertViewWithTitle:(NSString *)reason subView:(UIView *)subView afterDelay:(NSTimeInterval )time
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kLabSCREENWIDTH / 2 - kLabScreen(150), kLabSCREENHEIGHT - hLabScreen(200), kLabScreen(300), hLabScreen(35))];
    [subView addSubview:lable];
    lable.text = reason;
    // lable.alpha = 0.8;
    lable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    lable.font = [UIFont systemFontOfSize:13];
    lable.layer.cornerRadius = 5;
    lable.textAlignment = NSTextAlignmentCenter;
    if (kLabSCREENHEIGHT > 1000) {
        lable.font = [UIFont systemFontOfSize:18];
    }
    
    [lable performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:time];
}

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}


@end
