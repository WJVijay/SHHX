
//
//  NSUserDefaults+WJCategory.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/14.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "NSUserDefaults+WJCategory.h"

@implementation NSUserDefaults (WJCategory)

+(void)saveUserDefaultObject:(id)object key:(NSString *)key{
    
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}


+(id)getUserDefaultObjectWithKey:(NSString *)key{
    
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    id tempObject = [defaults objectForKey:key];
    return tempObject;
}


+(void)removeObjectWithKey:(NSString *)key{
    
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}


@end
