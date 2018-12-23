
//
//  XZYNetConfig.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/16.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "XZYNetConfig.h"

@implementation XZYNetConfig

+(void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = object_getClass((id)self);
        Method imgNameMethod = class_getClassMethod(class, @selector(imageNamed:));
        Method ym_imgNameMethod = class_getClassMethod(class, @selector(ym_imageNamed:))
        ;
        //
        BOOL didAddMethod = class_addMethod(class, @selector(imageNamed:), method_getImplementation(ym_imgNameMethod), method_getTypeEncoding(ym_imgNameMethod));
        if (didAddMethod) {
            class_replaceMethod(class, @selector(ym_imageNamed:), method_getImplementation(imgNameMethod), method_getTypeEncoding(imgNameMethod));
        }else{
            method_exchangeImplementations(imgNameMethod, ym_imgNameMethod);
        }
    });
}


+(UIImage *)ym_imageNamed:(NSString *)name{
    UIImage *image = [self ym_imageNamed:name];
    if (image) {
        NSLog(@"runtime添加额外功能---加载成功");
        
    }else{
        NSLog(@"runtime添加额外功能---加载失败");
    }
    return image;
}

@end
