//
//  PartmentListModel.m
//  JBX
//
//  Created by 证 on 2017/12/19.
//  Copyright © 2017年 证. All rights reserved.
//

#import "PartmentListModel.h"

@implementation PartmentListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:PartmentDataListModel.class];
}
@end
@implementation PartmentDataListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"name",
             @"dept_id":@"dept_id"
             };
}
//+(NSValueTransformer*)contentJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:PartmentContentListModel.class];
//}
@end
//@implementation PartmentContentListModel
//+(NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"name":@"name",
//             @"dept_code":@"dept_code"
//             };
//}
//@end

