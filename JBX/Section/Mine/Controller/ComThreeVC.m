//
//  ComThreeVC.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "ComThreeVC.h"
#import "LookOrderCell.h"
#import "ComSecondVC.h"

@interface ComThreeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) UILabel *titleLB,*orderServiceLB,*orderServiceContentLB,*timeRequireLb,*timeRequireContentLB,*pickTimeLB,*pickTimeContentLB,*otherLB,*otherContentLB,*lookOrderDetailLB;
@property (nonatomic,strong) UIButton *bottomBtn;
@end

@implementation ComThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    [self initNavigationView];
    [self initHeaderView];
    [self initTableView];
}

- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = @"询价单详情";
    self.navigationItem.hidesBackButton = YES;
    UIView *backView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, 100, 44)];
    UIImageView *backPic = [UIImageView initWithImageViewWithFrame:VIEWFRAME(5, 14, 12, 16) withImageName:@"nav_back"];
    UILabel *backTxt = [[UILabel alloc] initWithFrame:VIEWFRAME(22, 0, 73, 44)];
    backTxt.text = @"返回";
    backTxt.textColor = [UIColor whiteColor];
    [backView addSubview:backPic];
    [backView addSubview:backTxt];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToBack)];
    [backView addGestureRecognizer:tap];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_job_user"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
//    rightBtn.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = rightBtn;
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void) operateBtn {
//    // TO DO SOMETHING
//
//}

- (void) initHeaderView {
    _weekSelf(weakSelf);
    self.headerView = [UIView initWithUIViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 270) withBackground:[UIColor whiteColor]];
   
    
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.headerView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(weakSelf.headerView).offset(0);
        make.height.equalTo(@10);
    }];
    self.titleLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"询价单备注"
                                                  withTextColor:RGBA(0, 118, 255, 1)
                                                       withFont:PINGFANG_FONT_SIZE(16)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_titleLB];
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.headerView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
        make.height.equalTo(@1);
    }];
    
    self.orderServiceLB = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"订单服务: "
                                                  withTextColor:RGBA(102, 102, 102, 1)
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_orderServiceLB];
    
    [_orderServiceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/5));
    }];
    self.orderServiceContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"激光服务"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_orderServiceContentLB];
    
    [_orderServiceContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.orderServiceLB.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    self.timeRequireLb = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"工期要求: "
                                          withTextColor:RGBA(102, 102, 102, 1)
                                               withFont:PINGFANG_FONT_SIZE(14)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_timeRequireLb];
    
    [_timeRequireLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderServiceLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/5));
    }];
    self.timeRequireContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                      withText:@"10天"
                                                 withTextColor:[UIColor blackColor]
                                                      withFont:PINGFANG_FONT_SIZE(14)
                                                   withGbColor:[UIColor whiteColor]
                                             withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_timeRequireContentLB];
    
    [_timeRequireContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderServiceContentLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.timeRequireLb.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    
    self.pickTimeLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"提货日期: "
                                         withTextColor:RGBA(102, 102, 102, 1)
                                              withFont:PINGFANG_FONT_SIZE(14)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_pickTimeLB];
    
    [_pickTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeRequireLb.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/5));
    }];
    self.pickTimeContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                     withText:@"2018-01-20"
                                                withTextColor:[UIColor blackColor]
                                                     withFont:PINGFANG_FONT_SIZE(14)
                                                  withGbColor:[UIColor whiteColor]
                                            withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_pickTimeContentLB];
    
    [_pickTimeContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeRequireLb.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.pickTimeLB.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    
    self.otherLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"补充信息: "
                                      withTextColor:RGBA(102, 102, 102, 1)
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_otherLB];
    
    [_otherLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pickTimeLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/5));
    }];
    self.otherContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@"补充信息阿什顿发斯蒂芬阿斯顿发生发生的阿什顿发斯蒂芬阿斯蒂芬法法师的发斯蒂芬啊爱迪生"
                                             withTextColor:[UIColor blackColor]
                                                  withFont:PINGFANG_FONT_SIZE(14)
                                               withGbColor:[UIColor whiteColor]
                                         withTextAlignment:NSTextAlignmentLeft];
    _otherContentLB.numberOfLines = 0;
    [self.headerView addSubview:_otherContentLB];
    
    [_otherContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pickTimeContentLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.otherLB.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    UIView *lineView3 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.headerView addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.otherContentLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
        make.height.equalTo(@10);
    }];
    self.lookOrderDetailLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"询价单信息"
                                                  withTextColor:RGBA(0, 118, 255, 1)
                                                       withFont:PINGFANG_FONT_SIZE(16)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_lookOrderDetailLB];
    
    [_lookOrderDetailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        make.bottom.equalTo(weakSelf.headerView.mas_bottom).offset(-10);
    }];
    
}



- (void) initTableView {
    
    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _detailTableView.backgroundColor = RGBA(236, 238, 241, 1);
    _detailTableView.delegate =self;
    _detailTableView.dataSource = self;
    _detailTableView.tableHeaderView = _headerView;
    [_detailTableView registerClass:[LookOrderCell class] forCellReuseIdentifier:@"LookOrderCell"];
    [self.view addSubview:_detailTableView];
    _weekSelf(weakSelf)
    [_detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(-44);
    }];
    self.bottomBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                           withFrame:CGRectZero
                                                           withTitle:@"立即报价"
                                                      withTitleColor:[UIColor whiteColor]
                                                              withGB:RGBA(50, 198, 7, 1)
                                                            withFont:PINGFANG_FONT_SIZE(16)];
    
    [self.view addSubview:_bottomBtn];
    
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@44);
    }];
    [_bottomBtn addTarget:self action:@selector(orderPriceNow) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

- (void) orderPriceNow {
    // 跳转到报价页面
    ComSecondVC *secondVC = [ComSecondVC new];
    secondVC.currentPage = -1;
    secondVC.currentTitle = @"订单报价";
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"LookOrderCell";
    LookOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    cell.firstLB.text = @"订货单号：123";
    cell.secondLB.text = @"部件个数：123";
    cell.threeLB.text = @"定制状态：已完成";
    cell.fourLB.text = @"详情";
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 订货单详情
    ComSecondVC *secondVC = [ComSecondVC new];
    secondVC.currentPage = -2;
    secondVC.currentTitle = @"订货单详情";
    [self.navigationController pushViewController:secondVC animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
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
