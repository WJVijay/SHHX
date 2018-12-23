//
//  UIImageView+WJCategoty.h
//  CommonArchitecture
//
//  Created by Yuan Wang on 2018/11/7.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (WJCategoty)

+ (UIImageView *)imageViewWithFrame:(CGRect)rect andImage:(NSString *)imageName  superView:(UIView *)superView;

+ (UIImageView *)lazy_imageViewWithFrame:(CGRect)rect andImage:(NSString *)imageName superView:(UIView *)superView subView:(UIImageView *)subView;

@end

NS_ASSUME_NONNULL_END
