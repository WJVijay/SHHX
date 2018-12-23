
//
//  HXModel.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/13.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "HXModel.h"
#import <UIKit/UIKit.h>
#import "HXModel.h"

@implementation HXModel

+ (NSArray *)modelWithDictionary:(NSDictionary *)dictResult{
    
    NSString *code = [NSString stringWithFormat:@"%@",dictResult[@"Code"]];
    if ([code isEqualToString:@"0"]) {
        NSArray  *listArray = dictResult[@"Data"];
        NSMutableArray *mulArray = [NSMutableArray array];
        [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXModel *bookData =  [HXModel mj_objectWithKeyValues:obj];
            [mulArray addObject:bookData];
        }];
        return mulArray.copy;
    }else{
        
        return @[];
    }
    
}

@end
