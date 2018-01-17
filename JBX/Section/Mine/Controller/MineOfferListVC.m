//
//  MineOfferListVC.m
//  JBX
//
//  Created by 证 on 2018/1/16.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MineOfferListVC.h"

@interface MineOfferListVC ()

@end

@implementation MineOfferListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DebugLog(@"当前的页面为%ld",self.pageID);
    DebugLog(@"当前的页面为%@",self.titleStr);
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
