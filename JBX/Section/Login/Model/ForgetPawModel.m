//
//  ForgetPawModel.m
//  JBX
//
//  Created by 证 on 2017/12/13.
//  Copyright © 2017年 证. All rights reserved.
//

#import "ForgetPawModel.h"

@implementation ForgetPawModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"phone":@"phone",
             @"verifyCode":@"verifyCode",
             @"password":@"password"
             };
}

- (NSString *)checkIsEmpty {
    if (!_phone || _phone.length <= 0) {
        return @"请输入手机号码!";
    }
    if (!_verifyCode || _verifyCode.length <= 0) {
        return @"请输入验证码!";
    }
    if (!_password || _password.length <= 0) {
        return @"请输入新密码!";
    }
    return nil;
}

@end
