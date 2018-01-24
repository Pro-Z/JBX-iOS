//
//  ComSecondVC.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "ComSecondVC.h"
#import "BussListCell.h"
#import "ComThreeVC.h"
#import "XTextField.h"
#import "OrderDetailListCell.h"

@interface ComSecondVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *busTableView;
@property (nonatomic,strong) UIButton *bottomBtn;
// 订单报价
@property (nonatomic,strong) UILabel *orderPriceLB;
@property (nonatomic,strong) XTextField *firstTF,*secondTF;
@property (nonatomic,strong) UIButton *confirmBtn;

// 订货单详情
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *partmentTableView;
@property (nonatomic,strong) UILabel *firstTitleLB,*secondTitleLB,*threeTitleLB,*fourTitleLB;
@property (nonatomic,strong) UILabel *projectNameLB,*materialKindLB,*materialNumberLB,*partmentSquoreLB,*materialSumLB,*partNumberLB,*materialLB,*heightLB,*materialColorLB,*materialGGLB,*cutNumberLB,*renderCutLB,*riverLB;


@end

@implementation ComSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    [self initNavigationView];
    if (self.currentPage == 4) {
        [self initTableView];
    }else if(self.currentPage == -1){
        // 订单报价
        [self initOrderPriceView];
    }else if (self.currentPage == -2){
        // 订货单详情
        [self initOrderDetailView];
    }
    
    
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = self.currentTitle;
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
    
    if (self.currentPage == 4) {
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_job_user"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
        rightBtn.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightBtn;
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    
    
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) initTableView {
    
    self.busTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _busTableView.delegate =self;
    _busTableView.dataSource = self;
    [_busTableView registerClass:[BussListCell class] forCellReuseIdentifier:@"BussListCell"];
    [self.view addSubview:_busTableView];
    _weekSelf(weakSelf)
    [_busTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(-44);
    }];
    
    // 底部绿色
    self.bottomBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                           withFrame:CGRectZero
                                                           withTitle:@"查看询价单详情"
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
    if (_busTableView) {
        static NSString *rid=@"BussListCell";
        BussListCell *cell=[tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.firstLB.text = @"天津鑫利恒发有限公司";
        cell.secondLB.text = @"报价时间：2017-12-20";
        cell.threeLB.text = @"总金额(元): ";
        cell.fourLB.text = @"3000";
        cell.fiveLB.text = @"备注:  测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注";
        
        return cell;
    }else if(_partmentTableView){
        
        static NSString *rid=@"OrderDetailListCell";
        OrderDetailListCell *cell=[tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        
        cell.materialLB.text = @"材质：201";
        cell.numberLB.text = @"个数(个)：2";
        cell.heightLB.text = @"厚度：0.3";
        cell.flowerRoadLB.text = @"纹路：无";
        cell.itchLB.text = @"内尺：外尺";
        cell.towardLB.text = @"面朝向：朝内";
        cell.colorLB.text = @"颜色：宝石蓝拉丝";
        cell.profileLB.text = @"剖面：198";
        cell.technologyLB.text = @"工艺：";
        cell.xlwidthLB.text = @"下料宽度：193";
        cell.partNameLB.text = @"部件名称";
        cell.partHeightLB.text = @"长度";
        cell.partNumLB.text = @"数量";
        cell.partNameContentLB.text = @"7#2#";
        cell.partHeightContentLB.text = @"10";
        cell.partNumContentLB.text = @"12";
        
        return cell;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_busTableView]) {
        ComThreeVC *threeVC = [ComThreeVC new];
        [self.navigationController pushViewController:threeVC animated:YES];
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_busTableView) {
        return [tableView fd_heightForCellWithIdentifier:@"BussListCell" cacheByIndexPath:indexPath configuration:^(BussListCell *cell) {
            cell.firstLB.text = @"天津鑫利恒发有限公司";
            cell.secondLB.text = @"报价时间：2017-12-20";
            cell.threeLB.text = @"总金额(元): ";
            cell.fourLB.text = @"3000";
            cell.fiveLB.text = @"备注:  测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注测试备注";
        }];
    }else if (_partmentTableView){
        return 190;
    }
    return 0;
}



- (void) operateBtn {
    // TO DO SOMETHING
    
}


/**
 * 订单报价界面
 */
- (void) initOrderPriceView {
    WHITE_BG
    self.orderPriceLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"报价金额: "
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_orderPriceLB];
    _weekSelf(weakSelf)
    [_orderPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(15);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
    }];
    UILabel *rmbLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"¥"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(24)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:rmbLB];
    
    [rmbLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderPriceLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view).offset(16);
        make.width.equalTo(@15);
        make.height.equalTo(@33);
    }];
    self.firstTF = [[XTextField alloc] initWithFrame:CGRectZero];
    _firstTF.placehoder = @"请输入订单报价";
    _firstTF.font = PINGFANG_FONT_SIZE(30);
    _firstTF.textColor = [UIColor blackColor];
    _firstTF.textAlignment = NSTextAlignmentCenter;
    _firstTF.placehoderColor = RGBA(102, 102, 102, 1);
    [self.view addSubview:_firstTF];
    
    [_firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderPriceLB.mas_bottom).offset(13);
        make.left.equalTo(rmbLB.mas_right).offset(5);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@42);
    }];
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstTF.mas_bottom).offset(4);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@1);
    }];
    self.secondTF = [[XTextField alloc] initWithFrame:CGRectZero];
    _secondTF.placehoder = @"添加备注";
    _secondTF.font = PINGFANG_FONT_SIZE(14);
    _secondTF.textColor = [UIColor blackColor];
    _secondTF.textAlignment = NSTextAlignmentCenter;
    _secondTF.placehoderColor = RGBA(102, 102, 102, 1);
    [self.view addSubview:_secondTF];
    
    [_secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@42);
    }];
    
    self.confirmBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                           withFrame:CGRectZero
                                                           withTitle:@"确认报价"
                                                      withTitleColor:[UIColor whiteColor]
                                                              withGB:RGBA(0, 118, 255, 1)
                                                            withFont:PINGFANG_FONT_SIZE(16)];
    
    [self.view addSubview:_confirmBtn];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondTF.mas_bottom).offset(30);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@44);
    }];
    ViewRadius(_confirmBtn, 6);
    
    
    
}



/**
 * 订货单详情
 */
- (void) initOrderDetailView {
    WHITE_BG
    [self initHeaderView];
    [self initOrderDetailTableView];
    
}
- (void) initHeaderView {
    self.headerView = [UIView initWithUIViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 480) withBackground:[UIColor whiteColor]];
    [self.view addSubview:_headerView];
    self.firstTitleLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"概要信息"
                                                  withTextColor:RGBA(0, 118, 255, 1)
                                                       withFont:PINGFANG_FONT_SIZE(16)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_firstTitleLB];
    _weekSelf(weakSelf)
    [_firstTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView).offset(15);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(0);
    }];
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(0, 118, 255, 1)];
    [self.headerView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.firstTitleLB.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.headerView).offset(16);
        make.right.equalTo(weakSelf.headerView).offset(-16);
        make.height.equalTo(@1);
    }];
    
    self.projectNameLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"姓名名称: 201231231241-02"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_projectNameLB];
    
    [_projectNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    
    self.materialKindLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"材质种类：1类(201)"
                                         withTextColor:[UIColor blackColor]
                                              withFont:PINGFANG_FONT_SIZE(14)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_materialKindLB];
    
    [_materialKindLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.projectNameLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    
    self.materialNumberLB = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"板材总数量(张)：5"
                                          withTextColor:[UIColor blackColor]
                                               withFont:PINGFANG_FONT_SIZE(14)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_materialNumberLB];
    
    [_materialNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialKindLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    
    self.partmentSquoreLB = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@"部件总面积(㎡)：0.01"
                                            withTextColor:[UIColor blackColor]
                                                 withFont:PINGFANG_FONT_SIZE(14)
                                              withGbColor:[UIColor whiteColor]
                                        withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_partmentSquoreLB];
    
    [_partmentSquoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialNumberLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    self.materialSumLB = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@"板材总面积(㎡)：10.00"
                                            withTextColor:[UIColor blackColor]
                                                 withFont:PINGFANG_FONT_SIZE(14)
                                              withGbColor:[UIColor whiteColor]
                                        withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_materialSumLB];
    
    [_materialSumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.partmentSquoreLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    self.partNumberLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"部件数量(个)：3"
                                         withTextColor:[UIColor blackColor]
                                              withFont:PINGFANG_FONT_SIZE(14)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_partNumberLB];
    
    [_partNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialSumLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
    }];
    
    self.secondTitleLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"用料统计"
                                        withTextColor:RGBA(0, 118, 255, 1)
                                             withFont:PINGFANG_FONT_SIZE(16)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_secondTitleLB];
    
    [_secondTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.partNumberLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(0);
    }];
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(0, 118, 255, 1)];
    [self.headerView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondTitleLB.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.headerView).offset(16);
        make.right.equalTo(weakSelf.headerView).offset(-16);
        make.height.equalTo(@1);
    }];
    
    self.materialLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"材质: 201"
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_materialLB];
    
    [_materialLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    self.heightLB = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"厚度: 0.3"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_heightLB];
    
    [_heightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    self.materialColorLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"板材颜色：宝石蓝"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_materialColorLB];
    
    [_materialColorLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    self.materialGGLB = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"材料规格：1000*2000*5"
                                    withTextColor:[UIColor blackColor]
                                         withFont:PINGFANG_FONT_SIZE(14)
                                      withGbColor:[UIColor whiteColor]
                                withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_materialGGLB];
    
    [_materialGGLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.heightLB.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    
    self.threeTitleLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"加工统计"
                                         withTextColor:RGBA(0, 118, 255, 1)
                                              withFont:PINGFANG_FONT_SIZE(16)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_threeTitleLB];
    
    [_threeTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialGGLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(0);
    }];
    UIView *lineView3 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(0, 118, 255, 1)];
    [self.headerView addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.threeTitleLB.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.headerView).offset(16);
        make.right.equalTo(weakSelf.headerView).offset(-16);
        make.height.equalTo(@1);
    }];
    
    self.cutNumberLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"下料刀数(刀)：3"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_cutNumberLB];
    
    [_cutNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    self.renderCutLB = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"折弯(刀)：15"
                                    withTextColor:[UIColor blackColor]
                                         withFont:PINGFANG_FONT_SIZE(14)
                                      withGbColor:[UIColor whiteColor]
                                withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_renderCutLB];
    
    [_renderCutLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    self.riverLB = [UILabel initUILabelWithFrame:CGRectZero
                                                withText:@"刨槽(m)：0.00"
                                           withTextColor:[UIColor blackColor]
                                                withFont:PINGFANG_FONT_SIZE(14)
                                             withGbColor:[UIColor whiteColor]
                                       withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_riverLB];
    
    [_riverLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cutNumberLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
    }];
    
    self.fourTitleLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"加工部件详情"
                                        withTextColor:RGBA(0, 118, 255, 1)
                                             withFont:PINGFANG_FONT_SIZE(16)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_fourTitleLB];
    
    [_fourTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.riverLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(0);
    }];
    UIView *lineView4 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(0, 118, 255, 1)];
    [self.headerView addSubview:lineView4];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fourTitleLB.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.headerView).offset(16);
        make.right.equalTo(weakSelf.headerView).offset(-16);
        make.height.equalTo(@1);
    }];
    
    
    
}

- (void) initOrderDetailTableView {
    
    self.partmentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _partmentTableView.delegate =self;
    _partmentTableView.dataSource = self;
    _partmentTableView.tableHeaderView = _headerView;
    [_partmentTableView registerClass:[OrderDetailListCell class] forCellReuseIdentifier:@"OrderDetailListCell"];
    [self.view addSubview:_partmentTableView];
    _weekSelf(weakSelf)
    [_partmentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
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
