//
//  RegisterModel.h
//  EMS
//
//  Created by 上海梓钦 on 2017/7/25.
//  Copyright © 2017年 上海梓钦. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RegisterModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *userName,*password,*verifyCode;

- (NSString *)checkIsEmpty ;

@end
