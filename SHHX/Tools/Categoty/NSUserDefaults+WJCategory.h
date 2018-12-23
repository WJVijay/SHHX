//
//  NSUserDefaults+WJCategory.h
//  SHHX
//
//  Created by Yuan Wang on 2018/11/14.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (WJCategory)

+(void)saveUserDefaultObject:(id)object key:(NSString *)key;

+(id)getUserDefaultObjectWithKey:(NSString *)key;

+(void)removeObjectWithKey:(NSString *)key;

@end
