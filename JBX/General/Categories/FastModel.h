//
//  FastModel.h
//  JBX
//
//  Created by 证 on 2017/12/27.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FastModel : NSObject
@property (nonatomic,copy)NSString *ID;
+(void)getModel:(NSDictionary *)dict;
@end
