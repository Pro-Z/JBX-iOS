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
#import "MineOfferListModel.h"
#import "OrderDetalModel.h"

@interface ComSecondVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic,strong) UITableView *busTableView;
@property (nonatomic,strong) UIButton *bottomBtn;
// 订单报价
@property (nonatomic,strong) UILabel *orderPriceLB;
@property (nonatomic,strong) XTextField *firstTF,*secondTF,*threeTF;
@property (nonatomic,strong) UIButton *confirmBtn;

// 订货单详情
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *partmentTableView;
@property (nonatomic,strong) UILabel *firstTitleLB,*secondTitleLB,*threeTitleLB,*fourTitleLB;
@property (nonatomic,strong) UILabel *projectNameLB,*materialKindLB,*materialNumberLB,*partmentSquoreLB,*materialSumLB,*partNumberLB,*materialLB,*heightLB,*materialColorLB,*materialGGLB,*cutNumberLB,*renderCutLB,*riverLB;

@property (nonatomic,strong) OrderDetailListModel *orderDetailListModel;

@property (nonatomic,strong) OrderDetalModel *orderDetalModel;
@property (nonatomic,strong) NSMutableArray *orderDetailDataSource;
@property (nonatomic,strong) OrderDetalArgsMapModel *orderDetalArgsMapModel;
@property (nonatomic,strong) OrderDetalTempGraphicalSepcListModel *orderDetalTempGraphicalSepcListModel;

// 商家列表
@property (nonatomic,strong) BusListModel *busListModel;
@property (nonatomic,strong) BusListDataModel *busListDataModel;
@property (nonatomic,strong) NSMutableArray *busDataSource;
@end

@implementation ComSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    [self initNavigationView];
    if (self.currentPage == 4) {
        self.busDataSource = [NSMutableArray array];
        [self initBusDataWithEnquireID:self.enquireID];
        [self initTableView];
    }else if(self.currentPage == -1){
        // 订单报价
        [self initOrderPriceView];
    }else if (self.currentPage == -2){
        // 订货单详情
        self.orderDetailDataSource = [NSMutableArray array];
        self.enquireID = _enquireID;
        WHITE_BG
        [self initOrderDetailData];
        [self initHeaderView];
        [self initOrderDetailTableView];
        
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
    
    if (self.currentPage == 5) {
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_job_user"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
        rightBtn.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightBtn;
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    
    
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 初始化商家列表
 */
- (void) initBusDataWithEnquireID:(NSString *) enquireid {
    _weekSelf(weakSelf);
    NSDictionary *dict = @{
                           @"match_enqu_id":enquireid
                           };
    [[NetAPIManager sharedManager] request_common_WithPath:APP_BUS_LIST_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        self.busListModel = [BusListModel mj_objectWithKeyValues:data];
        if (_busListModel.code == 200) {
            NSMutableArray *arr = [BusListDataModel mj_objectArrayWithKeyValuesArray:_busListModel.data];
            _busDataSource = [NSMutableArray arrayWithArray:arr];
            [weakSelf.busTableView reloadData];
        }else{
            [NSObject showHudTipStr:@"请求出错!"];
        }
        
    } failue:^(id data, NSError *error) {
        
    }];
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
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
    
//    // 底部绿色
//    self.bottomBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
//                                                           withFrame:CGRectZero
//                                                           withTitle:@"查看询价单详情"
//                                                      withTitleColor:[UIColor whiteColor]
//                                                              withGB:RGBA(50, 198, 7, 1)
//                                                            withFont:PINGFANG_FONT_SIZE(16)];
//
//    [self.view addSubview:_bottomBtn];
//
//    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf.view).offset(0);
//        make.left.equalTo(weakSelf.view).offset(0);
//        make.right.equalTo(weakSelf.view).offset(0);
//        make.height.equalTo(@44);
//    }];
    
}
#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_partmentTableView) {
        return _orderDetailDataSource.count;
    }else if(_busTableView){
        return _busDataSource.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    if (_busTableView) {
        static NSString *rid=@"BussListCell";
        BussListCell *cell=[tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        _busListDataModel = _busDataSource[indexPath.row];
        cell.firstLB.text = [NSString stringWithFormat:@"%@",_busListDataModel.org_name];
        cell.secondLB.text = [NSString stringWithFormat:@"报价时间：%@",_busListDataModel.create_ts];
        cell.threeLB.text = @"总金额(元): ";
        cell.fourLB.text = [NSString stringWithFormat:@"%@",_busListDataModel.price];
        cell.fiveLB.text = [NSString stringWithFormat:@"备注: %@",_busListDataModel.remark];
        
        return cell;
    }else if(_partmentTableView){
        
        static NSString *rid=@"OrderDetailListCell";
        OrderDetailListCell *cell=[tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        _orderDetalTempGraphicalSepcListModel = _orderDetailDataSource[indexPath.row];
        NSString *te = _orderDetalTempGraphicalSepcListModel.filepathList[0];
        NSString *teX = [APP_IMAGE_URL stringByAppendingFormat:@"%@",te];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",teX]];
        [cell.firstPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placerholder"]];
        cell.materialLB.text = [NSString stringWithFormat:@"材质：%@",_orderDetalTempGraphicalSepcListModel.typeChina];
        cell.heightLB.text = [NSString stringWithFormat:@"厚度：%@",_orderDetalTempGraphicalSepcListModel.thickness_num];
        cell.itchLB.text = [NSString stringWithFormat:@"内外尺：%@",_orderDetalTempGraphicalSepcListModel.issizeChina];
        cell.towardLB.text = [NSString stringWithFormat:@"朝向：%@",_orderDetalTempGraphicalSepcListModel.orientationChina];
        cell.colorLB.text = [NSString stringWithFormat:@"颜色：%@",_orderDetalTempGraphicalSepcListModel.colorChina];
        cell.profileLB.text = [NSString stringWithFormat:@"是否拉丝：%@",_orderDetalTempGraphicalSepcListModel.is_linesChina];
        cell.technologyLB.text = [NSString stringWithFormat:@"工艺：%@",_orderDetalTempGraphicalSepcListModel.craftsChina];
        NSString *gg = @"";
        for (int i = 0; i<_orderDetalTempGraphicalSepcListModel.widthAndHeightList.count; i++) {
            NSString *tem = [NSString stringWithFormat:@"%@     %@\n",_orderDetalTempGraphicalSepcListModel.widthAndHeightList[i],_orderDetalTempGraphicalSepcListModel.grapNameList[i]];
            gg = [gg stringByAppendingFormat:@"%@",tem];
        }
        cell.xlwidthLB.text = [NSString stringWithFormat:@"规格：\n%@",gg];
        
        return cell;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_busTableView) {
//        ComThreeVC *threeVC = [ComThreeVC new];
//        [self.navigationController pushViewController:threeVC animated:YES];
//    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_busTableView) {
        return [tableView fd_heightForCellWithIdentifier:@"BussListCell" cacheByIndexPath:indexPath configuration:^(BussListCell *cell) {
            _busListDataModel = _busDataSource[indexPath.row];
            cell.firstLB.text = [NSString stringWithFormat:@"%@",_busListDataModel.org_name];
            cell.secondLB.text = [NSString stringWithFormat:@"报价时间：%@",_busListDataModel.create_ts];
            cell.threeLB.text = @"总金额(元): ";
            cell.fourLB.text = [NSString stringWithFormat:@"%@",_busListDataModel.price];
            cell.fiveLB.text = [NSString stringWithFormat:@"备注: %@",_busListDataModel.remark];
        }];
    }else if (_partmentTableView){
        return [tableView fd_heightForCellWithIdentifier:@"OrderDetailListCell" cacheByIndexPath:indexPath configuration:^(OrderDetailListCell *cell) {
            _orderDetalTempGraphicalSepcListModel = _orderDetailDataSource[indexPath.row];
            NSString *te = _orderDetalTempGraphicalSepcListModel.filepathList[0];
            NSString *teX = [APP_IMAGE_URL stringByAppendingFormat:@"%@",te];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",teX]];
            [cell.firstPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placerholder"]];
            cell.materialLB.text = [NSString stringWithFormat:@"材质：%@",_orderDetalTempGraphicalSepcListModel.typeChina];
            cell.heightLB.text = [NSString stringWithFormat:@"厚度：%@",_orderDetalTempGraphicalSepcListModel.thickness_num];
            cell.itchLB.text = [NSString stringWithFormat:@"内外尺：%@",_orderDetalTempGraphicalSepcListModel.issizeChina];
            cell.towardLB.text = [NSString stringWithFormat:@"朝向：%@",_orderDetalTempGraphicalSepcListModel.orientationChina];
            cell.colorLB.text = [NSString stringWithFormat:@"颜色：%@",_orderDetalTempGraphicalSepcListModel.colorChina];
            cell.profileLB.text = [NSString stringWithFormat:@"是否拉丝：%@",_orderDetalTempGraphicalSepcListModel.is_linesChina];
            cell.technologyLB.text = [NSString stringWithFormat:@"工艺：%@",_orderDetalTempGraphicalSepcListModel.craftsChina];
            NSString *gg = @"";
            for (int i = 0; i<_orderDetalTempGraphicalSepcListModel.widthAndHeightList.count; i++) {
                NSString *tem = [NSString stringWithFormat:@"%@     %@\n",_orderDetalTempGraphicalSepcListModel.widthAndHeightList[i],_orderDetalTempGraphicalSepcListModel.grapNameList[i]];
                gg = [gg stringByAppendingFormat:@"%@",tem];
            }
            cell.xlwidthLB.text = [NSString stringWithFormat:@"规格：\n%@",gg];
            
            
        }];
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
    _firstTF.placehoder = @"2000";
    _firstTF.font = PINGFANG_FONT_SIZE(30);
    _firstTF.textColor = [UIColor blackColor];
    _firstTF.textAlignment = NSTextAlignmentCenter;
    _firstTF.placehoderColor = RGBA(102, 102, 102, 1);
    _firstTF.keyboardType = UIKeyboardTypeDecimalPad;
    _firstTF.selectedRange=NSMakeRange(0,0) ;
    _firstTF.delegate = self;
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
    _secondTF.placehoder = @"预计工期";
    _secondTF.font = PINGFANG_FONT_SIZE(14);
    _secondTF.textColor = [UIColor blackColor];
    _secondTF.textAlignment = NSTextAlignmentLeft;
    _secondTF.placehoderColor = RGBA(102, 102, 102, 1);
    [self.view addSubview:_secondTF];
    
    [_secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@42);
    }];
    
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.view addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.secondTF.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@1);
    }];
    
    self.threeTF = [[XTextField alloc] initWithFrame:CGRectZero];
    _threeTF.placehoder = @"添加备注";
    _threeTF.font = PINGFANG_FONT_SIZE(14);
    _threeTF.textColor = [UIColor blackColor];
    _threeTF.textAlignment = NSTextAlignmentLeft;
    _threeTF.placehoderColor = RGBA(102, 102, 102, 1);
    [self.view addSubview:_threeTF];
    
    [_threeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(15);
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
    [_confirmBtn addTarget:self action:@selector(handleOrderPrice) forControlEvents:(UIControlEventTouchUpInside)];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.threeTF.mas_bottom).offset(30);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@44);
    }];
    ViewRadius(_confirmBtn, 6);
    
    
    
}


/**
 * 订单报价接口
 */
- (void) handleOrderPrice {
    NSString *price = _firstTF.text;
    if (!price || price.length <= 0) {
        [NSObject showHudTipStr:@"你还没有报价!"];
        return;
    }
    NSString *limit_day = _secondTF.text;
    if (!limit_day || limit_day.length <= 0) {
        [NSObject showHudTipStr:@"请输入预计工期!"];
        return;
    }
    NSString *remark = _threeTF.text;
    if (!remark || remark.length <= 0) {
        [NSObject showHudTipStr:@"请输入备注!"];
        return;
    }

    NSDictionary *dict = @{
                           @"enquiry_id":self.enquireID,
                           @"price":price,
                           @"response_remark":remark,
                           @"response_day_limit":limit_day,
                           @"save_type":@"1"
                           };
    [[NetAPIManager sharedManager] request_common_WithPath:APP_OFFER_SPEAK_PRICE_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        BaseModel *baseModel = [MTLJSONAdapter modelOfClass:[BaseModel class] fromJSONDictionary:data error:nil];
        if (baseModel.code == 200) {
            [NSObject showHudTipStr:@"添加成功!"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [NSObject showHudTipStr:@"添加失败!"];
        }
    } failue:^(id data, NSError *error) {
        
    }];
    
    
}




/**
 * 订货单详情
 */
- (void) initOrderDetailData {
    NSDictionary *dict = @{
                           @"item_id":_enquireID
                           };
    [[NetAPIManager sharedManager] request_common_WithPath:APP_ORDER_DETAIL_LIST_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        self.orderDetalModel = [OrderDetalModel mj_objectWithKeyValues:data];
        if (_orderDetalModel.code == 200) {
            [NSObject showHudTipStr:@"请求成功!"];
            DebugLog(@"解析的数据为%@",_orderDetalModel.data.argsMap.name);
            self.orderDetalArgsMapModel = [OrderDetalArgsMapModel mj_objectWithKeyValues:_orderDetalModel.data.argsMap];
            [self setValueForHeader];
            
            NSMutableArray *tempArr = [OrderDetalTempGraphicalSepcListModel mj_objectArrayWithKeyValuesArray:_orderDetalModel.data.tempGraphicalSepcList];
            _orderDetailDataSource = [NSMutableArray arrayWithArray:tempArr];
            [_partmentTableView reloadData];
            
        }else{

        }
    } failue:^(id data, NSError *error) {
        
    }];
    
    
}


/**
 * 初始化头部数据
 */
- (void) setValueForHeader {
    _projectNameLB.text = [NSString stringWithFormat:@"项目名称：%@",_orderDetalArgsMapModel.name];
    _materialKindLB.text = [NSString stringWithFormat:@"材质种类：%@",_orderDetalArgsMapModel.materialType];
    _materialNumberLB.text = [NSString stringWithFormat:@"板材总数量(张)：%@",_orderDetalArgsMapModel.materialNum];
    _partmentSquoreLB.text = [NSString stringWithFormat:@"部件总面积(㎡)：%@",_orderDetalArgsMapModel.totalGraphicalArea];
    _materialSumLB.text = [NSString stringWithFormat:@"板材总面积(㎡)：%@",_orderDetalArgsMapModel.consumMaterialArea];
    _partNumberLB.text = [NSString stringWithFormat:@"部件数量(个)：%@",_orderDetalArgsMapModel.graphical_num];
    NSString *typeList = @"";
    for (int i = 0; i<_orderDetalArgsMapModel.byTypeList_2.count; i++) {
        typeList = [typeList stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"\n %d、%@",(i+1),_orderDetalArgsMapModel.byTypeList_2[i]]] ;
    }
    _materialLB.text = [NSString stringWithFormat:@"%@",typeList];
    _cutNumberLB.text = [NSString stringWithFormat:@"下料刀数(刀)：%@",_orderDetalArgsMapModel.countcuttingnum];
    _renderCutLB.text = [NSString stringWithFormat:@"折弯(刀)：%@",_orderDetalArgsMapModel.countbendnum];
    _riverLB.text = [NSString stringWithFormat:@"刨槽(m)：%@",_orderDetalArgsMapModel.countgroovingnum];
    
    _weekSelf(weakSelf);
    // 动态设置header高度
    CGFloat height = [weakSelf.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = weakSelf.headerView.bounds;
    frame.size.height = height;
    weakSelf.headerView.frame = frame;
    [weakSelf.partmentTableView setTableHeaderView:weakSelf.headerView];
}



- (void) initOrderDetailView {
    
    
}
- (void) initHeaderView {
    self.headerView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
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
    _materialLB.numberOfLines = 0;
    [self.headerView addSubview:_materialLB];
    
    [_materialLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(26);
        make.right.equalTo(weakSelf.headerView).offset(-26);
        
    }];
//    self.heightLB = [UILabel initUILabelWithFrame:CGRectZero
//                                         withText:@"厚度: 0.3"
//                                      withTextColor:[UIColor blackColor]
//                                           withFont:PINGFANG_FONT_SIZE(14)
//                                        withGbColor:[UIColor whiteColor]
//                                  withTextAlignment:NSTextAlignmentLeft];
//    [self.headerView addSubview:_heightLB];
//
//    [_heightLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineView2.mas_bottom).offset(10);
//        make.right.equalTo(weakSelf.headerView).offset(-26);
//        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
//    }];
//    self.materialColorLB = [UILabel initUILabelWithFrame:CGRectZero
//                                           withText:@"板材颜色：宝石蓝"
//                                      withTextColor:[UIColor blackColor]
//                                           withFont:PINGFANG_FONT_SIZE(14)
//                                        withGbColor:[UIColor whiteColor]
//                                  withTextAlignment:NSTextAlignmentLeft];
//    [self.headerView addSubview:_materialColorLB];
//
//    [_materialColorLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.materialLB.mas_bottom).offset(10);
//        make.left.equalTo(weakSelf.headerView).offset(26);
//        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
//    }];
//    self.materialGGLB = [UILabel initUILabelWithFrame:CGRectZero
//                                         withText:@"材料规格：1000*2000*5"
//                                    withTextColor:[UIColor blackColor]
//                                         withFont:PINGFANG_FONT_SIZE(14)
//                                      withGbColor:[UIColor whiteColor]
//                                withTextAlignment:NSTextAlignmentLeft];
//    [self.headerView addSubview:_materialGGLB];
//
//    [_materialGGLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.heightLB.mas_bottom).offset(10);
//        make.right.equalTo(weakSelf.headerView).offset(-26);
//        make.width.equalTo(@((SCREEN_WIDTH-52)/2));
//    }];
    
    self.threeTitleLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"加工统计"
                                         withTextColor:RGBA(0, 118, 255, 1)
                                              withFont:PINGFANG_FONT_SIZE(16)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [self.headerView addSubview:_threeTitleLB];
    
    [_threeTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialLB.mas_bottom).offset(20);
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
        make.bottom.equalTo(weakSelf.headerView.mas_bottom).offset(-10);
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
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
