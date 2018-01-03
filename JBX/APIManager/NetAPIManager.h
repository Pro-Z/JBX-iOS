//
//  NetAPIManager.h
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequestClient.h"
#pragma mark - 老子是接口
@interface NetAPIManager : NSObject

+ (instancetype)sharedManager;

// 通用接口
//post
- (void)request_common_WithPath:(NSString *)aPath Params:(id)params succesBlack:(void (^)(id data))successBlock failue:(void (^)(id data,NSError *error))failueBlock;

- (void)request_common_WithPath:(NSString *)aPath Params:(id)params autoShowProgressHUD:(BOOL)autoShowProgressHUD succesBlack:(void (^)(id data))successBlock failue:(void (^)(id data,NSError *error))failueBlock;
// get
- (void)request_common_WithPath:(NSString *)aPath Params:(id)params autoShowProgressHUD:(BOOL)autoShowProgressHUD typeGet:(BOOL)isGet succesBlack:(void (^)(id data))successBlock failue:(void (^)(id data,NSError *error))failueBlock;
- (void)request_common_WithPath:(NSString *)aPath Params:(id)params autoShowProgressHUD:(BOOL)autoShowProgressHUD typeGets:(BOOL)isGet succesBlack:(void (^)(id data))successBlock failue:(void (^)(id data,NSError *error))failueBlock;

// 登陆
- (void)request_Login_WithParams:(id)params successBlock:(void (^)(id data))successBlock failure:(void(^)(id data,NSError *error))failureBlock;
// 注册
- (void)request_register_WithParams:(id)params successBlock:(void (^)(id data))successBlock failure:(void(^)(id data,NSError *error))failureBlock;

// 发送验证码
- (void)request_SendSms_WithParams:(id)params successBlock:(void (^)(id data))successBlock failure:(void(^)(id data,NSError *error))failureBlock;

// 找回密码
- (void)request_FindPaw_WithParams:(id)params successBlock:(void (^)(id data))successBlock failure:(void(^)(id data,NSError *error))failureBlock;
// 设置组织机构
- (void)request_SetOrgan_WithParams:(id)params successBlock:(void (^)(id data))successBlock failure:(void(^)(id data,NSError *error))failureBlock;



@end
