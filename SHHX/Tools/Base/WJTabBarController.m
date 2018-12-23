//
//  WJTabBarController.m
//  CommonArchitecture
//
//  Created by vijay on 2018/11/1.
//  Copyright © 2018年 vijay. All rights reserved.
//

#import "WJTabBarController.h"
#import "WJTabBar.h"
#import "WJNavigationController.h"
#import "HXMainViewController.h"

#import "HXCerViewController.h"
#import "HXOrderViewController.h"
#import "HXMeViewController.h"


@interface WJTabBarController ()

@end

@implementation WJTabBarController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    
    /**** 更换TabBar ****/
//    [self setupTabBar];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers{
    
    
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[HXMainViewController alloc] init]] title:@"模块一" image:@"" selectedImage:@""];

    [self setupOneChildViewController:[[WJNavigationController alloc] initWithRootViewController:[[HXCerViewController alloc] init]] title:@"模块一" image:@"" selectedImage:@""];

    [self setupOneChildViewController:[[WJNavigationController alloc] initWithRootViewController:[[HXOrderViewController alloc] init]] title:@"模块二" image:@"" selectedImage:@""];

    [self setupOneChildViewController:[[WJNavigationController alloc] initWithRootViewController:[[HXMeViewController alloc] init]] title:@"模块三" image:@"" selectedImage:@""];

}

/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

/**
 *  更换TabBar
 */
- (void)setupTabBar
{
    [self setValue:[[WJTabBar alloc] init] forKeyPath:@"tabBar"];
}
@end
