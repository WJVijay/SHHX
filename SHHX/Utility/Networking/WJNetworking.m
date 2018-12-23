
//
//  WJNetworking.m
//  SHHX
//
//  Created by Yuan Wang on 2018/12/11.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJNetworking.h"

NSString * const HttpCache = @"HttpRequestCache";

@interface WJNetworking()

//@property (nonatomic, strong)id                                  requestDelegate;
//
//@property (assign,nonatomic)RequestType                          requestType;

@property (strong,nonatomic)WJNetConfig                          *netConfig;

@property (copy  ,nonatomic)void(^success)(NSURLSessionDataTask *task, id responseObject);

@property (copy  ,nonatomic)void(^failure)(NSURLSessionDataTask*task, NSError *error);

@end

@implementation WJNetworking

//#warning -有网,有缓存,并且缓存和请求的数据不一致会回调两次-
- (void)getDataWithNetConfig:(WJNetConfig *)netConfig success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask*task, NSError *error))failure{

    self.success = success;
    self.failure = failure;
    self.netConfig = netConfig;
    [self httpsRequest];
}

#pragma mark -有网没缓存-
- (void)hasNetworkingNoCache:(YYCache *)cache task:(NSURLSessionDataTask *)task{
    
    [self startRequestwithCacheData:nil yyCache:cache];
}

#pragma mark -有网有缓存-
- (void)hasNetworkingAddCache:(YYCache *)cache task:(NSURLSessionDataTask *)task{
    
    id cacheData = [cache objectForKey:self.netConfig.isFirstCacheKey];
    //先展示缓存,有问题
    [self returnDataWithCacheData:cacheData cache:cache task:task];
    //再请求数据
    [self startRequestwithCacheData:nil yyCache:cache];
}

#pragma mark -没网没缓存-
- (void)noNetworkingNoCache:(YYCache *)cache task:(NSURLSessionDataTask *)task{
    
#warning -没网没缓存显示空白页-
    
}

#pragma mark -没网有缓存-
- (void)noNetworkingAddCache:(YYCache *)cache task:(NSURLSessionDataTask *)task{
    
    id cacheData = [cache objectForKey:self.netConfig.isFirstCacheKey];
    [self returnDataWithCacheData:cacheData cache:cache task:task];
}

- (void)httpsRequest{
  
    //需要缓存
    if (self.netConfig.isFirstCache) {
        //设置YYCache属性
        YYCache *cache = [[YYCache alloc] initWithName:HttpCache];
        cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;//当接收到来自系统的内存警告时，是否要清除所有缓存，默认是 YES。建议使用默认。
        cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;//当进入后台的时候是否要清除所有缓存，默认是 YES。建议使用默认。
        if (self.netConfig.isFirstCacheKey == nil) {
            self.netConfig.isFirstCacheKey = self.netConfig.urlString;
        }
        id cacheData = [cache objectForKey:self.netConfig.isFirstCacheKey];
        //断网
        if (![self requestBeforeJudgeConnect]) {
            
            [SVProgressHUD showWithStatus:@"请检查网络设置"];
            NSLog(@"\n\n----%@------\n\n",@"没有网络");
            //断网后,根据网址从Cache中取数据进行显示
            cacheData ? [self noNetworkingAddCache:cache task:nil]:[self noNetworkingNoCache:cache task:nil];
            return;
        
        //有网
        }else{
            cacheData ? [self hasNetworkingAddCache:cache task:nil]:[self hasNetworkingNoCache:cache task:nil];
            return;
        }
        
    //不需要缓存
    }else{
        
        [self startRequestwithCacheData:nil yyCache:nil];
    }
 
}

#pragma mark -AFN开始请求-
- (void)startRequestwithCacheData:(id)cacheData yyCache:(YYCache *)yycache{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //超时时间 30s
    session.requestSerializer.timeoutInterval = self.netConfig.timeoutInterval;
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@", self.netConfig.urlString];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    if (self.netConfig.params == nil) {
        self.netConfig.params = [NSMutableDictionary dictionary];
    }
    
    //Get请求
    if (self.netConfig.requestType == RequestTypeGet) {
        
        [session GET:url parameters:self.netConfig.params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self dealWithResponseObject:responseObject cacheUrl:self.netConfig.urlString cacheData:cacheData cache:yycache cacheKey:self.netConfig.isFirstCacheKey task:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络设置"];
            if (self.failure) {
                self.failure(task, error);
            }
        }];
    
    //post请求
    } else if (self.netConfig.requestType == RequestTypePost) {
        
        WJLog(@"%@",self.netConfig.params);
        [session POST:url parameters:self.netConfig.params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self dealWithResponseObject:responseObject cacheUrl:self.netConfig.urlString cacheData:cacheData cache:yycache cacheKey:self.netConfig.isFirstCacheKey task:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请检查网络设置"];
            if (self.failure) {
                self.failure(task, error);
            }
        }];
        
    //上传单张图片
    } else if (self.netConfig.requestType == RequestTypeUpLoad) {
        [session POST:url parameters:self.netConfig.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSTimeInterval timeInterVal = [[NSDate date] timeIntervalSince1970];
            NSString * fileName = [NSString stringWithFormat:@"%@.png",@(timeInterVal)];
            [formData appendPartWithFileData:self.netConfig.singleData name:self.netConfig.imageKey fileName:fileName mimeType:@"image/png"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //(float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount
            //            打印进度
            //            NSLog(@"%lf", 1.0 * (float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self dealWithResponseObject:responseObject cacheUrl:self.netConfig.urlString cacheData:cacheData cache:yycache cacheKey:self.netConfig.isFirstCacheKey task:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"上传文件出错"];
            if (self.failure) {
                self.failure(task, error);
            }
        }];
        
    //上传多张图片
    } else if (self.netConfig.requestType == RequestTypeMultiUpload) {
        [session POST:url parameters:self.netConfig.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            for (NSInteger i = 0; i < self.netConfig.dataArray.count; i++) {
                NSData *imageData = [self.netConfig.dataArray objectAtIndex:i];
                //name和服务端约定好
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"pic%zi", i] fileName:[NSString stringWithFormat:@"%zi.jpg", i] mimeType:@"image/jpeg"];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //(float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
           [self dealWithResponseObject:responseObject cacheUrl:self.netConfig.urlString cacheData:cacheData cache:yycache cacheKey:self.netConfig.isFirstCacheKey task:task];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"上传文件出错"];
            if (self.failure) {
                self.failure(task, error);
            }
        }];
    }
}



#pragma mark 统一处理请求到的数据
/**
 数据处理
 
 @param responseData 接口返回Data
 @param cacheUrl 拼接完的URL
 @param cacheData 缓存data
 @param cache cache
 @param cacheKey cacheKey
 */
- (void)dealWithResponseObject:(NSData *)responseData cacheUrl:(NSString *)cacheUrl cacheData:(id)cacheData cache:(YYCache *)cache cacheKey:(NSString *)cacheKey task:(NSURLSessionDataTask *)task{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//关闭网络指示器（信号那菊花圈）
    });
    
    NSString * dataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
 
    [self returnDataWithRequestData:requestData cache:cache task:task];
}

#pragma mark -先回调缓存-
- (void)returnDataWithCacheData:(NSData *)cacheData cache:(YYCache *)cache task:(NSURLSessionDataTask *)task{
    
//    [MBProgressHUD showLoadToView:[UIApplication sharedApplication].keyWindow title:@"别慌我是缓存"];
    if (cacheData) {
        id memoryCache = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        if (self.success) {
            self.success(task,memoryCache);
        }
    }
}

#pragma mark - 根据返回的数据进行统一的格式处理-requestData
- (void)returnDataWithRequestData:(NSData *)requestData cache:(YYCache *)cache task:(NSURLSessionDataTask *)task{
//    id cacheData = [cache objectForKey:self.netConfig.isFirstCacheKey];
//    if (requestData == nil && cacheData == nil) {
//        return;
//    }
    
    if (requestData == nil) {
        NSLog(@"后台返回的为null");
        return;
    }
    
    if (self.netConfig.isFirstCache) {
        [cache setObject:requestData forKey:self.netConfig.isFirstCacheKey];
    }
    
    id myResult = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
    //判断是否为字典
    if ([myResult isKindOfClass:[NSDictionary  class]]) {
        
//        id memoryCache = nil;
//        if (cacheData != nil) {
//             memoryCache = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
//        }
       
        
        [cache setObject:requestData forKey:self.netConfig.isFirstCacheKey];
        if (self.success) {
//            [MBProgressHUD hideHUD];
            self.success(task,myResult);
        }
    }
}


#pragma mark - 拼接请求的网络地址
- (NSString *)urlDictToStringWithUrlStr:(NSString *)urlString WithDict:(NSDictionary *)parameters
{
    if (!parameters) {
        return urlString;
    }
    return [NSString stringWithFormat:@"%@%@",urlString,[NSString dictionaryToJson:parameters]];
}

#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    //string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

#pragma mark  网络判断
- (BOOL)requestBeforeJudgeConnect
{
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  = (isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}

//#pragma mark - 返回数据的调度显示
//- (void)showSuccess:(id)response
//{
//    if (!self.requestDelegate) {
//        return;
//    }
//    //selector中使用了不存在的方法名（在使用反射机制通过类名创建类对象的时候会需要的）
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wundeclared-selector"
//
//    if ([self.requestDelegate respondsToSelector:@selector(Sucess:)]) {
//        [self.requestDelegate performSelector:@selector(Sucess:) withObject:response withObject:nil];
//        return;
//    }
//
//#pragma clang diagnostic pop
//}
//
//- (void)showError:(NSString *)error
//{
//    if (!self.requestDelegate) {
//        return;
//    }
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wundeclared-selector"
//
//    if ([self.requestDelegate respondsToSelector:@selector(Failed:)]) {
//        [self.requestDelegate performSelector:@selector(Failed:) withObject:error withObject:nil];
//        return;
//    }

//#pragma clang diagnostic pop
//}


@end
