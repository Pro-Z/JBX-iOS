//
//  NewsListVC.m
//  JBX
//
//  Created by 证 on 2017/12/29.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NewsListVC.h"
#import "NewsListModel.h"
#import "NewsListCell.h"
#import "IronMasterVC.h"
@interface NewsListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NewsListModel *newsListModel;
@property (nonatomic,strong) UITableView *newsTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger indexPage;
@property (nonatomic,strong) NSString *currentNewsID;
@property (nonatomic,strong) NewsEcInformationArrModel *newsEcInformationArrModel;
@property (nonatomic,strong) NSString *searchTxt;
@end

@implementation NewsListVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CELL_LINE_GRAY_COLOR;
    self.indexPage = 1;
    self.dataSource = [NSMutableArray array];
    self.searchTxt = @"";
    [self initNavigationView];
    self.currentNewsID = [NSString stringWithFormat:@"%@",self.pageID];
    [self initData:_currentNewsID withPage:1 withSearchTxt:_searchTxt];
    [self initTableView];
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = self.titleStr;
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

- (void) initData:(NSString*)newsID withPage:(NSInteger) indexs withSearchTxt:(NSString *)searchTxt{
    if (indexs == 1) {
        [_dataSource removeAllObjects];
    }
    // 初始化数据
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexs];
    NSDictionary *dict = @{
                           @"Information_id":newsID,
                           @"page":indexStr,
                           @"pageNum":@"10",
                           @"titleName":searchTxt
                           };
//    DebugLog(@"传递的参数为%@",dict);
    _weekSelf(weakSelf);
    [[NetAPIManager sharedManager] request_common_WithPath:APP_GET_NEWS_LIST_URL Params:dict autoShowProgressHUD:NO typeGets:YES succesBlack:^(id data) {
        self.newsListModel = [MTLJSONAdapter modelOfClass:[NewsListModel class] fromJSONDictionary:data error:nil];
        
        if (_newsListModel.code == 200) {
//            [NSObject showSuccessHudTipStr:@"资讯获取成功!"];
            if (_indexPage == 1) {
                _dataSource = [NSMutableArray arrayWithArray:_newsListModel.data.EcInformation];
            }else{
                [_dataSource addObjectsFromArray:_newsListModel.data.EcInformation];
            }
//            DebugLog(@"解析的数据为%@",_dataSource);
            [weakSelf stopAllRefreshAction];
            [weakSelf.newsTableView reloadData];
            
        }else{
            [NSObject showHudTipStr:_newsListModel.msg];
        }
    } failue:^(id data, NSError *error) {
        
    }];
}

- (void) initTableView {
    self.newsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.newsTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.newsTableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"placerholder" titleStr:@"网络断开" detailStr:@"请检查网络连接" btnTitleStr:@"重新加载" btnClickBlock:^{

    }];
    [self.view addSubview:_newsTableView];
    _weekSelf(weakSelf)
    [_newsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
    // 添加刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFromNet)];
    header.automaticallyChangeAlpha = YES;
    [header setTitle:@"开始刷新" forState:(MJRefreshStateIdle)];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"即将开始刷新~" forState:MJRefreshStateWillRefresh];
    self.newsTableView.mj_header = header;
//    [header beginRefreshing];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataFromNet)];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经到底了~" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"松开加载更多..." forState:MJRefreshStatePulling];
    [footer setTitle:@"即将开始加载..." forState:MJRefreshStateWillRefresh];
    self.newsTableView.mj_footer = footer;
}
// 上啦刷新
- (void) loadNewDataFromNet {
    _indexPage = 1;
    [self initData:_currentNewsID withPage:1 withSearchTxt:_searchTxt];
}
// 下拉加载
- (void) loadMoreDataFromNet {
    
    // 提示停止没有更多数据了
    NSInteger total = [_newsListModel.data.total integerValue];
//    DebugLog(@"打印的数据为%ld",total);
    if (_indexPage*10>=total) {
        [self.newsTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        _indexPage += 1;
        [self initData:_currentNewsID withPage:_indexPage withSearchTxt:_searchTxt];
    }
}
// 停止刷新
- (void) stopAllRefreshAction {
    [self.newsTableView.mj_header endRefreshing];
    [self.newsTableView.mj_footer endRefreshing];
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
    static NSString *rid=@"NewsListCell";
    NewsListCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil){
        cell=[[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.newsEcInformationArrModel = [MTLJSONAdapter modelOfClass:[NewsEcInformationArrModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
        [cell setValueForCellWithtitle:_newsEcInformationArrModel.title withAddTime:_newsEcInformationArrModel.add_time withPicUrl:_newsEcInformationArrModel.imgUrl];
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DEFAULTS_SET_INTEGER(2, @"WEBTYPE");
    IronMasterVC *ironMasterVC = [IronMasterVC new];
    self.newsEcInformationArrModel = [MTLJSONAdapter modelOfClass:[NewsEcInformationArrModel class] fromJSONDictionary:_dataSource[indexPath.row] error:nil];
    ironMasterVC.content = _newsEcInformationArrModel.content;
    ironMasterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ironMasterVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
