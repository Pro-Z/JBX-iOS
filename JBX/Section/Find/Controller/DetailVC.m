//
//  DetailVC.m
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()
@property (nonatomic,strong) UILabel *nameLab,*priceLab,*updateLab,*browserLab,*applyLab,*offerLab,*requireLab,*goodLab,*addressLab,*addressDetailLab,*jobDesLab,*jobDesContentLab,*companyLab,*companyNameLab,*guimoLab,*propertyLab,*companyAddressLab,*companyIntroLB,*companyIntroContentLB;
@property (nonatomic,strong) UIScrollView *detailSV;
@property (nonatomic,strong) UIButton *applyBtn,*bottomBtn;
@property (nonatomic,strong) UIImageView *locationPic,*recoPic;
@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationView];
    [self initDetailView];
}

- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = @"详情";
    self.navigationItem.hidesBackButton = YES;
    UIView *backView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, 100, 44)];
    UIImageView *backPic = [UIImageView initWithImageViewWithFrame:VIEWFRAME(5, 14, 12, 16) withImageName:@"nav_back"];
    UILabel *backTxt = [[UILabel alloc] initWithFrame:VIEWFRAME(22, 0, 73, 44)];
    backTxt.text = @"";
    backTxt.textColor = [UIColor whiteColor];
    [backView addSubview:backPic];
    [backView addSubview:backTxt];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToBack)];
    [backView addGestureRecognizer:tap];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 推荐工作详情
 */
- (void) initDetailView {
    self.detailSV = [[UIScrollView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-44)];
    _detailSV.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);;
    _detailSV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_detailSV];
    
    self.bottomBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                              withFrame:CGRectZero
                                              withTitle:@"申请职位"
                                         withTitleColor:[UIColor whiteColor]
                                                 withGB:RGBA(3, 115, 228, 1)
                                               withFont:PINGFANG_FONT_SIZE(15)];
    [self.view addSubview:_bottomBtn];
    
    _weekSelf(weakSelf)
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@44);
    }];
    
    
    self.nameLab = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"激光切割师傅"
                                   withTextColor:[UIColor blackColor]
                                        withFont:PINGFANG_FONT_SIZE_BOLD(16)
                                     withGbColor:[UIColor whiteColor]
                               withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_nameLab];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailSV).offset(15);
        make.left.equalTo(weakSelf.detailSV).offset(16);
        make.right.equalTo(weakSelf.detailSV).offset(-16);
        make.height.equalTo(@22);
    }];
    
    self.priceLab = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"面议"
                                    withTextColor:RGBA(250, 117, 2, 1)
                                         withFont:PINGFANG_FONT_SIZE(16)
                                      withGbColor:[UIColor whiteColor]
                                withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_priceLab];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.detailSV).offset(16);
        make.right.equalTo(weakSelf.detailSV).offset(-16);
        make.height.equalTo(@22);
    }];
    
    self.updateLab = [UILabel initUILabelWithFrame:CGRectZero
                                          withText:@"更新于:2018-01-02"
                                     withTextColor:RGBA(135, 135, 135, 1)
                                          withFont:PINGFANG_FONT_SIZE(12)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_updateLab];
    
//    double padding = SCREEN_WIDTH/4;
    [_updateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.detailSV).offset(16);
        make.width.equalTo(@((SCREEN_WIDTH-32)/3));
        make.height.equalTo(@17);
    }];
    
    self.browserLab = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"浏览: 330"
                                     withTextColor:RGBA(135, 135, 135, 1)
                                          withFont:PINGFANG_FONT_SIZE(12)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentCenter];
    [_detailSV addSubview:_browserLab];
    
    [_browserLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.updateLab.mas_right).offset(0);
        make.width.equalTo(@((SCREEN_WIDTH-32)/3));
        make.height.equalTo(@17);
    }];
    
    self.applyLab = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"申请: 20"
                                     withTextColor:RGBA(135, 135, 135, 1)
                                          withFont:PINGFANG_FONT_SIZE(12)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentRight];
    [_detailSV addSubview:_applyLab];
    
    [_applyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.browserLab.mas_right).offset(0);
        make.width.equalTo(@((SCREEN_WIDTH-32)/3));
        make.height.equalTo(@17);
    }];
    
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [_detailSV addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.updateLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@1);
    }];
    
    self.offerLab = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"职位: 切割师傅"
                                    withTextColor:[UIColor blackColor]
                                         withFont:PINGFANG_FONT_SIZE(15)
                                      withGbColor:[UIColor whiteColor]
                                withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_offerLab];
    
    [_offerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView).offset(15);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@21);
    }];
    
    self.requireLab = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"要求: 三年以上经验/招5人"
                                    withTextColor:[UIColor blackColor]
                                         withFont:PINGFANG_FONT_SIZE(15)
                                      withGbColor:[UIColor whiteColor]
                                withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_requireLab];
    
    [_requireLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.offerLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@21);
    }];
    
    self.goodLab = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"福利: 管吃住"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(15)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_goodLab];
    
    [_goodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.requireLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@21);
    }];
    
    UIView *lineView1 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_detailSV addSubview:lineView1];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@10);
    }];
    
    self.addressLab = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"工作地址"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(15)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_addressLab];
   
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@21);
    }];
    
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [_detailSV addSubview:lineView2];
   
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@1);
    }];
    
    self.locationPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"icon_map"];
    [_detailSV addSubview:_locationPic];
    
    [_locationPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.width.equalTo(@12);
        make.height.equalTo(@16);
    }];
    
    self.addressDetailLab = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@"厦门市思明区软件园二期望海路23号之一"
                                            withTextColor:RGBA(102, 102, 102, 1)
                                                 withFont:PINGFANG_FONT_SIZE(15)
                                              withGbColor:[UIColor whiteColor]
                                        withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_addressDetailLab];
    
    [_addressDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.locationPic.mas_right).offset(5);
        make.right.equalTo(weakSelf.view).offset(0);
//        make.height.equalTo(@21);
    }];
    UIView *lineView3 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_detailSV addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.locationPic.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@10);
    }];
    
    self.jobDesLab = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"职位描述"
                                    withTextColor:[UIColor blackColor]
                                         withFont:PINGFANG_FONT_SIZE(15)
                                      withGbColor:[UIColor whiteColor]
                                withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_jobDesLab];
    
    [_jobDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@21);
    }];
    
    UIView *lineView4 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_detailSV addSubview:lineView4];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.jobDesLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@1);
    }];
    
    self.jobDesContentLab = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@"1.熟悉激光数控设备机器及其运作；2.具有较高的工作责任心与学习能力；3.具有较高的组织、协调、沟通能力；4.有机器平常运作的检修能力。"
                                            withTextColor:RGBA(102, 102, 102, 1)
                                                 withFont:PINGFANG_FONT_SIZE(15)
                                              withGbColor:[UIColor whiteColor]
                                        withTextAlignment:NSTextAlignmentLeft];
    _jobDesContentLab.numberOfLines = 0;
    [_detailSV addSubview:_jobDesContentLab];
    
    [_jobDesContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView4.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
    }];
    
    UIView *lineView5 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_detailSV addSubview:lineView5];
    
    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.jobDesContentLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@10);
    }];
    
    self.companyLab = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"公司信息"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(15)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [_detailSV addSubview:_companyLab];
    
    [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView5.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@21);
    }];
    UIView *lineView6 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_detailSV addSubview:lineView6];
    
    [lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.companyLab.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@1);
    }];
    
    
    
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
