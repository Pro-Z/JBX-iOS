//
//  NSObject+ProgressHUD.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NSObject+ProgressHUD.h"
#import "AppDelegate.h"

@implementation NSObject (ProgressHUD)


+ (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if (error.userInfo[@"codeInfo"]) {
            [tipStr appendString:error.userInfo[@"codeInfo"]];
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode = %ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}

+ (void)showError:(NSError *)error{
    NSString *tipStr = [NSObject tipFromError:error];
    [NSObject showHudTipStr:tipStr];
}

+ (void)showSuccessHudTipStr:(NSString *)tipStr {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] ];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor] ];
    [SVProgressHUD showSuccessWithStatus:tipStr];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:0.5];
//    [SVProgressHUD showSuccessWithStatus:tipStr maskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showInfoHudTipStr:(NSString *)tipStr {
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] ];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor] ];
    [SVProgressHUD showInfoWithStatus:tipStr];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:0.5];
//    [SVProgressHUD showInfoWithStatus:tipStr maskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KEY_WINDOW animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font=[UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.text = tipStr;
//        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
//        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1];
    }
}

+ (void)showProgressHUD {
    //    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] ];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor] ];
    [SVProgressHUD setForegroundColor:APP_COLOR_BASE_BUTTON_RED ];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)dismissProgressHUD {
    [SVProgressHUD dismiss];
}

#pragma mark - NetError
- (id)handleResponse:(id)responseJSON {
    return [self handleResponse:responseJSON autoShowError:YES];
}

// 处理错误提示信息
- (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    //TODO:code为非0值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"status"];
    NSString *resultString = [responseJSON valueForKeyPath:@"msg"];
    // 系统异常处理
    if (resultCode.integerValue != 0) {
        error = [NSError errorWithDomain:@"" code:resultCode.integerValue userInfo:responseJSON];
        TipAlert(@"%@",resultString);
        return error;
    }
//    if (resultCode.integerValue == 0) {
    
//        error = [NSError errorWithDomain:@"" code:resultCode.integerValue userInfo:responseJSON];
        
//        if (resultCode.intValue == 1) { // TODO:用户未登录或者登陆超时
            // TODO:登录超时或未登录提示信息
//            UserModel *user = [LoginModel curLoginUser];
//            NSString *promptString = user ? @"登录超时,请重新登录" : @"您还未登录,快去登录吧";
//            if ([LoginModel isLogin]) {
//                [LoginModel doLoginOut];
//            }
//            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PRESENT_LOGINVIEWCONTROLLER object:nil];
//            
//            TipAlert(@"%@",promptString);
//        }else{
//            if (autoShowError) {
//                [NSObject showError:error];
//            }
//        }
//    }
    return error;
}

@end
