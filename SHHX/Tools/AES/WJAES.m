//
//  WJAES.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/15.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJAES.h"
#import "AES.h"
#import "NSString+SKURLEncode.h"
#define KEY @"C16D81FD0816578F623370F1C870DE03"

@implementation WJAES
// For URL
+ (NSString *)encryptURL:(NSString *)message
{
    return  [[AES encrypt:message password:KEY] SKEncode];
}

+ (NSString *)decryptURL:(NSString *)base64EncodedString
{
    return [[AES decrypt:base64EncodedString password:KEY] SKDecode];
}


// For Data
+ (NSString *)encrypt:(NSString *)message
{
    return  [AES encrypt:message password:KEY];
}

+ (NSString *)encrype:(id)objc
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:objc options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    NSString *dataStr= [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return [AES encrypt:dataStr password:KEY];
}

+ (NSString *)decrypt:(NSString *)base64EncodedString
{
    return [AES decrypt:base64EncodedString password:KEY];
}

+ (NSDictionary *)decryptToDic:(NSString *)base64EncodedString
{
    NSString *string = [AES decrypt:base64EncodedString password:KEY];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
}
+ (NSArray *)decryptToArray:(NSString *)base64EncodedString
{
    NSString *string = [AES decrypt:base64EncodedString password:KEY];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
}
@end
