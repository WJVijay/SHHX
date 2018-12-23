//
//  WJAES.h
//  SHHX
//
//  Created by Yuan Wang on 2018/11/15.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAES : NSObject

+ (NSString *)encryptURL:(NSString *)message;
+ (NSString *)decryptURL:(NSString *)base64EncodedString;

+ (NSString *)encrypt:(NSString *)message;
+ (NSString *)decrypt:(NSString *)base64EncodedString;
+ (NSString *)encrype:(id)objc;
+ (NSDictionary *)decryptToDic:(NSString *)base64EncodedString;
+ (NSArray *)decryptToArray:(NSString *)base64EncodedString;

@end

