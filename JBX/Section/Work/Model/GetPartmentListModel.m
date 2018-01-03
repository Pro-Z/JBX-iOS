//
//  GetPartmentListModel.m
//  JBX
//
//  Created by 证 on 2017/12/19.
//  Copyright © 2017年 证. All rights reserved.
//

#import "GetPartmentListModel.h"

@implementation GetPartmentListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"parent_dept_id":@"parent_dept_id",
             @"token":@"token",
             @"name":@"name",
             @"org_id":@"org_id"
             };
}
@end
