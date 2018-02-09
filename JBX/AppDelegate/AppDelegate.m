//
//  AppDelegate.m
//  JBX
//
//  Created by 证 on 2017/12/1.
//  Copyright © 2017年 证. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <UMShare/UMShare.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:APP_BOUNDS];
    
    // 配置友盟分享
    [[UMSocialManager defaultManager] openLog:YES];
    // 设置友盟key
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a686f2ef43e485abc00002a"];
    // 设置qq
    [[UMSocialManager defaultManager] setPlaform:(UMSocialPlatformType_QQ) appKey:@"1106627131" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    // 设置微信
    [[UMSocialManager defaultManager] setPlaform:(UMSocialPlatformType_WechatSession) appKey:@"wx06f743d492caa4c3" appSecret:@"e380fe2466a5413506b1ea0860c7ac93" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    // 配置键盘
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    
    
    //适配iOS11
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
        
    }
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst1"];
    DebugLog(@"打印%@",isFirst?@"YES":@"NO");
//    if (!isFirst) {
//        GuideVC *guideVC = [GuideVC new];
//        self.window.rootViewController = guideVC;
//    }else{
        LaunchVC *launch = [LaunchVC new];
        self.window.rootViewController = launch;
//    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
