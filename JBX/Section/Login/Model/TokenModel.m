//
//  TokenModel.m
//  JBX
//
//  Created by 证 on 2017/12/18.
//  Copyright © 2017年 证. All rights reserved.
//

#import "TokenModel.h"


@implementation TokenModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"code":@"code",
        @"msg":@"msg",
        @"otherData":@"otherData",
        @"data":@"data"
    };
}
//+(NSValueTransformer*)dataJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:TokenDataModel.class];
//}

+(NSValueTransformer*)otherDataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:TokenOtherDataModel.class];
}



@end

@implementation TokenOtherDataModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"name",
             @"org_id":@"org_id"
             };
}
@end

@implementation TokenDataModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"token":@"token"
             };
}
@end
