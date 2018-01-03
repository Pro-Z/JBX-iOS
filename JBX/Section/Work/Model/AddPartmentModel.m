//
//  AddPartmentModel.m
//  JBX
//
//  Created by 证 on 2017/12/20.
//  Copyright © 2017年 证. All rights reserved.
//

#import "AddPartmentModel.h"

@implementation AddPartmentModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"token":@"token",
             @"org_id":@"org_id",
             @"name":@"name",
             @"parent_dept_id":@"parent_dept_id"
             };
}



@end

