//
//  XZYNetConfig.h
//  SHHX
//
//  Created by Yuan Wang on 2018/11/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZYNetConfig : NSObject

@property (copy  ,nonatomic)NSString                         *urlString;//url

@property (strong,nonatomic)NSDictionary                     *param; //参数

@property (assign,nonatomic)BOOL                             isCache; //是否缓存

@end

NS_ASSUME_NONNULL_END
