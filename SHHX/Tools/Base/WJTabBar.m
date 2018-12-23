//
//  WJTabBar.m
//  CommonArchitecture
//
//  Created by vijay on 2018/11/1.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import "WJTabBar.h"
#import "UIView+WJCategory.h"

#define WJLogFunc WJLog(@"%s", __func__);

@interface WJTabBar()

/** 中间的发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation WJTabBar

#pragma mark - 懒加载
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.wj_width / 5;
    CGFloat buttonH = self.wj_height;
    CGFloat tabBarButtonY = 0;
    int tabBarButtonIndex = 0;
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 2) { // 右边的2个UITabBarButton
            tabBarButtonX += buttonW;
        }
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        
        // 增加索引
        tabBarButtonIndex++;
        
    }
    
    self.publishButton.wj_width = buttonW;
    self.publishButton.wj_height = buttonH;
    self.publishButton.wj_centerX = self.wj_width * 0.5;
    self.publishButton.wj_centerY = self.wj_height * 0.5;
}

#pragma mark - 监听
- (void)publishClick
{
//    WJLogFunc
}

@end
