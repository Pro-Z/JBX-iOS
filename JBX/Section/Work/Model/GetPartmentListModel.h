//
//  GetPartmentListModel.h
//  JBX
//
//  Created by 证 on 2017/12/19.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPartmentListModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *token,*parent_dept_id,*name,*org_id;
@end

