//
//  TipsVC.m
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import "TipsVC.h"

@interface TipsVC ()

@end

@implementation TipsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTipsView];
}
- (void) initTipsView {
    UIView *tipsview = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [self.view addSubview:tipsview];
    _weekSelf(weakSelf)
    [tipsview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@92);
    }];
    // 我的简历
    UIView *mineCV = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [tipsview addSubview:mineCV];
    UIImageView *firstPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"icon_resume"];
    [mineCV addSubview:firstPic];
    UILabel *firstTxt = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"我的简历"
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentCenter];
    [mineCV addSubview:firstTxt];
    [firstPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineCV).offset(15);
        make.centerX.equalTo(mineCV.mas_centerX).offset(0);
        make.height.equalTo(@22);
        make.width.equalTo(@22);
    }];
    
    [firstTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstPic.mas_bottom).offset(10);
        make.centerX.equalTo(mineCV.mas_centerX).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];

    // 我的求职
    UIView *mineWork = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [tipsview addSubview:mineWork];
    UIImageView *secondPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"icon_want"];
    [mineWork addSubview:secondPic];
    UILabel *secondTxt = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"我的求职"
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentCenter];
    [mineWork addSubview:secondTxt];
    [secondPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineWork).offset(15);
        make.centerX.equalTo(mineWork.mas_centerX).offset(0);
        make.height.equalTo(@22);
        make.width.equalTo(@22);
    }];
    
    [secondTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondPic.mas_bottom).offset(10);
        make.centerX.equalTo(mineWork.mas_centerX).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    // 我要找人
    UIView *mineHire = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [tipsview addSubview:mineHire];
    
    UIImageView *threePic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"icon_recruit"];
    [mineHire addSubview:threePic];
    UILabel *threeTxt = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"我要招人"
                                         withTextColor:[UIColor blackColor]
                                              withFont:PINGFANG_FONT_SIZE(14)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentCenter];
    [mineHire addSubview:threeTxt];
    [threePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineHire).offset(15);
        make.centerX.equalTo(mineHire.mas_centerX).offset(0);
        make.height.equalTo(@22);
        make.width.equalTo(@22);
    }];
    
    [threeTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(threePic.mas_bottom).offset(10);
        make.centerX.equalTo(mineHire.mas_centerX).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    
    [@[mineCV,mineWork,mineHire] mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [@[mineCV,mineWork,mineHire] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsview).offset(10);
        make.height.mas_equalTo(@72);
    }];
    
    // 点击事件
    mineCV.userInteractionEnabled = YES;
    mineWork.userInteractionEnabled = YES;
    mineHire.userInteractionEnabled = YES;
    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstTapG)];
    [mineCV addGestureRecognizer:firstTap];
    UITapGestureRecognizer *secondTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondTapG)];
    [mineWork addGestureRecognizer:secondTap];
    UITapGestureRecognizer *threeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(threeTapG)];
    [mineHire addGestureRecognizer:threeTap];
    
}
- (void) firstTapG {
//    DebugLog(@"点击了第一个");
    if (self.callback) {
        self.callback([NSNumber numberWithInteger:0]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) secondTapG {
//    DebugLog(@"点击了第二个");
    if (self.callback) {
        self.callback([NSNumber numberWithInteger:1]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) threeTapG {
//    DebugLog(@"点击了第三个");
    if (self.callback) {
        self.callback([NSNumber numberWithInteger:2]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
