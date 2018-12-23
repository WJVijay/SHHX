//
//  UIButton+WJCategory.m
//  WJDeveloperToolsDemo
//
//  Created by Yuan Wang on 2018/4/17.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "UIButton+WJCategory.h"

@implementation UIButton (WJCategory)

/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片的文字
 *  @param spacing           图片与文字之间的间距
 */
- (void)WJ_imagePositionStyle:(WJImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing{
    
    if (imagePositionStyle == WJImagePositionStyleDefault) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
    } else if (imagePositionStyle == WJImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        CGFloat imageOffset = titleW + 0.5 * spacing;
        CGFloat titleOffset = imageW + 0.5 * spacing;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
    } else if (imagePositionStyle == WJImagePositionStyleTop) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, - imageH - spacing, 0);
    } else if (imagePositionStyle == WJImagePositionStyleBottom) {
        CGFloat imageW = self.imageView.frame.size.width;
        CGFloat imageH = self.imageView.frame.size.height;
        CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
        CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
        self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + spacing, 0, 0, - titleIntrinsicContentSizeW);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + spacing, 0);
    }
    
}


+ (UIButton *)buttonWithFrame:(CGRect)rect andType:(UIButtonType)type andTitle:(NSString *)title andImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL)selector andEvent:(UIControlEvents)event andState:(UIControlState)state superView:(UIView *)superView{
    
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = rect;
    if (type ==0) {
        [btn setImage:[UIImage imageNamed:imageName] forState:state];
    }else{
        [btn setTitle:title forState:state];
    }
    [btn addTarget:target action:selector forControlEvents:event];
    [superView addSubview:btn];
    return btn;
}

+ (UIButton *)lazy_buttonWithFrame:(CGRect)rect andType:(UIButtonType)type andTitle:(NSString *)title andImageName:(NSString *)imageName andTarget:(id)target andSelector:(SEL)selector andEvent:(UIControlEvents)event andState:(UIControlState)state superView:(UIView *)superView subView:(UIButton *)subView{
    
    if (subView == nil) {
        subView = [UIButton buttonWithType:type];
        subView.frame = rect;
        if (type ==0) {
            [subView setImage:[UIImage imageNamed:imageName] forState:state];
        }else{
            [subView setTitle:title forState:state];
        }
        [subView addTarget:target action:selector forControlEvents:event];
        [superView addSubview:subView];
    }
    return subView;
}

@end
