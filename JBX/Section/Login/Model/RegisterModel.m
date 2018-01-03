//
//  RegisterModel.m
//

#import "RegisterModel.h"

@implementation RegisterModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userName":@"phone",
             @"password":@"password",
             @"verifyCode":@"verifyCode"
             };
}

- (NSString *)checkIsEmpty {
    if (!_userName || _userName.length <= 0) {
        return @"请输入手机号!";
    }
    if (!_verifyCode || _verifyCode.length <= 0) {
        return @"请输入验证码!";
    }
    if (!_password || _password.length <= 0) {
        return @"请输入密码";
    }
    return nil;
    
}

@end
