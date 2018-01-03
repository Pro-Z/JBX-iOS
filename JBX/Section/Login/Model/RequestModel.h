//
//  RequestModel.h
//  EMS
//
//  Created by 上海梓钦 on 2017/7/25.
//  Copyright © 2017年 上海梓钦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger status;
@property (nonatomic,copy) NSString *msg;

@end

