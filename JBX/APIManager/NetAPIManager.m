//
//  NetAPIManager.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NetAPIManager.h"
#import "LoginModel.h"
#import "RequestModel.h"
#import "BaseModel.h"
#import "TokenModel.h"
#import "SelectVC.h"
#import "SetOrganIDModel.h"
#import "NetSsoClient.h"


@implementation NetAPIManager

+ (instancetype)sharedManager {
    static NetAPIManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self new] init];
    });
    return shareManager;
}

// 通用接口
- (void)request_common_WithPath:(NSString *)aPath Params:(id)params succesBlack:(void (^)(id data))successBlock failue:(void (^)(id data,NSError *error))failueBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:aPath withParams:requestDict withMethedType:NetwrkType_Post autoShowProgressHUD:NO success:^(id data) {
        successBlock(data);
    } failure:^(id data, NSError *error) {
        failueBlock(data,error);
    }];
}

- (void)request_common_WithPath:(NSString *)aPath Params:(id)params autoShowProgressHUD:(BOOL)autoShowProgressHUD succesBlack:(void (^)(id data))successBlock failue:(void (^)(id data,NSError *error))failueBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:aPath withParams:requestDict withMethedType:NetwrkType_Post autoShowProgressHUD:(BOOL)autoShowProgressHUD success:^(id data) {
        successBlock(data);
    } failure:^(id data, NSError *error) {
        failueBlock(data,error);
    }];
}
// get
- (void)request_common_WithPath:(NSString *)aPath Params:(id)params autoShowProgressHUD:(BOOL)autoShowProgressHUD typeGet:(BOOL)isGet succesBlack:(void (^)(id))successBlock failue:(void (^)(id, NSError *))failueBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:aPath withParams:requestDict withMethedType:NetwrkTyp_Get autoShowProgressHUD:(BOOL)autoShowProgressHUD success:^(id data) {
        successBlock(data);
    } failure:^(id data, NSError *error) {
        failueBlock(data,error);
    }];
}
- (void)request_common_WithPath:(NSString *)aPath Params:(id)params autoShowProgressHUD:(BOOL)autoShowProgressHUD typeGets:(BOOL)isGet succesBlack:(void (^)(id))successBlock failue:(void (^)(id, NSError *))failueBlock {
//    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:aPath withParams:params withMethedType:NetwrkTyp_Get autoShowProgressHUD:(BOOL)autoShowProgressHUD success:^(id data) {
        successBlock(data);
    } failure:^(id data, NSError *error) {
        failueBlock(data,error);
    }];
}


// login
- (void)request_Login_WithParams:(id)params successBlock:(void (^)(id))successBlock failure:(void (^)(id, NSError *))failureBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    NSString *pathStr = APP_LOGIN_URL;
    [[NetSsoClient shareNetAPIClient] requestJsonDataWithPath:pathStr withParams:requestDict withMethedType:NetwrkTyp_Get autoShowProgressHUD:YES success:^(id data) {
        TokenModel *loginModel = [MTLJSONAdapter modelOfClass:[TokenModel class] fromJSONDictionary:data error:nil];
        successBlock(loginModel);
    } failure:^(id data, NSError *error) {
        DebugLog(@"登陆出错!");
    }];
}
// register
- (void)request_register_WithParams:(id)params successBlock:(void (^)(id))successBlock failure:(void (^)(id, NSError *))failureBlock {
    NSDictionary *requestDic = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:APP_REGISTER_URL withParams:requestDic withMethedType:NetwrkType_Post autoShowProgressHUD:YES success:^(id data) {
        RequestModel *requestModel = [MTLJSONAdapter modelOfClass:[RequestModel class] fromJSONDictionary:data error:nil];
        if (requestModel.status == 200) {
            [NSObject showHudTipStr:@"注册成功!"];
        }else{
            [NSObject showHudTipStr:requestModel.msg];
        }
        
    } failure:^(id data, NSError *error) {
        [NSObject showError:error];
    }];
}

// sendSms
- (void)request_SendSms_WithParams:(id)params successBlock:(void (^)(id))successBlock failure:(void (^)(id, NSError *))failureBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    NSString *pathStr = APP_GET_SMS_URL;
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:pathStr withParams:requestDict withMethedType:NetwrkTyp_Get autoShowProgressHUD:YES success:^(id data) {
        
        RequestModel *loginModel = [MTLJSONAdapter modelOfClass:[RequestModel class] fromJSONDictionary:data error:nil];
        if (loginModel.status == 200) {
            [NSObject showInfoHudTipStr:@"验证码发送成功!"];
        }else{
            [NSObject showInfoHudTipStr:loginModel.msg];
        }
        successBlock(loginModel);
    } failure:^(id data, NSError *error) {
        DebugLog(@"登陆出错!");
    }];
}


- (void)request_FindPaw_WithParams:(id)params successBlock:(void (^)(id))successBlock failure:(void (^)(id, NSError *))failureBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    NSString *pathStr = APP_FORGETPAW_URL;
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:pathStr withParams:requestDict withMethedType:NetwrkType_Post autoShowProgressHUD:YES success:^(id data) {
        RequestModel *loginModel = [MTLJSONAdapter modelOfClass:[RequestModel class] fromJSONDictionary:data error:nil];
        if (loginModel.status == 200) {
            [NSObject showInfoHudTipStr:@"密码找回成功!"];
        }else{
            [NSObject showInfoHudTipStr:loginModel.msg];
        }
        successBlock(loginModel);
    } failure:^(id data, NSError *error) {
        DebugLog(@"登陆出错!");
    }];
}

- (void)request_SetOrgan_WithParams:(id)params successBlock:(void (^)(id data))successBlock failure:(void(^)(id data,NSError *error))failureBlock {
    NSDictionary *requestDict = [MTLJSONAdapter JSONDictionaryFromModel:params error:nil];
    NSString *pathStr = APP_SET_ORGAN_URL;
    [[NetRequestClient shareNetAPIClient] requestJsonDataWithPath:pathStr withParams:requestDict withMethedType:NetwrkType_Post autoShowProgressHUD:YES success:^(id data) {
        BaseModel *loginModel = [MTLJSONAdapter modelOfClass:[BaseModel class] fromJSONDictionary:data error:nil];
        successBlock(loginModel);
    } failure:^(id data, NSError *error) {
        DebugLog(@"请求出错!");
    }];
}









@end
