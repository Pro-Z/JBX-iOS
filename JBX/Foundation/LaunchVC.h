//
//  LaunchVC.h
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverVC.h"
#import "TabBarVC.h"

@interface LaunchVC : UIViewController
@property(nonatomic,strong) CoverVC *coverVC;
@property(nonatomic,strong) TabBarVC *tabBarVC;
@end
