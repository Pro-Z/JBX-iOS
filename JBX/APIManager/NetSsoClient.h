//
//  NetSsoClient.h
//  JBX
//
//  Created by 证 on 2018/2/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#define kNetworkTypeName @[@"Get",@"Post"]
// 网络请求类型
typedef NS_ENUM(NSInteger,NetwrkTypes) {
    NetwrkTyp_Gets = 0, // GET请求
    NetwrkType_Posts = 1,    // POST请求
};
@interface NetSsoClient : NSObject
// 单例模式
+ (instancetype)shareNetAPIClient;
//+ (instancetype)shareNetsAPIClient;

/**
 带自动提示错误的请求接口
 
 @param path 请求路径
 @param params 请求参数
 @param networktype 请求类型
 @param autoShowProgressHUD 是否需要转圈
 @param successBlock 成功回调Block
 @param failureBlock 失败回调Block
 */
- (void)requestJsonDataWithPath:(NSString*)path
                     withParams:(id)params
                 withMethedType:(NetwrkType)networktype
            autoShowProgressHUD:(BOOL)autoShowProgressHUD
                        success:(void(^)(id data))successBlock
                        failure:(void(^)(id data, NSError *error))failureBlock;


/**
 网络请求接口
 
 @param path 请求路径
 @param params 请求参数
 @param networktype 网络类型
 @param autoShowProgressHUD 是否菊花
 @param autoShowError 是否显示错误
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)requestJsonDataWithPath:(NSString *)path
                     withParams:(id)params
                 withMethedType:(NetwrkType)networktype
            autoShowProgressHUD:(BOOL)autoShowProgressHUD
                  autoShowError:(BOOL)autoShowError
                        success:(void (^)(id))successBlock
                        failure:(void (^)(id, NSError *))failureBlock;



@end
