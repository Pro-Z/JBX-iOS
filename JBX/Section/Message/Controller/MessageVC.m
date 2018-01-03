//
//  MessageVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initConfigurationNavigation];
    
}
// 配置导航头
- (void) initConfigurationNavigation {
    self.navigationItem.title = @"消息";
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setTitle:@"通讯录" forState:(UIControlStateNormal)];
    [rightBtn setTintColor:[UIColor whiteColor]];
    rightBtn.titleLabel.font = PINGFANG_FONT_SIZE(15);
//    rightBtn.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBtn addTarget:self action:@selector(contactBtn) forControlEvents:(UIControlEventTouchUpInside)];
}
// 打开通讯录
- (void) contactBtn {
    
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
