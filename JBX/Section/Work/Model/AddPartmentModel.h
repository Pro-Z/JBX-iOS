//
//  AddPartmentModel.h
//  JBX
//
//  Created by 证 on 2017/12/20.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddPartmentModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *token,*org_id,*name,*parent_dept_id;
@end

