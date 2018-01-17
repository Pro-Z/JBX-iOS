//
//  MBProgressHUD+Toast.h
//  JBX
//
//  Created by 证 on 2018/1/17.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Toast)

+ (MBProgressHUD *)createHUD:(UIView *)view;
+ (MBProgressHUD *)defaultMBProgress:(UIView *)view;
+ (MBProgressHUD *)defaultMBProgressWithText:(NSString *)text view:(UIView *)view;


+ (void)showSuccess:(NSString *)success view:(UIView *)view;
+ (void)showError:(NSString *)error view:(UIView *)view;
+ (MBProgressHUD *)showNotice:(NSString *)notice view:(UIView *)view;

/*****帧动画*****/
+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view;

+ (void)drawErrorViewWithText:(NSString *)text view:(UIView *)view;
+ (void)drawRightViewWithText:(NSString *)text view:(UIView *)view;
+ (MBProgressHUD *)drawRoundLoadingView:(NSString *)tex view:(UIView *)view;
@end
