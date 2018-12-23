//
//  AppDelegate.h
//  SHHX
//
//  Created by Yuan Wang on 2018/11/12.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow                      *window;
//app是否有游客模式,默认是没有游客模式的必须登录
@property (assign,nonatomic)BOOL                            hasTouristsMode;

@end

