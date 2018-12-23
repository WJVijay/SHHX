//
//  API.m
//  XZYNetworking
//
//  Created by 徐自由 on 2017/12/25.
//  Copyright © 2017年 徐自由. All rights reserved.
//

#import "API.h"

#define needToken httpRequest.needToken
#define isLoginFlag httpRequest.isLoginFlag
#define isCache httpRequest.isCache
#define isShowCache httpRequest.isShowCache

@implementation API

#pragma mark - init方法
@synthesize httpRequest;

//无需token
- (instancetype)init:(id)delegate tag:(NSString *)tag
{
    return [self init:delegate  NeedToken:0];
}

//携带token
- (instancetype)init:(id)delegate NeedToken:(NSInteger)NeedToken
{
    if (self=[super init]) {
        httpRequest = [[XZYNetworkingWithCache alloc] initWithDelegate:delegate  NeedToken:NeedToken];
    }
    return self;
}

- (void)setCache:(BOOL)cache
{
    isCache = cache;
}

- (void)setShowCache:(BOOL)showCache
{
    isShowCache = showCache;
}

#pragma mark - 公共模块
- (void)getInfo:(NSString *)one two:(NSString *)two
{
    needToken = 0;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:one forKey:@"one"];
    [params setObject:two forKey:@"two"];
    [httpRequest httpPostRequest:@"/abcd/dasdad/" params:params];
}

- (void)textApi:(NSString *)urlStr params:(id)params{
    
    [httpRequest httpPostRequest:urlStr params:params];
}



//- (void)LoginWithUserID:(NSString *)userID password:(NSString *)password
//{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:userID forKey:@"userID"];
//    [params setObject:password forKey:@"password"];
////    [params setObject:password forKey:@"password"];
//
//    
////    [httpRequest httpPostRequest:@"" params:params];
//}



@end
