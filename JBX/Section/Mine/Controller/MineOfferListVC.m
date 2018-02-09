//
//  MineOfferListVC.m
//  JBX
//
//  Created by 证 on 2018/1/16.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MineOfferListVC.h"
#import "OfferListCell.h"
#import "OfferListAutoSizeCell.h"
#import "ComThreeVC.h"
#import "MineOfferListModel.h"
#import "ComSecondVC.h"

@interface MineOfferListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *offerTableView;
@property (nonatomic,assign) NSInteger types;
@property (nonatomic,assign) NSInteger pages;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MineOfferListModel *mineOfferListModel;
@property (nonatomic,strong) MineOfferEnquirylistModel *mineOfferEnquirylistModel;
@property (nonatomic,strong) MineOfferWaitListModel *mineOfferWaitListModel;
@property (nonatomic,strong) MineOfferWaitisEnquirylistListModel *mineOfferWaitisEnquirylistListModel;
@property (nonatomic,strong) MineOfferAleadListModel *mineOfferAleadListModel;
@property (nonatomic,strong) MineOfferAleadIsEnquirylistModel *mineOfferAleadIsEnquirylistModel;
@property (nonatomic,strong) MineRequireAleadListModel *mineRequireAleadListModel;
@property (nonatomic,strong) MineRequireAleadEnquiryListModel *mineRequireAleadEnquiryListModel;
@end

@implementation MineOfferListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pages = 1;
    self.dataSource = [NSMutableArray array];
    // 判断是哪个模块传递的cell
    if (self.pageID == 2 && [self.titleStr isEqualToString:@"待报价"]) {
        self.types = 1;
    }else if(self.pageID == 2 && [self.titleStr isEqualToString:@"已报价"]){
        self.types = 2;
    }else if(self.pageID == 3 && [self.titleStr isEqualToString:@"待报价"]){
        self.types = 3;
    }else if(self.pageID == 3 && [self.titleStr isEqualToString:@"已报价"]){
        self.types = 4;
    }
    DebugLog(@"当前的类型为%ld",_types);
    [self initDataWithType:_types withPage:1 withPageNum:10];
    [self initTableView];
    
   
}


/**
 初始化数据源
 @param offerType 报价类型
 @param page 页数
 @param pageNum 条数
 */
- (void) initDataWithType:(NSInteger)offerType withPage:(NSInteger)page withPageNum:(NSInteger)pageNum {
    if (page == 1) {
        [_dataSource removeAllObjects];
    }
    NSString *paramer = @"";
    NSString *paramerValue = @"";
    if (offerType == 1) {
        paramer = @"is_to_enquiry";
        paramerValue = @"0";
    }else if (offerType == 2){
        paramer = @"is_to_enquiry";
        paramerValue = @"1";
    }else if (offerType == 3) {
        paramer = @"is_enquiry";
        paramerValue = @"0";
    }else if (offerType == 4){
        paramer = @"is_enquiry";
        paramerValue = @"1";
    }
    NSDictionary *dict =@{
                          paramer:paramerValue,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"pageNum":[NSString stringWithFormat:@"%ld",pageNum]
                          };
    
    NSString *url = @"";
    if (offerType == 1 || offerType == 2) {
        url = APP_MINE_OFFER_LIST_URL;
    }else{
        url = APP_MINE_REQUIRE_LIST_URL;
    }
    _weekSelf(weakSelf);
    [[NetAPIManager sharedManager] request_common_WithPath:url Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        
        if (offerType == 1) {
            self.mineOfferWaitListModel = [MTLJSONAdapter modelOfClass:[MineOfferWaitListModel class] fromJSONDictionary:data error:nil];
            if (_mineOfferWaitListModel.code == 200) {
                [NSObject showHudTipStr:@"返回成功"];
                
                if (_pages == 1) {
                    _dataSource = [NSMutableArray arrayWithArray:_mineOfferWaitListModel.data.enquirylist];
                }else{
                    [_dataSource addObjectsFromArray:_mineOfferWaitListModel.data.enquirylist];
                }
                [weakSelf stopAllRefreshAction];
                [weakSelf.offerTableView reloadData];
                
            }else if(_mineOfferWaitListModel.code == 408){
//                [NSObject showHudTipStr:_mineOfferListModel.msg];
//                LoginVC *loginVC = [LoginVC new];
//                loginVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:loginVC animated:YES];
            }else {
                [NSObject showHudTipStr:_mineOfferWaitListModel.msg];
            }
        }else if (offerType == 2){
            self.mineOfferAleadListModel = [MTLJSONAdapter modelOfClass:[MineOfferAleadListModel class] fromJSONDictionary:data error:nil];
            if (_mineOfferAleadListModel.code == 200) {
                [NSObject showHudTipStr:@"返回成功!"];
                if (_pages == 1) {
                    _dataSource = [NSMutableArray arrayWithArray:_mineOfferAleadListModel.data.enquirylist];
                }else{
                    [_dataSource addObjectsFromArray:_mineOfferAleadListModel.data.enquirylist];
                }
                [weakSelf stopAllRefreshAction];
                [weakSelf.offerTableView reloadData];
                
            }else{
                [NSObject showHudTipStr:_mineOfferAleadListModel.msg];
            }
            
            
        }else if (offerType == 3) {
            self.mineOfferListModel = [MTLJSONAdapter modelOfClass:[MineOfferListModel class] fromJSONDictionary:data error:nil];
            if (_mineOfferListModel.code == 200) {
                [NSObject showHudTipStr:@"返回成功"];
                
                if (_pages == 1) {
                    _dataSource = [NSMutableArray arrayWithArray:_mineOfferListModel.data.enquirylist];
                }else{
                    [_dataSource addObjectsFromArray:_mineOfferListModel.data.enquirylist];
                }
                [weakSelf stopAllRefreshAction];
                [weakSelf.offerTableView reloadData];
                
            }else if(_mineOfferListModel.code == 408){
                [NSObject showHudTipStr:_mineOfferListModel.msg];
                LoginVC *loginVC = [LoginVC new];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
                
            }else {
                [NSObject showHudTipStr:_mineOfferListModel.msg];
            }
        }else if (offerType == 4){
            self.mineRequireAleadListModel = [MTLJSONAdapter modelOfClass:[MineRequireAleadListModel class] fromJSONDictionary:data error:nil];
            if (_mineRequireAleadListModel.code == 200) {
                [NSObject showHudTipStr:@"返回成功"];
                
                if (_pages == 1) {
                    _dataSource = [NSMutableArray arrayWithArray:_mineRequireAleadListModel.data.enquirylist];
                }else{
                    [_dataSource addObjectsFromArray:_mineRequireAleadListModel.data.enquirylist];
                }
                [weakSelf stopAllRefreshAction];
                [weakSelf.offerTableView reloadData];
            }else{
                [NSObject showHudTipStr:_mineRequireAleadListModel.msg];
            }
        }
        
        
        
    } failue:^(id data, NSError *error) {
        
    }];
    
    
    
}



/**
 * 初始化数据表
 */
- (void) initTableView {
    self.offerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _offerTableView.backgroundColor = RGBA(236, 238, 241, 1);
    _offerTableView.delegate =self;
    _offerTableView.dataSource = self;
    
    if (_types !=2) {
        [_offerTableView registerClass:[OfferListCell class] forCellReuseIdentifier:@"OfferListCell"];
    }else {
        [_offerTableView registerClass:[OfferListAutoSizeCell class] forCellReuseIdentifier:@"OfferListAutoSizeCell"];
    }
//    _offerTableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"placerholder" titleStr:@"网络断开" detailStr:@"请检查网络连接" btnTitleStr:@"重新加载" btnClickBlock:^{
//        [self initDataWithType:_types withPage:1 withPageNum:10];
//    }];
//    _offerTableView.zh_reloadAnimationType = zhTableViewAnimationTypeSlideFromLeft;
    [self.view addSubview:_offerTableView];
    _weekSelf(weakSelf)
    [_offerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    // 添加刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFromNet)];
    header.automaticallyChangeAlpha = YES;
    [header setTitle:@"下拉开始刷新" forState:(MJRefreshStateIdle)];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"即将开始刷新~" forState:MJRefreshStateWillRefresh];
    self.offerTableView.mj_header = header;
    //    [header beginRefreshing];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataFromNet)];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经到底了~" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"松开加载更多..." forState:MJRefreshStatePulling];
    [footer setTitle:@"即将开始加载..." forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"下拉查看更多~" forState:MJRefreshStateIdle];
    self.offerTableView.mj_footer = footer;
    
}
// 上拉刷新
- (void) loadNewDataFromNet {
    _pages = 1;
    [self initDataWithType:_types withPage:1 withPageNum:10];
}
// 下拉加载
- (void) loadMoreDataFromNet {
    // 提示停止没有更多数据了
//    NSInteger total = [_mineOfferListModel.data.total integerValue];
    //    DebugLog(@"打印的数据为%ld",total);
    if (_types == 1) {
        if (_pages*10>=_mineOfferWaitListModel.data.total) {
            [self.offerTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            _pages += 1;
            [self initDataWithType:_types withPage:_pages withPageNum:10];
        }
    }else if(_types == 2){
        if (_pages*10>=_mineOfferAleadListModel.data.total) {
            [self.offerTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            _pages += 1;
            [self initDataWithType:_types withPage:_pages withPageNum:10];
        }
    }else if (_types == 3){
        if (_pages*10>=_mineOfferListModel.data.total) {
            [self.offerTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            _pages += 1;
            [self initDataWithType:_types withPage:_pages withPageNum:10];
        }
    }else if (_types == 4){
        if (_pages*10>=_mineRequireAleadListModel.data.total) {
            [self.offerTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            _pages += 1;
            [self initDataWithType:_types withPage:_pages withPageNum:10];
        }
    }
    
    
}
// 停止刷新
- (void) stopAllRefreshAction {
    [self.offerTableView.mj_header endRefreshing];
    [self.offerTableView.mj_footer endRefreshing];
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
    
    if (_types != 2) {
        OfferListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OfferListCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setCellTypeWithNumber:_types];
        if (_types == 1) {
            self.mineOfferWaitisEnquirylistListModel = [MTLJSONAdapter modelOfClass:[MineOfferWaitisEnquirylistListModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
            cell.orderNumberLB.text = [NSString stringWithFormat:@"报价单号: %@",_mineOfferWaitisEnquirylistListModel.enqu_code];
            cell.nameLB.text = [NSString stringWithFormat:@"制单人员: %@",_mineOfferWaitisEnquirylistListModel.user_name];
            cell.publishTimeLB.text = [NSString stringWithFormat:@"发布时间: %ld",_mineOfferWaitisEnquirylistListModel.create_ts];
        } else if (_types == 3){
            DebugLog(@"当前的数据为");
            self.mineOfferEnquirylistModel = [MTLJSONAdapter modelOfClass:[MineOfferEnquirylistModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
            cell.orderNumberLB.text = [NSString stringWithFormat:@"询价单号: %@",_mineOfferEnquirylistModel.match_enqu_id];
            cell.nameLB.text = [NSString stringWithFormat:@"发布时间: %ld",_mineOfferEnquirylistModel.create_ts];
        } else if (_types == 4){
            self.mineRequireAleadEnquiryListModel = [MTLJSONAdapter modelOfClass:[MineRequireAleadEnquiryListModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
            cell.orderNumberLB.text = [NSString stringWithFormat:@"询价单号: %@",_mineRequireAleadEnquiryListModel.match_enqu_id];
            cell.nameLB.text = [NSString stringWithFormat:@"发布时间: %ld",_mineRequireAleadEnquiryListModel.create_ts];
            cell.totalBussnessLB.text = [NSString stringWithFormat:@"有%ld个商家报价",_mineRequireAleadEnquiryListModel.org_count];
        }
        return cell;
    }
    else if(_types == 2){
        OfferListAutoSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferListAutoSizeCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.mineOfferAleadIsEnquirylistModel = [MTLJSONAdapter modelOfClass:[MineOfferAleadIsEnquirylistModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
        cell.orderNumberLB.text = [NSString stringWithFormat:@"报价单号: %@",_mineOfferAleadIsEnquirylistModel.resp_code];
        cell.nameLB.text = [NSString stringWithFormat:@"制单人员: %@",_mineOfferAleadIsEnquirylistModel.user_name];
        cell.publishTimeLB.text = [NSString stringWithFormat:@"发布时间: %@",_mineOfferAleadIsEnquirylistModel.create_ts];
        cell.orderTimeLB.text = [NSString stringWithFormat:@"报价时间：%@",_mineOfferAleadIsEnquirylistModel.modify_ts];
        cell.totalMonryLB.text = @"总金额(元)：";
        cell.priceLB.text = [NSString stringWithFormat:@"%@",_mineOfferAleadIsEnquirylistModel.price];
        cell.remarkLB.text = [NSString stringWithFormat:@"备注信息：%@",_mineOfferAleadIsEnquirylistModel.remark];
        return cell;
        
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_types == 1) {
        self.mineOfferWaitisEnquirylistListModel = [MTLJSONAdapter modelOfClass:[MineOfferWaitisEnquirylistListModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
        ComThreeVC *threeVC = [ComThreeVC new];
        threeVC.currentID = _types;
        threeVC.requireNumber = _mineOfferWaitisEnquirylistListModel.match_enqu_id;
        [self.navigationController pushViewController:threeVC animated:YES];
    }else if (_types == 3) {
        self.mineOfferEnquirylistModel = [MTLJSONAdapter modelOfClass:[MineOfferEnquirylistModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
        ComThreeVC *threeVC = [ComThreeVC new];
        threeVC.requireNumber = _mineOfferEnquirylistModel.match_enqu_id;
        threeVC.currentID = _types;
        [self.navigationController pushViewController:threeVC animated:YES];
    }else if(_types == 4){
        // 查看商家列表
        self.mineRequireAleadEnquiryListModel = [MTLJSONAdapter modelOfClass:[MineRequireAleadEnquiryListModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
        ComSecondVC *secondVC = [ComSecondVC new];
        secondVC.enquireID = _mineRequireAleadEnquiryListModel.match_enqu_id;
        secondVC.currentPage = _types;
        secondVC.currentTitle = @"商家列表";
        [self.navigationController pushViewController:secondVC animated:YES];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_types == 1) {
        return 110;
    }else if(_types == 2){
        return [_offerTableView fd_heightForCellWithIdentifier:@"OfferListAutoSizeCell" cacheByIndexPath:indexPath configuration:^(OfferListAutoSizeCell *cell) {
            self.mineOfferAleadIsEnquirylistModel = [MTLJSONAdapter modelOfClass:[MineOfferAleadIsEnquirylistModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
            cell.orderNumberLB.text = [NSString stringWithFormat:@"报价单号: %@",_mineOfferAleadIsEnquirylistModel.resp_code];
            cell.nameLB.text = [NSString stringWithFormat:@"制单人员: %@",_mineOfferAleadIsEnquirylistModel.user_name];
            cell.publishTimeLB.text = [NSString stringWithFormat:@"发布时间: %@",_mineOfferAleadIsEnquirylistModel.create_ts];
            cell.orderTimeLB.text = [NSString stringWithFormat:@"报价时间：%@",_mineOfferAleadIsEnquirylistModel.modify_ts];
            cell.totalMonryLB.text = @"总金额(元)：";
            cell.priceLB.text = [NSString stringWithFormat:@"%@",_mineOfferAleadIsEnquirylistModel.price];
            cell.remarkLB.text = [NSString stringWithFormat:@"备注信息：%@",_mineOfferAleadIsEnquirylistModel.remark];
        }];
    }else if(_types == 3){
        return 80;
    }else if(_types == 4){
        return 110;
    }
    
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
