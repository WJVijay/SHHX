//
//  HXUserInfo.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "HXUserInfo.h"

@implementation HXUserInfo
WJSingleImplementation(UserBase);

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iva = ivar[i];
        const char *name = ivar_getName(iva);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:strName];
            //利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

- (BOOL)isLogin{
    return [NSUserDefaults getUserDefaultObjectWithKey:@"token"] ? YES:NO;
}

- (void)setIsAutoLogin:(BOOL)isAutoLogin{
    _isAutoLogin = isAutoLogin;
    [NSUserDefaults saveUserDefaultObject:[NSString stringWithFormat:@"%d",isAutoLogin] key:@"isAutoLogin"];
}

@end
