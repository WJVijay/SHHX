//
//  UITextField+WJCategory.h
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (WJCategory)

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *wj_placeholderColor;


/**
 Description

 @param rect rect description
 @param target target description
 @param borderStyle borderStyle description
 @param str str description
 @param autocorrectionType 键盘对输入字母自动纠正
 @param autocapitalizationType 首字母是否大写
 @param clearButtonMode 清空按钮
 @param secureTextEntry 明文 暗文
 @param keyboardType 键盘类型
 @param returnKeyType 返回按钮的样式
 @return UITextField
 */
+(UITextField *)textFieldWithFrame:(CGRect)rect andDelegate:(id)target andBorderStyle:(UITextBorderStyle)borderStyle andPlaceholder:(NSString *)str andAutocorrectionType:(UITextAutocorrectionType)autocorrectionType andAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType andClearButtonMode:(UITextFieldViewMode)clearButtonMode andSecureTextEntry:(BOOL)secureTextEntry andKeyboardType:(UIKeyboardType)keyboardType andReturnKeyType:(UIReturnKeyType)returnKeyType  superView:(UIView *)superView;

+(UITextField *)lazy_textFieldWithFrame:(CGRect)rect andDelegate:(id)target andBorderStyle:(UITextBorderStyle)borderStyle andPlaceholder:(NSString *)str andAutocorrectionType:(UITextAutocorrectionType)autocorrectionType andAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType andClearButtonMode:(UITextFieldViewMode)clearButtonMode andSecureTextEntry:(BOOL)secureTextEntry andKeyboardType:(UIKeyboardType)keyboardType andReturnKeyType:(UIReturnKeyType)returnKeyType superView:(UIView *)superView subView:(UITextField *)subView;

@end
