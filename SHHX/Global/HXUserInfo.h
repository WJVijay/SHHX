//
//  HXUserInfo.h
//  SHHX
//
//  Created by Yuan Wang on 2018/11/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJSingle.h"

@interface HXUserInfo : NSObject

@property (copy  ,nonatomic)NSString                         *name;

@property (copy  ,nonatomic)NSString                         *age;

@property (copy  ,nonatomic)NSString                         *gender;


#pragma mark -settingConfig-
//是否开启自动登录,默认为YES
@property (assign,nonatomic)BOOL                             isAutoLogin;
//是否登录过(token),YES->自动登录
@property (assign,nonatomic)BOOL                             isLogin;
//记录登录过的账号
@property (copy  ,nonatomic)NSString                         *account;

WJSingleInterface(UserBase);

@end


