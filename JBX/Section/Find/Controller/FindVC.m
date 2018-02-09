//
//  FindVC.m
//  JBX
//
//  Created by 证 on 2018/1/9.
//  Copyright © 2018年 证. All rights reserved.
//

#import "FindVC.h"
#import "FindHeaderCell.h"
#import "FindListCell.h"
#import "NewsListCell.h"
#import "JobVC.h"
#import "HorizontalFlowLayout.h"
#import "PageControl.h"
#import "NewsTitleListModel.h"
#import "NewsListVC.h"
#import "NoNetView.h"
#import "NewsListModel.h"
#import "IronMasterVC.h"

@interface CollectionCellWhite : UICollectionViewCell

@end

@implementation CollectionCellWhite

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end

@interface FindVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) DZFindSearchView *centerSearchView;
@property (nonatomic,strong) UICollectionView *headerCollectionView;
@property (nonatomic,strong) UITableView *findTableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger pageCount;
@property (nonatomic,strong) PageControl *pageControl;
@property (nonatomic,strong) NewsTitleListModel *newsTitleListModel;
@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NewsListModel *newsListModel;
@property (nonatomic,strong) NSMutableArray *newsListDataSource;
@property (nonatomic,strong) NewsEcInformationArrModel *newsEcInformationArrModel;
@end

@implementation FindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    self.newsListDataSource = [NSMutableArray array];
    [self initCenterSearchView];
    [self initDataSource];
}


/**
 初始化搜索栏
 */
- (void) initCenterSearchView {
    UIView *searchView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHTS)];
//    searchView.backgroundColor = [UIColor orangeColor];
    self.centerSearchView = [[DZFindSearchView alloc] initWithFrame:VIEWFRAME(1, 0, SCREEN_WIDTH, 44)];
    _centerSearchView.placeholder = @"搜索关键词试试看？";
    [searchView addSubview:_centerSearchView];
    self.navigationItem.titleView = searchView;
}

- (void) initDataSource {
    NSArray *curArr = @[
                        @{
                            @"title":@"报价中心",
                            @"pic":@"offer_header_icon",
                            @"id":@"0"
                            },
                        @{
                            @"title":@"求职招聘",
                            @"pic":@"job_header_icon",
                            @"id":@"1"
                            },
                        @{
                            @"title":@"技术论坛",
                            @"pic":@"tech_header_icon",
                            @"id":@"2"
                            },
                        @{
                            @"title":@"商家动态",
                            @"pic":@"shop_header_icon",
                            @"id":@"3"
                            }
                        ];
    [_dataSource addObjectsFromArray:curArr];
    
    self.picArr = @[@"plat_header_icon",@"ind_header_icon",@"business_header_icon",@"downstream_header_icon",@"plat_header_icon",@"ind_header_icon",@"business_header_icon",@"downstream_header_icon",@"plat_header_icon",@"ind_header_icon",@"business_header_icon",@"downstream_header_icon",@"plat_header_icon",@"ind_header_icon",@"business_header_icon",@"downstream_header_icon"];
    [self initTabLayoutData];
}
// 初始化标题栏数据
- (void) initTabLayoutData {
    [[NetAPIManager sharedManager] request_common_WithPath:APP_GET_NEWS_TITLE_LIST_URL Params:nil autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        // 解析数据
        self.newsTitleListModel = [MTLJSONAdapter modelOfClass:[NewsTitleListModel class] fromJSONDictionary:data error:nil];
        if (_newsTitleListModel.code == 200) {
//            [NSObject showSuccessHudTipStr:@"标题返回成功!"];
            // 重新组织数据
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_newsTitleListModel.data.EcInformationCat.count];
            for (int i = 0; i<_newsTitleListModel.data.EcInformationCat.count; i++) {
                NSMutableDictionary *newDic = [[NSMutableDictionary alloc] init];
                [newDic setValue:[_newsTitleListModel.data.EcInformationCat[i] key_name] forKey:@"title"];
                [newDic setValue:_picArr[i] forKey:@"pic"];
                [newDic setValue:[_newsTitleListModel.data.EcInformationCat[i] ids] forKey:@"id"];
                [arr addObject:newDic];
            }
            [_dataSource addObjectsFromArray:arr];
            [self initHeaderView];
            [self initTableView];
            
            
            
            // 初始化新闻模块的数据
            int x = arc4random() % _newsTitleListModel.data.EcInformationCat.count;
            NSString *idxs = [_newsTitleListModel.data.EcInformationCat[x] ids];
            [self initData:idxs withPage:1 withSearchTxt:@""];
            
        }else{
            [NSObject showHudTipStr:_newsTitleListModel.msg];
        }
        
    } failue:^(id data, NSError *error) {
        [NSObject showHudTipStr:@"网络出错!请检查网络连接!"];
        NoNetView *noNetView = [[NoNetView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:noNetView];
        noNetView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadView)];
        [noNetView addGestureRecognizer:tap];
        
    }];
    
    
    
}
- (void) reloadView {
    [_dataSource removeAllObjects];
    [self initDataSource];
}

// 初始化头部界面
- (void) initHeaderView {
    
    self.pageCount = _dataSource.count;
    while (_pageCount % 8 != 0) {
        ++_pageCount;
    }
    DebugLog(@"个数为%ld",_pageCount);
    self.headerView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 221)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    HorizontalFlowLayout *layout = [[HorizontalFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH)/4, 75);
    layout.minimumInteritemSpacing = 0*WIDTHFACTOR;
    layout.minimumLineSpacing = 0*WIDTHFACTOR;
    layout.headerReferenceSize = CGSizeMake(0*WIDTHFACTOR, 0*WIDTHFACTOR);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [layout setRowCount:2];
    [layout setItemCountPerRow:4];
    
    
    self.headerCollectionView = [[UICollectionView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 170) collectionViewLayout:layout];
    _headerCollectionView.backgroundColor = [UIColor whiteColor];
    _headerCollectionView.delegate = self;
    _headerCollectionView.dataSource = self;
    _headerCollectionView.bounces = NO;
    _headerCollectionView.pagingEnabled = YES;
    _headerCollectionView.showsHorizontalScrollIndicator = NO;
    [_headerCollectionView registerClass:[FindHeaderCell class] forCellWithReuseIdentifier:@"FindHeaderCell"];
    [_headerCollectionView registerClass:[CollectionCellWhite class] forCellWithReuseIdentifier:@"CollectionCellWhite"];
    [_headerView addSubview:_headerCollectionView];
    _weekSelf(weakSelf)
    // 初始化pageController
    self.pageControl = [[PageControl alloc] initWithFrame:CGRectZero];
    _pageControl.backgroundColor = [UIColor whiteColor];
    _pageControl.numberOfPages = _pageCount/8;
    _pageControl.padding = 8;
    _pageControl.radius = 2;
    _pageControl.lineWidth = 2;
    _pageControl.pageIndicatorTintColor = CELL_LINE_GRAY_COLOR;
    _pageControl.currentPageIndicatorTintColor = APP_COLOR_BASE_NAV;
    [_pageControl addTarget:self action:@selector(pageScrollview:) forControlEvents:UIControlEventValueChanged];
    [_headerView addSubview:_pageControl];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerCollectionView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
        make.height.equalTo(@10);
    }];
    
    
    
    UIView *grapView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_headerView addSubview:grapView];
    [grapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pageControl.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
        make.height.mas_equalTo(@10);
    }];
    
    
    UIView *bottomView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [_headerView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grapView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
        make.height.mas_equalTo(@41);
    }];
    UIImageView *pic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                 withImageName:@"icon_recom"];
    [bottomView addSubview:pic];
    [pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.left.equalTo(bottomView.mas_left).offset(17);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@20);
    }];
    UILabel *txt = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"为你推荐"
                                   withTextColor:RGBA(3, 115, 228, 1)
                                        withFont:PINGFANG_FONT_SIZE(15)
                                     withGbColor:[UIColor whiteColor]
                               withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.left.equalTo(pic.mas_right).offset(5);
//        make.right.equalTo(bottomView.mas_right).offset(-10);
        make.height.equalTo(@22);
    }];

    UIView *line = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom).offset(0);
        make.left.equalTo(bottomView.mas_left).offset(0);
        make.right.equalTo(bottomView.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    
}

- (void) pageScrollview:(PageControl*)control {
    NSLog(@"current page = %ld",(long)control.currentPage);
    [_headerCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(long)control.currentPage*8 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
// 滚动挺值钱的坐标
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger current = targetContentOffset->x/SCREEN_WIDTH;
    NSLog(@"当前页面为%ld",current);
    // 防止嵌套
    if (_headerCollectionView) {
        [_pageControl setCurrentPage:current animated:YES];
    }
}

- (void) initTableView {
    self.findTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _findTableView.delegate = self;
    _findTableView.dataSource = self;
    _findTableView.tableHeaderView = _headerView;
    [self.view addSubview:_findTableView];
    _weekSelf(weakSelf)
    [_findTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
}


#pragma mark -- collectionView dataSource

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _pageCount;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindHeaderCell *cell = nil;
    if (indexPath.item >= _dataSource.count) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCellWhite" forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindHeaderCell" forIndexPath:indexPath];
                cell.backgroundColor = [UIColor whiteColor];
        cell.txt.text = [_dataSource[indexPath.row] objectForKey:@"title"];
        cell.pic.image = [UIImage imageNamed:[_dataSource[indexPath.row] objectForKey:@"pic"]];
    }
    
    return cell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    //        // 头部
    //        WWCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
    //        view.headerLabel.text = [NSString stringWithFormat:@"头部 - %zd",indexPath.section];
    //        return view;
    //
    //    }else {
    //        // 底部
    //        WWCollectionFooterReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
    //        view.footerLabel.text = [NSString stringWithFormat:@"底部 - %zd",indexPath.section];
    //        return view;
    //    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(80, 75);
//}

///** 头部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 40);
//}
//
///** 顶部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 40);
//}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item < _dataSource.count) {
        NSLog(@"点击了第 %zd个 id是%@",indexPath.row, [_dataSource[indexPath.row] objectForKey:@"id"]);
        
        if (indexPath.section == 0 && indexPath.row == 1) {
            JobVC *jov = [JobVC new];
            jov.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:jov animated:YES];
        }
        NSInteger currenID = [[_dataSource[indexPath.row] objectForKey:@"id"] integerValue];
        if (currenID > 3) {
            // 跳转到新闻模块
            NewsListVC *newListVC = [NewsListVC new];
            newListVC.hidesBottomBarWhenPushed = YES;
            newListVC.pageID = [NSString stringWithFormat:@"%@", [_dataSource[indexPath.row] objectForKey:@"id"]];
            newListVC.titleStr = [NSString stringWithFormat:@"%@",[_dataSource[indexPath.row] objectForKey:@"title"]];
            [self.navigationController pushViewController:newListVC animated:YES];
        }
    }
    
    
    
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsListDataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"NewsListCell";
    NewsListCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil){
        cell=[[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.newsEcInformationArrModel = [MTLJSONAdapter modelOfClass:[NewsEcInformationArrModel class] fromJSONDictionary:_newsListDataSource[indexPath.row] error:nil];
        [cell setValueForCellWithtitle:_newsEcInformationArrModel.title withAddTime:_newsEcInformationArrModel.add_time withPicUrl:_newsEcInformationArrModel.imgUrl];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DEFAULTS_SET_INTEGER(2, @"WEBTYPE");
    IronMasterVC *ironMasterVC = [IronMasterVC new];
    self.newsEcInformationArrModel = [MTLJSONAdapter modelOfClass:[NewsEcInformationArrModel class] fromJSONDictionary:_newsListDataSource[indexPath.row] error:nil];
    ironMasterVC.content = _newsEcInformationArrModel.content;
    ironMasterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ironMasterVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (void) initData:(NSString*)newsID withPage:(NSInteger) indexs withSearchTxt:(NSString *)searchTxt{
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
            self.newsListDataSource = [NSMutableArray arrayWithArray:_newsListModel.data.EcInformation];
            [weakSelf.findTableView reloadData];
        }else{
            [NSObject showHudTipStr:_newsListModel.msg];
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
