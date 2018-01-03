//
//  TabBarVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "TabBarVC.h"

@interface TabBarVC ()
@property (nonatomic,strong) WorkVC *workTab;
@property (nonatomic,strong) NewsVC *newsTab;
@property (nonatomic,strong) ShopVC *shopTab;
@property (nonatomic,strong) MessageVC *messageTab;
@property (nonatomic,strong) MineVC *mineTab;
@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(238, 238, 238, 1);
    [self initTabBarController];
    [self initTabNavigation];
}

/**
 初始化TabBar
 */
- (void)initTabBarController {
    self.workTab = [WorkVC new];
    self.newsTab = [NewsVC new];
    self.shopTab = [ShopVC new];
    self.messageTab = [MessageVC new];
    self.mineTab = [MineVC new];
    _workTab.title = COMPANY_NAME;

//    UIViewController *naviA = [[UIViewController alloc] init];
    
    BaseNavigationVC *naviA = [[BaseNavigationVC new] initWithRootViewController:self.workTab];
    BaseNavigationVC *naviB = [[BaseNavigationVC new] initWithRootViewController:self.newsTab];
    BaseNavigationVC *naviC = [[BaseNavigationVC new] initWithRootViewController:self.shopTab];
    BaseNavigationVC *naviD = [[BaseNavigationVC new] initWithRootViewController:self.messageTab];
    BaseNavigationVC *naviE = [[BaseNavigationVC new] initWithRootViewController:self.mineTab];
    self.viewControllers = @[naviA,naviB,naviC,naviD,naviE];
    self.selectedIndex = 0;
}

- (void) initTabNavigation {
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBackgroundColor:RGBA(238, 238, 238, 1)];
    UITabBarItem *tabBarItem         = [[UITabBarItem new] initWithTitle:@"工作" image:[UIImage imageNamed:@"first_unselect"] selectedImage:[UIImage imageNamed:@"first_select"] ];
    self.workTab.tabBarItem           = tabBarItem;
    tabBarItem = [[UITabBarItem new] initWithTitle:@"资讯" image:[UIImage imageNamed:@"second_unselect"] selectedImage:[UIImage imageNamed:@"second_select"]];
    self.newsTab.tabBarItem = tabBarItem;
    
    tabBarItem = [[UITabBarItem new] initWithTitle:@"商城" image:[UIImage imageNamed:@"three_unselect"] selectedImage:[UIImage imageNamed:@"three_select"]];
    self.shopTab.tabBarItem = tabBarItem;
    
    tabBarItem = [[UITabBarItem new] initWithTitle:@"消息" image:[UIImage imageNamed:@"four_unselect"] selectedImage:[UIImage imageNamed:@"four_select"]];
    self.messageTab.tabBarItem = tabBarItem;
    tabBarItem = [[UITabBarItem new] initWithTitle:@"我的" image:[UIImage imageNamed:@"five_unselect"] selectedImage:[UIImage imageNamed:@"five_select"]];
    self.mineTab.tabBarItem = tabBarItem;
    
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
