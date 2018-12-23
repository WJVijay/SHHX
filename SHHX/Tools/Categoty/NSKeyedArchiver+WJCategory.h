//
//  NSKeyedArchiver+WJCategory.h
//  SHHX
//
//  Created by Yuan Wang on 2018/11/15.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedArchiver (WJCategory)

+(void)saveArchiveRootObject:(id)object toFile:(NSString *)filePath;

+(id)getArchiveRootObjectWithFilePath:(NSString *)filePath;

+(void)removeArchiveRootObjectWithKey:(NSString *)filePath;

@end

