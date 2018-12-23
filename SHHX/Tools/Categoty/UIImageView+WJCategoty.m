//
//  UIImageView+WJCategoty.m
//  CommonArchitecture
//
//  Created by Yuan Wang on 2018/11/7.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import "UIImageView+WJCategoty.h"

@implementation UIImageView (WJCategoty)

+ (UIImageView *)imageViewWithFrame:(CGRect)rect andImage:(NSString *)imageName  superView:(UIView *)superView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

+ (UIImageView *)lazy_imageViewWithFrame:(CGRect)rect andImage:(NSString *)imageName superView:(UIView *)superView subView:(UIImageView *)subView{
    
    if (subView == nil) {
        subView = [[UIImageView alloc] initWithFrame:rect];
        subView.image = [UIImage imageNamed:imageName];
        [superView addSubview:subView];
    }
    return subView;
}

@end
