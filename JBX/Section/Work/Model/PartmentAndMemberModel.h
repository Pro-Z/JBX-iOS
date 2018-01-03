//
//  PartmentAndMemberModel.h
//  JBX
//
//  Created by 证 on 2017/12/26.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PartmentAndMemberDictModel;
@interface PartmentAndMemberModel : BaseModel
@property (nonatomic,strong) PartmentAndMemberDictModel *data;
@end

@interface PartmentAndMemberDictModel : BaseModel
@property (nonatomic,strong) NSArray *dept;
@property (nonatomic,strong) NSArray *member;
@end

@interface PartmentAndMemberDeptArrModel : BaseModel
@property (nonatomic,strong) NSString *dept_id,*name;
@end

@interface PartmentAndMemberMemArrModel : BaseModel

@end
