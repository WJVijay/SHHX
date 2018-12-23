
//
//  AppDelegate+WJCategory.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/12.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "AppDelegate+WJCategory.h"
#import "WJTabBarController.h"
#import "WJLoginViewController.h"

@implementation AppDelegate (WJCategory)

- (void)configGuideLoginMain{
    
    //判断版本号是否一致
    NSLog(@"版本号：%@----------%@", [self loadAppVersion], [self loadSavedAppVersion]);
//    if ([[self loadAppVersion] isEqualToString:[self loadSavedAppVersion]]) {
    
//        [self setAdverPage];
//        //没设置自动登录
//        if (![NSUserDefaults getUserDefaultObjectWithKey:@"isAutoLogin"]) {
//            [NSUserDefaults saveUserDefaultObject:@"1" key:@"isAutoLogin"];
//        }else{
//            NSString *autoLogin = [NSUserDefaults getUserDefaultObjectWithKey:@"isAutoLogin"];
//            if (![autoLogin isEqualToString:@"1"]) {
//
//                [self setLoginViewController];
//                return;
//            }
//        }
//
//        //有token,自动登录
//        if ([[HXUserInfo shareUserBase] isLogin]) {
//            //如果登陆，跳到主页面
//            [self setRootController];
//        }else {
//            //如果未登录，跳到登陆界面
//            [self setLoginViewController];
//        }
//
//    }else {
//        //如果不是，则显示新特性
//        //将新版本的appVersion存储到本地
//        [self saveAppVersion:[self loadAppVersion]];
//        [self setGuaidPages];
//    }
        [self setRootController];
}

//获取当前版本号
- (NSString *)loadAppVersion
{
    //获取info
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    //返回当前程序的版本号
    return info[@"CFBundleShortVersionString"];
}

//获取沙盒存储的版本号
- (NSString *)loadSavedAppVersion
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"appVersion"];
}

- (void)saveAppVersion:(NSString *)version
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:version forKey:@"appVersion"];
}

- (void)setLoginViewController{
    
    WJLoginViewController *logVC = [WJLoginViewController new];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:logVC];
}

- (void)setRootController{
    
    // 设置根控制器
    WJTabBarController *rootVc = [[WJTabBarController alloc] init];
//    rootVc.delegate = self;
    self.window.rootViewController = rootVc;
}

- (void)setGuaidPages{
    
    KSGuaidManager.images = @[[UIImage imageNamed:@"guid01"],
                              [UIImage imageNamed:@"guid02"],
                              [UIImage imageNamed:@"guid03"],
                              [UIImage imageNamed:@"guid04"]];
    
    KSGuaidManager.shouldDismissWhenDragging = YES;
    
    [KSGuaidManager begin];
    [self setAdverPage];
    if ([self hasTouristsMode]) {
        [self setRootController];
    }else{
        [self setLoginViewController];
    }
}

- (void)setAdverPage{
    
    //1.设置启动页广告图片的url
//    NSString *imgUrlString =@"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg";
    //GIF
    NSString *imgUrlString = @"http://img1.imgtn.bdimg.com/it/u=473895314,616407725&fm=206&gp=0.jpg";
    
    //2.初始化启动页广告
    [JWLaunchAd initImageWithAttribute:6.0 showSkipType:SkipShowTypeAnimation setLaunchAd:^(JWLaunchAd *launchAd) {
        __block JWLaunchAd *weakSelf = launchAd;
        
        //如果选择 SkipShowTypeAnimation 需要设置动画跳过按钮的属性
        [weakSelf setAnimationSkipWithAttribute:[UIColor whiteColor] lineWidth:3.0 backgroundColor:nil textColor:nil];
        [launchAd setWebImageWithURL:imgUrlString options:JWWebImageDefault result:^(UIImage *image, NSURL *url) {
            
            //3.异步加载图片完成回调(设置图片尺寸)
            weakSelf.launchAdViewFrame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-100);
            
        } adClickBlock:^{
            
            //4.点击广告回调
            NSString *url = @"https://www.baidu.com";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            
        }];
    }];
}

@end
