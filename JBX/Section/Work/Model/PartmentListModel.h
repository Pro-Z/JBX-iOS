//
//  PartmentListModel.h
//  JBX
//
//  Created by 证 on 2017/12/19.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PartmentDataListModel;
//@class PartmentContentListModel;
@interface PartmentListModel : BaseModel
@property (nonatomic,strong) NSArray *data;
@end

@interface PartmentDataListModel : BaseModel
@property (nonatomic,strong) NSString *name,*dept_id;
@end

//@interface PartmentContentListModel : BaseModel
//@property (nonatomic,strong) NSString *name;
//@property (nonatomic,strong) NSString *dept_code;
//@end

