//
//  UITextField+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UITextField+WJCategory.h"

@implementation UITextField (WJCategory)

/** 通过这个属性名，就可以修改textField内部的占位文字颜色 */
static NSString * const WJPlaceholderColorKeyPath = @"placeholderLabel.textColor";

/**
 *  设置占位文字颜色
 */

- (void)setWj_placeholderColor:(UIColor *)wj_placeholderColor{
    
    // 这3行代码的作用：1> 保证创建出placeholderLabel，2> 保留曾经设置过的占位文字
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    if (wj_placeholderColor == nil) {
        wj_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:wj_placeholderColor forKeyPath:WJPlaceholderColorKeyPath];
    
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)wj_placeholderColor
{
    return [self valueForKeyPath:WJPlaceholderColorKeyPath];
}

+(UITextField *)textFieldWithFrame:(CGRect)rect andDelegate:(id)target andBorderStyle:(UITextBorderStyle)borderStyle andPlaceholder:(NSString *)str andAutocorrectionType:(UITextAutocorrectionType)autocorrectionType andAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType andClearButtonMode:(UITextFieldViewMode)clearButtonMode andSecureTextEntry:(BOOL)secureTextEntry andKeyboardType:(UIKeyboardType)keyboardType andReturnKeyType:(UIReturnKeyType)returnKeyType superView:(UIView *)superView{
    
    UITextField *textField = [self initTextFieldWithFrame:rect andDelegate:target andBorderStyle:borderStyle andPlaceholder:str andAutocorrectionType:autocorrectionType andAutocapitalizationType:autocapitalizationType andClearButtonMode:clearButtonMode andSecureTextEntry:secureTextEntry andKeyboardType:keyboardType andReturnKeyType:returnKeyType];
        [superView addSubview:textField];
        return textField;
}

+(UITextField *)lazy_textFieldWithFrame:(CGRect)rect andDelegate:(id)target andBorderStyle:(UITextBorderStyle)borderStyle andPlaceholder:(NSString *)str andAutocorrectionType:(UITextAutocorrectionType)autocorrectionType andAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType andClearButtonMode:(UITextFieldViewMode)clearButtonMode andSecureTextEntry:(BOOL)secureTextEntry andKeyboardType:(UIKeyboardType)keyboardType andReturnKeyType:(UIReturnKeyType)returnKeyType superView:(UIView *)superView subView:(UITextField *)subView{
    
    if (subView == nil) {
        UITextField *textField = [self initTextFieldWithFrame:rect andDelegate:target andBorderStyle:borderStyle andPlaceholder:str andAutocorrectionType:autocorrectionType andAutocapitalizationType:autocapitalizationType andClearButtonMode:clearButtonMode andSecureTextEntry:secureTextEntry andKeyboardType:keyboardType andReturnKeyType:returnKeyType];
        subView = textField;
        [superView addSubview:textField];
    }
    return subView;
}

+ (UITextField *)initTextFieldWithFrame:(CGRect)rect andDelegate:(id)target andBorderStyle:(UITextBorderStyle)borderStyle andPlaceholder:(NSString *)str andAutocorrectionType:(UITextAutocorrectionType)autocorrectionType andAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType andClearButtonMode:(UITextFieldViewMode)clearButtonMode andSecureTextEntry:(BOOL)secureTextEntry andKeyboardType:(UIKeyboardType)keyboardType andReturnKeyType:(UIReturnKeyType)returnKeyType{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.delegate = target;
    textField.borderStyle = borderStyle;
    textField.placeholder = str;
    textField.autocorrectionType =autocorrectionType;
    textField.autocapitalizationType = autocapitalizationType;
    textField.clearButtonMode = clearButtonMode;
    textField.secureTextEntry = secureTextEntry;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnKeyType;
    return textField;
}


@end
