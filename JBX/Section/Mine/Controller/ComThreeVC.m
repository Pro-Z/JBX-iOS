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
#import "MineOfferListModel.h"

@interface ComThreeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) UILabel *titleLB,*orderServiceLB,*orderServiceContentLB,*timeRequireLb,*timeRequireContentLB,*pickTimeLB,*pickTimeContentLB,*otherLB,*otherContentLB,*lookOrderDetailLB;
@property (nonatomic,strong) UIButton *bottomBtn;

@property (nonatomic,strong) OfferDetailModel *offerDetailModel;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) OfferDetailItemMapModel *offerDetailItemMapModel;

@end

@implementation ComThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    DebugLog(@"当前的询价单号为%@",self.requireNumber);
    self.currentID = _currentID;
    self.dataSource = [NSMutableArray array];
    // 初始化数据
    [self initDataWithRequireOrderNum:self.requireNumber];
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
    self.headerView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    

    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.headerView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView).offset(0);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
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
        make.height.equalTo(@22);
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
        make.height.equalTo(@22);
    }];
    self.orderServiceContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@""
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    _orderServiceContentLB.numberOfLines = 0;
    _orderServiceContentLB.preferredMaxLayoutWidth = (SCREEN_WIDTH-52)/5*4;
    [_orderServiceContentLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.headerView addSubview:_orderServiceContentLB];
    
    [_orderServiceContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.orderServiceLB.mas_topMargin).offset(0);
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
        make.top.equalTo(weakSelf.orderServiceContentLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/5));
        make.height.equalTo(@22);
    }];
    self.timeRequireContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                      withText:@""
                                                 withTextColor:[UIColor blackColor]
                                                      withFont:PINGFANG_FONT_SIZE(14)
                                                   withGbColor:[UIColor whiteColor]
                                             withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_timeRequireContentLB];
    
    [_timeRequireContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderServiceContentLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.timeRequireLb.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        make.height.equalTo(@22);
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
        make.height.equalTo(@22);
    }];
    self.pickTimeContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                     withText:@""
                                                withTextColor:[UIColor blackColor]
                                                     withFont:PINGFANG_FONT_SIZE(14)
                                                  withGbColor:[UIColor whiteColor]
                                            withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_pickTimeContentLB];
    
    [_pickTimeContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeRequireLb.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.pickTimeLB.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        make.height.equalTo(@22);
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
        make.height.equalTo(@22);
    }];
    self.otherContentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@""
                                             withTextColor:[UIColor blackColor]
                                                  withFont:PINGFANG_FONT_SIZE(14)
                                               withGbColor:[UIColor whiteColor]
                                         withTextAlignment:NSTextAlignmentLeft];
    _otherContentLB.numberOfLines = 0;
    _otherContentLB.preferredMaxLayoutWidth = (SCREEN_WIDTH-52)/5*4;
    [_otherContentLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.headerView addSubview:_otherContentLB];
    
    [_otherContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pickTimeContentLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.otherLB.mas_right).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
//    [_otherContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10.0);
//        make.right.mas_equalTo(-10.0);
//        make.top.mas_equalTo(currentView.mas_bottom).offset(10.0);
//
//        // 自适应label多行显示时，无需设置label高度
//        // make.height.mas_equalTo(40.0);
//    }];
    
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
        if (weakSelf.currentID == 1) {
            make.bottom.equalTo(weakSelf.view).offset(-44);
        }else{
            make.bottom.equalTo(weakSelf.view).offset(0);
        }
        
    }];
    if (_currentID == 1) {
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
}

- (void) orderPriceNow {
    // 跳转到报价页面
    ComSecondVC *secondVC = [ComSecondVC new];
    secondVC.currentPage = -1;
    secondVC.currentTitle = @"订单报价";
    secondVC.enquireID = self.requireNumber;
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"LookOrderCell";
    LookOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    self.offerDetailItemMapModel = [MTLJSONAdapter modelOfClass:[OfferDetailItemMapModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
    cell.firstLB.text = [NSString stringWithFormat:@"订货单号：%@",_offerDetailItemMapModel.item_id];
    cell.secondLB.text = [NSString stringWithFormat:@"部件个数：%ld",_offerDetailItemMapModel.count];
    cell.threeLB.text = [NSString stringWithFormat:@"定制状态：%@",_offerDetailItemMapModel.respStatus];
    cell.fourLB.text = @"详情";
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 订货单详情
    self.offerDetailItemMapModel = [MTLJSONAdapter modelOfClass:[OfferDetailItemMapModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
    ComSecondVC *secondVC = [ComSecondVC new];
    secondVC.currentPage = -2;
    secondVC.currentTitle = @"订货单详情";
    secondVC.enquireID = _offerDetailItemMapModel.item_id;
    [self.navigationController pushViewController:secondVC animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_detailTableView fd_heightForCellWithIdentifier:@"LookOrderCell" cacheByIndexPath:indexPath configuration:^(LookOrderCell *cell) {
        self.offerDetailItemMapModel = [MTLJSONAdapter modelOfClass:[OfferDetailItemMapModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
        cell.firstLB.text = [NSString stringWithFormat:@"订货单号：%@",_offerDetailItemMapModel.item_id];
        cell.secondLB.text = [NSString stringWithFormat:@"部件个数：%ld",_offerDetailItemMapModel.count];
        cell.threeLB.text = [NSString stringWithFormat:@"定制状态：%@",_offerDetailItemMapModel.respStatus];
        cell.fourLB.text = @"详情";
    }];
}


/**
 初始化询价详情的数据

 @param number 询价单号
 */
- (void) initDataWithRequireOrderNum:(NSString*)number {
    NSString *ids = @"";
    if (_currentID == 1) {
        ids = @"1";
    }else if(_currentID == 3){
        ids = @"0";
    }
    NSDictionary *dict = @{
                           @"enquiry_id":number,
                           @"sort":ids
                           };
    _weekSelf(weakSelf);
    [[NetAPIManager sharedManager] request_common_WithPath:APP_REQUIRE_DETAIL_LIST_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        
        if (_currentID == 3 || _currentID == 1) {
            self.offerDetailModel = [MTLJSONAdapter modelOfClass:[OfferDetailModel class] fromJSONDictionary:data error:nil];
            if (_offerDetailModel.code == 200) {
                [NSObject showHudTipStr:@"返回成功"];
                // 开始赋值
                _orderServiceContentLB.text = _offerDetailModel.data.enquiryMap.demands;
                _timeRequireContentLB.text = [NSString stringWithFormat:@"%ld天",_offerDetailModel.data.enquiryMap.day_limit];
                _pickTimeContentLB.text = [NSString stringWithFormat:@"%ld",_offerDetailModel.data.enquiryMap.pickup_day];
                _otherContentLB.text = _offerDetailModel.data.enquiryMap.remark;
                
                CGFloat height = [weakSelf.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                CGRect frame = weakSelf.headerView.bounds;
                frame.size.height = height;
                weakSelf.headerView.frame = frame;
                [weakSelf.detailTableView setTableHeaderView:weakSelf.headerView];
                
                // tableView
                _dataSource = [NSMutableArray arrayWithArray:_offerDetailModel.data.itemmap];
                [weakSelf.detailTableView reloadData];
            }else{
                [NSObject showHudTipStr:_offerDetailModel.msg];
            }
        }
        
        
        
    } failue:^(id data, NSError *error) {
        
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
