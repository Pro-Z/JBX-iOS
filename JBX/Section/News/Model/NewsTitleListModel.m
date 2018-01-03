//
//  NewsTitleListModel.m
//  JBX
//
//  Created by 证 on 2017/12/27.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NewsTitleListModel.h"

@implementation NewsTitleListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:NewsDataArrModel.class];
}

@end
@implementation NewsDataArrModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"ids":@"id",
             @"key_name":@"key_name"
             };
}
+ (NSValueTransformer *)idsJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
        //如果是字符串类型的我们返回他字符串类型
        return string;
    } reverseBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        //如果是NSnumber类型，我们返回string类型
        return [number stringValue];
    }];
}


@end
