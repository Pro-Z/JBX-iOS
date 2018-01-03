//
//  TokenModel.h
//  JBX
//
//  Created by 证 on 2017/12/18.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TokenDataModel;
@class TokenOtherDataModel;
@interface TokenModel : BaseModel

//@property (nonatomic,copy) NSString *msg;
//@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSArray *otherData;
@property (nonatomic,strong) TokenDataModel *data;
@end

@interface TokenOtherDataModel : BaseModel
@property (nonatomic,strong) NSString *name,*org_id;
@end

@interface TokenDataModel : BaseModel
@property (nonatomic,strong) NSString *token;
@end

