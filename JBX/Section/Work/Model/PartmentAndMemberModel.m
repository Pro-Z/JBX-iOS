//
//  PartmentAndMemberModel.m
//  JBX
//
//  Created by 证 on 2017/12/26.
//  Copyright © 2017年 证. All rights reserved.
//

#import "PartmentAndMemberModel.h"

@implementation PartmentAndMemberModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}
@end

@implementation PartmentAndMemberDictModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dept":@"dept",
             @"member":@"member"
             };
}
+(NSValueTransformer*)deptJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:PartmentAndMemberDeptArrModel.class];
}
+(NSValueTransformer*)memberJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:PartmentAndMemberMemArrModel.class];
}

@end

@implementation PartmentAndMemberDeptArrModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dept_id":@"dept_id",
             @"name":@"name"
             };
}
@end

@implementation PartmentAndMemberMemArrModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             };
}
@end
