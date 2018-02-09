//
//  MJBaseModel.h
//  GameManager
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 HGH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJBaseModel : NSObject

@property (nonatomic,copy)NSString *mID;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,assign) NSInteger code;

+(void)getModel:(id)sender;

@end
