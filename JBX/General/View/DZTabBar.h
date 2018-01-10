//
//  DZTabBar.h
//  CustomTabBarDemo
//
//  Created by 证 on 2018/1/5.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZTabBar;
@protocol DZTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(DZTabBar *)tabBar;
@end

@interface DZTabBar : UITabBar
@property (nonatomic, weak) id<DZTabBarDelegate> myDelegate ;
@end
