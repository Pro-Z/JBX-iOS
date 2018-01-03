//
//  NSObject+ProgressHUD.h
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ProgressHUD)

+ (NSString *)tipFromError:(NSError *)error;
+ (void)showError:(NSError *)error;
+ (void)showHudTipStr:(NSString*)tipStr;
+ (void)showSuccessHudTipStr:(NSString*)tipStr;
+ (void)showInfoHudTipStr:(NSString *)tipStr;
+ (void)showProgressHUD;
+ (void)dismissProgressHUD;

-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

@end
