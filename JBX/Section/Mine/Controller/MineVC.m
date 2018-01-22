//
//  MineVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "MineVC.h"
#import "MineListCell.h"
#import "MineOfferVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *cardView;
@property (nonatomic,strong) UITableView *mineListTableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *partmentLabel;
@property (nonatomic,strong) UIImageView *portalPic;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UIImageView *recodPic;
@property (nonatomic,strong) UIImageView *goPic;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataSource];
    [self initConfigurationNavigation];
    [self initHeaderCardView];
    [self initMineListTableview];
}

// 配置导航头
- (void) initConfigurationNavigation {
    self.navigationItem.title = @"我的";
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"my_nav_invitation"] forState:(UIControlStateNormal)];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [rightBtn addTarget:self action:@selector(contactBtn) forControlEvents:(UIControlEventTouchUpInside)];
}
// 扫描二维码
- (void) contactBtn {
    
}

// 数据源
- (void) initDataSource {
    self.dataArr = @[
                     @{
                         @"itemTxt":@"我的订单",
                         @"itemPic":@"my_list_order"
                       },
                     @{
                         @"itemTxt":@"我的关注",
                         @"itemPic":@"my_list_follow"
                         },
                     @{
                         @"itemTxt":@"我的报价",
                         @"itemPic":@"my_list_invoice"
                         },
                     @{
                         @"itemTxt":@"我的询价",
                         @"itemPic":@"my_list_address"
                         },
                     @{
                         @"itemTxt":@"邀请",
                         @"itemPic":@"my_list_invitation"
                         },
                     @{
                         @"itemTxt":@"我的客服",
                         @"itemPic":@"my_list_ser"
                         },
                     @{
                         @"itemTxt":@"帮助与反馈",
                         @"itemPic":@"my_list_help"
                         },
                     @{
                         @"itemTxt":@"设置",
                         @"itemPic":@"my_list_set"
                         }
                     ];
}

// 顶部卡片效果
- (void) initHeaderCardView {
    self.headView = [UIView initWithUIViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) withBackground:RGBA(243, 243, 243, 1)];
    self.cardView = [[UIView alloc] initWithFrame:VIEWFRAME(10, 10, SCREEN_WIDTH - 20, 160)];
    _cardView.backgroundColor = [UIColor whiteColor];
    _cardView.layer.shadowColor = [UIColor grayColor].CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0, 2);
    _cardView.layer.shadowOpacity = 0.2;
    _cardView.layer.shadowRadius = 5;
    [_headView addSubview:self.cardView];
    // NAME , PARTMENT , PORTIAL, SHOPNAME , RECORGNISE
    self.nameLabel = [UILabel initUILabelWithFrame:CGRectZero
                                          withText:@"YOUKE"
                                     withTextColor:RGBA(34, 34, 34, 1)
                                          withFont:PINGFANG_FONT_SIZE_BOLD(18)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentLeft];
    [_cardView addSubview:_nameLabel];
    self.partmentLabel = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"销售部"
                                         withTextColor:RGBA(34, 34, 34, 1)
                                              withFont:PINGFANG_FONT_SIZE(15)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [_cardView addSubview:_partmentLabel];
    self.shopNameLabel = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"立即认证"
                                         withTextColor:RGBA(34, 34, 34, 1)
                                              withFont:PINGFANG_FONT_SIZE(15)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [_cardView addSubview:_shopNameLabel];
    self.portalPic = [[UIImageView alloc] initWithFrame:CGRectZero];
    _portalPic.backgroundColor = APP_COLOR_BASE_NAV;
    ViewRadius(_portalPic, 27.5);
    [_cardView addSubview:_portalPic];
    self.recodPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                               withImageName:@"my_main_Autt"];
    [_cardView addSubview:_recodPic];
    self.goPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                               withImageName:@"my_main_back"];
    [_cardView addSubview:_goPic];
    __weak __typeof(&*self.cardView)weakSelf = self.cardView;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(15);
        make.left.equalTo(weakSelf).offset(15);
        make.height.equalTo(@25);
    }];
    [_partmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf).offset(15);
        make.height.equalTo(@20);
    }];
    [_portalPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
        make.height.equalTo(@55);
        make.width.equalTo(@55);
    }];
    [_recodPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-15);
        make.left.equalTo(weakSelf).offset(15);
        make.width.equalTo(@66);
        make.height.equalTo(@20);
    }];
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_recodPic.mas_top).offset(-5);
        make.left.equalTo(weakSelf).offset(15);
        make.height.equalTo(@25);
    }];
    [_goPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLabel.mas_right).offset(5);
        make.centerY.equalTo(_shopNameLabel.mas_centerY).offset(0);
        make.height.equalTo(@12);
        make.width.equalTo(@8);
    }];
    
    
    
    
    
}
// 初始化tableview
- (void) initMineListTableview {
    self.mineListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _mineListTableView.delegate = self;
    _mineListTableView.dataSource = self;
    _mineListTableView.bounces = NO;
    _mineListTableView.tableHeaderView = _headView;
    if (@available(ios 11.0,*)) {
        _mineListTableView.contentInsetAdjustmentBehavior = NO;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [_mineListTableView registerClass:[MineListCell class] forCellReuseIdentifier:@"MineListCell"];
    [self.view addSubview:_mineListTableView];
    _weekSelf(weakSelf)
    [_mineListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
}

#pragma mark - UITableview 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
#pragma mark - UITableview 代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    MineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineListCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
//    DebugLog("打印的坐标%ld",indexPath.row);
    NSString *itemTxt = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"itemTxt"];
    NSString *itemPic = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"itemPic"];
    [cell setOtherIndexForCell:indexPath.row withItemPic:itemPic withItemTxt:itemTxt];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3 || indexPath.row == 7) {
        return 58;
    }
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2||indexPath.row == 3) {
        // 我的询价 我的报价
        MineOfferVC *mineOffAC = [MineOfferVC new];
        mineOffAC.currentID = indexPath.row;
        mineOffAC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineOffAC animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
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
