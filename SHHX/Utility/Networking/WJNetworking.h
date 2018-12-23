//
//  WJNetworking.h
//  SHHX
//
//  Created by Yuan Wang on 2018/12/11.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJNetConfig.h"


//@protocol WJNetworkingDelegate <NSObject>
//
//@optional
//
//- (void)httpSuccess:(id)response;
//
//- (void)httpError:(NSString *)error;
//
//@end

@interface WJNetworking : NSObject

#warning -有网,有缓存,并且缓存和请求的数据不一致会回调两次-
- (void)getDataWithNetConfig:(WJNetConfig *)netConfig success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask*task, NSError *error))failure;
///**
// 请求
//
// @param requestDelegate 代理
// @param netConfig 配置
// @param requestType 请求方式
// @return return value description
// */
//- (instancetype)initWithDelegate:(id)requestDelegate netConfig:(WJNetConfig *)netConfig requestType:(RequestType)requestType;

@end

