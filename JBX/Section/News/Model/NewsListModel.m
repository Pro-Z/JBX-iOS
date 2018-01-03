//
//  NewsListModel.m
//  JBX
//
//  Created by 证 on 2017/12/29.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NewsListModel.h"

@implementation NewsListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}
@end

@implementation NewsDataListModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"total":@"total",
             @"EcInformation":@"EcInformation"
             };
};
+(NSValueTransformer*)ecInformationJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:NewsEcInformationArrModel.class];
}

@end

@implementation NewsEcInformationArrModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"add_time":@"add_time",
             @"content":@"content",
             @"imgUrl":@"imgUrl",
             @"title":@"title",
             @"ids":@"id"
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
