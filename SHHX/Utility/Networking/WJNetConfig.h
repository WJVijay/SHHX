//
//  WJNetConfig.h
//  SHHX
//
//  Created by Yuan Wang on 2018/12/11.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求方式
typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,//Get请求
    RequestTypePost,//Post请求
    RequestTypeUpLoad,//单张图片上传
    RequestTypeMultiUpload,//多张图片上传
    RequestTypeDownload//下载
};

@interface WJNetConfig : NSObject

@property (copy  ,nonatomic)NSString                         *urlString;//url

@property (strong,nonatomic)NSDictionary                     *params; //参数

@property (assign,nonatomic)BOOL                             isFirstCache; //是否缓存,默认是NO

@property (assign,nonatomic)double                           timeoutInterval; //网络请求的超时时间,默认是30s

@property (assign,nonatomic)RequestType                      requestType;

#warning -如果isFirstCache = YES ,则需要设置cacheKey,否则不需要设置-
@property (copy  ,nonatomic)NSString                         *isFirstCacheKey; //用于缓存的key

#warning -单张图片上传需要设置singleData,imageKey-
@property (strong,nonatomic)NSData                           *singleData;
@property (copy  ,nonatomic)NSString                         *imageKey;

#warning -多张图片上传需要设置dataArray-
@property (strong,nonatomic)NSArray                <NSData *>*dataArray;

@end

