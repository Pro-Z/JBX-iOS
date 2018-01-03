//
//  BaseNavigationVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()

@end

@implementation BaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configurationNavigation];
}

- (void) configurationNavigation {
    self.navigationBar.tintColor = APP_COLOR_BASE_NAV;
    self.navigationBar.barTintColor = APP_COLOR_BASE_NAV;
    self.navigationBar.translucent = NO;
    self.view.backgroundColor = RGBA(238, 238, 238, 1);
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:PINGFANG_FONT_SIZE_BOLD(17)}];
    WHITE_STATUS_BAR_COLOR
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
