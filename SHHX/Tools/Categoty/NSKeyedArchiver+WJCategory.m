//
//  NSKeyedArchiver+WJCategory.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/15.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "NSKeyedArchiver+WJCategory.h"

@implementation NSKeyedArchiver (WJCategory)

+(void)saveArchiveRootObject:(id)object toFile:(NSString *)filePath{
    [self archiveRootObject:object  toFile:filePath];
}

+(id)getArchiveRootObjectWithFilePath:(NSString *)filePath{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+(void)removeArchiveRootObjectWithKey:(NSString *)filePath{
    
    //创建文件管理对象
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //获取文件目录
    if (!filePath) {
        return;
    }
    //文件是否存在
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
    //进行逻辑判断
    if (!blHave) {
        NSLog(@"文件不存在");
        return ;
    }else {
        //文件是否被删除
        BOOL blDele= [fileManager removeItemAtPath:filePath error:nil];
        //进行逻辑判断
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            
            NSLog(@"删除失败");
        }
    }
}

@end
