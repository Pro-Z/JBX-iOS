//
//  BoutiqueListVC.m
//  JBX
//
//  Created by 证 on 2018/1/18.
//  Copyright © 2018年 证. All rights reserved.
//

#import "BoutiqueListVC.h"
#import "BoutiqueCell.h"
#import "ItemModel.h"
#import "BoutiqueDetalVC.h"
#import "BoutiqueListModel.h"

@interface BoutiqueListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *boutiqueCollectionView;
@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) BoutiqueRealListModel *boutiqueRealListModel;
@property (nonatomic,strong) BoutiqueRealDataListModel *boutiqueRealDataListModel;
@property (nonatomic,strong) BoutiqueRealFanexListListModel *boutiqueRealFanexListListModel;

@end

@implementation BoutiqueListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.index = 1;
    self.dataSource = [NSMutableArray array];
    WHITE_BG
//    [self initDataSourceWithItem:self.pageID withPage:1 withPageNum:10];
//    [self initCollectionView];
    
    [self initDataSource];
    [self initCollectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.boutiqueCollectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}



///**
// 初始化精品数据源
//
// @param item tab id
// @param page page
// @param pageNum pageNum
// */
//- (void) initDataSourceWithItem:(NSString*)item withPage:(NSInteger)page withPageNum:(NSInteger)pageNum {
//    if (_index == 1) {
//        [_dataSource removeAllObjects];
//    }
//    _weekSelf(weakSelf);
//    NSDictionary *dict = @{
//                           @"fan_type":item,
//                           @"page":[NSString stringWithFormat:@"%ld",page],
//                           @"pageNum":[NSString stringWithFormat:@"%ld",pageNum]
//                           };
//    [[NetAPIManager sharedManager] request_common_WithPath:APP_BOUTIQUE_LIST_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
//        self.boutiqueRealListModel = [BoutiqueRealListModel mj_objectWithKeyValues:data];
//        if (_boutiqueRealListModel.code == 200) {
//            BoutiqueRealDataListModel *data = [BoutiqueRealDataListModel mj_objectWithKeyValues:_boutiqueRealListModel.data];
//            NSMutableArray *arr = [BoutiqueRealFanexListListModel mj_objectArrayWithKeyValuesArray:data.fanexList];
//
//            if (_index == 1) {
//                _dataSource = [NSMutableArray arrayWithArray:arr];
//            }else{
//                [_dataSource addObjectsFromArray:arr];
//            }
//            [weakSelf stopAllRefreshAction];
//            [weakSelf.boutiqueCollectionView reloadData];
//        }else{
//
//        }
//
//
//    } failue:^(id data, NSError *error) {
//
//    }];
//
//
//    for (NSString *item in _picArr) {
//        ItemModel *model = [ItemModel new];
//        model.imageUrl = item;
//        [self.dataSource addObject:model];
//    }
//
//}
//
//
//- (void) initCollectionView{
//
//    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    [flowLayout setColumnCount:2];
////    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
////    [flowLayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
//    self.boutiqueCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    _boutiqueCollectionView.backgroundColor = RGBA(243, 243, 243, 1);
//    _boutiqueCollectionView.delegate = self;
//    _boutiqueCollectionView.dataSource = self;
//    [_boutiqueCollectionView registerClass:[BoutiqueCell class] forCellWithReuseIdentifier:@"BoutiqueCell"];
//    [self.view addSubview:_boutiqueCollectionView];
//    _weekSelf(weakSelf)
//    [_boutiqueCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view).offset(10);
//        make.left.equalTo(weakSelf.view).offset(0);
//        make.right.equalTo(weakSelf.view).offset(0);
//        make.bottom.equalTo(weakSelf.view).offset(0);
//    }];
//
//    // 添加刷新
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFromNet)];
//    header.automaticallyChangeAlpha = YES;
//    [header setTitle:@"开始刷新" forState:(MJRefreshStateIdle)];
//    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    [header setTitle:@"即将开始刷新~" forState:MJRefreshStateWillRefresh];
//    self.boutiqueCollectionView.mj_header = header;
//    //    [header beginRefreshing];
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataFromNet)];
//    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"已经到底了~" forState:MJRefreshStateNoMoreData];
//    [footer setTitle:@"松开加载更多..." forState:MJRefreshStatePulling];
//    [footer setTitle:@"即将开始加载..." forState:MJRefreshStateWillRefresh];
//    self.boutiqueCollectionView.mj_footer = footer;
//
//}
//
//// 上啦刷新
//- (void) loadNewDataFromNet {
//    _index = 1;
//    [self initDataSourceWithItem:_pageID withPage:1 withPageNum:10];
//}
//// 下拉加载
//- (void) loadMoreDataFromNet {
//
//    // 提示停止没有更多数据了
//    NSInteger total = [_boutiqueRealListModel.data.total integerValue];
//    //    DebugLog(@"打印的数据为%ld",total);
//    if (_index*10>=total) {
//        [self.boutiqueCollectionView.mj_footer endRefreshingWithNoMoreData];
//    }else {
//        _index += 1;
//        [self initDataSourceWithItem:_pageID withPage:_index withPageNum:10];
//    }
//}
//// 停止刷新
//- (void) stopAllRefreshAction {
//    [self.boutiqueCollectionView.mj_header endRefreshing];
//    [self.boutiqueCollectionView.mj_footer endRefreshing];
//}
//
//#pragma mark -- collectionView dataSource
//
///** 每组cell的个数*/
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _dataSource.count;
//}
//
///** cell的内容*/
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    BoutiqueCell *cell = nil;
//
//    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueCell" forIndexPath:indexPath];
//    cell.backgroundColor = RGBA(246, 246, 246, 1);
//
//    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
//
//    NSString *imgUrlString = model.imageUrl;
//    cell.nameLB.text = @"厦门钢鲸科技";
//    cell.timeLB.text = @"2-09";
//    [cell.firstBTN setTitle:@"#精品" forState:(UIControlStateNormal)];
//    [cell.secondBTN setTitle:@"#最新" forState:UIControlStateNormal];
//    cell.contentLB.text = _titleArr[indexPath.row];
//    CGFloat currentHeight = [cell heightForCellWithContent:_titleArr[indexPath.row]];
//
//
//    [cell.partPic sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"placerholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image) {
//
////            (SCREEN_WIDTH/2-5)/image.size.width *image.size.height
//            if (!CGSizeEqualToSize(model.imageSize, image.size)) {
//                model.imageSize = CGSizeMake(SCREEN_WIDTH/2-5, 100 + currentHeight);
//                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
////                DebugLog(@"当前cell的宽高为%f",(SCREEN_WIDTH/2-5)/image.size.width *image.size.height);
//
//
//
//            }
//        }
//    }];
////    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//
//
//    return cell;
//}
//
///** 总共多少组*/
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
///** 头部/底部*/
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//
//    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//    //        // 头部
//    //        WWCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
//    //        view.headerLabel.text = [NSString stringWithFormat:@"头部 - %zd",indexPath.section];
//    //        return view;
//    //
//    //    }else {
//    //        // 底部
//    //        WWCollectionFooterReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
//    //        view.footerLabel.text = [NSString stringWithFormat:@"底部 - %zd",indexPath.section];
//    //        return view;
//    //    }
//}
//
//#pragma mark -- UICollectionViewDelegateFlowLayout
/////** 每个cell的尺寸*/
////- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
////{
////
////    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
////    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
////        return model.imageSize;
////    }
////
////    return CGSizeMake(0, 0);
////}
//
//#pragma mark - CHTCollectionViewDelegateWaterfallLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
//    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
//        return model.imageSize;
//    }
//
//    return CGSizeMake(150, 150);
//}
//
//
/////** 头部的尺寸*/
////-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
////
////
////    return CGSizeMake(self.view.bounds.size.width, 40);
////}
////
/////** 顶部的尺寸*/
////-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
////
////
////    return CGSizeMake(self.view.bounds.size.width, 40);
////}
//
///** section的margin*/
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 0, 10, 0);
//}
//
//#pragma mark -- UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    BoutiqueDetalVC *detailVC = [BoutiqueDetalVC new];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
//
//}


// 测试版本使用
- (void) initDataSource {
    self.titleArr = @[@"异形测试图例,不锈钢异型钢管是除了圆管以外的其他截面形状的钢管的总称.",
                      @"圆形测试图例",
                      @"异形测试图例",
                      @"盒子测试图例",
                      @"斜边测试用例",
                      @"斜边测试用例",
                      @"弧形测试用例",
                      @"斜边测试用例",
                      @"圆形测试图例",
                      @"弧形测试用例",
                      @"盒子测试图例",
                      @"异形测试图例",
                      @"异形测试图例,不锈钢异型钢管是除了圆管以外的其他截面形状的钢管的总称.",
                      @"弧形测试用例"
                      ];
    
    
    self.picArr = @[
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/4e50ed193162442ea44d4c5c3ab17914/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/0a6e3884638d47708e7dfc2e84b2fdd0/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/9cb9d85acb3e49129e648177a86c58d7/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/89121ae1bf134f99ad06c14cbae053ee/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/3576cdf768c5496f8927e25270b854ae/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/2a5b162407504ee29c561b47bb2c9779/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/0d5df9eeca72466189d72b68a791f3b6/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/2a5b162407504ee29c561b47bb2c9779/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/e1dcf3086fb6417e816c90eee34e4a88/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/26c9cbf5669048908b84ce5bc9b4a410/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/83657b68ec104e9ab615cef86c0cd8df/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/4e50ed193162442ea44d4c5c3ab17914/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/9cb9d85acb3e49129e648177a86c58d7/thumbnail.png",
                    @"http://bjds.jubuxiu.com/GCGL//GRAPHICAL/admin/26c9cbf5669048908b84ce5bc9b4a410/thumbnail.png"
                    
                    
                    ];
    
    self.dataSource = [NSMutableArray array];
    for (NSString *item in _picArr) {
        ItemModel *model = [ItemModel new];
        model.imageUrl = item;
        [self.dataSource addObject:model];
    }
    
}


- (void) initCollectionView{
    
    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [flowLayout setColumnCount:2];
    //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    [flowLayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
    self.boutiqueCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _boutiqueCollectionView.backgroundColor = RGBA(243, 243, 243, 1);
    _boutiqueCollectionView.delegate = self;
    _boutiqueCollectionView.dataSource = self;
    [_boutiqueCollectionView registerClass:[BoutiqueCell class] forCellWithReuseIdentifier:@"BoutiqueCell"];
    [self.view addSubview:_boutiqueCollectionView];
    _weekSelf(weakSelf)
    [_boutiqueCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
    
    
}
#pragma mark -- collectionView dataSource

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoutiqueCell *cell = nil;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueCell" forIndexPath:indexPath];
    cell.backgroundColor = RGBA(246, 246, 246, 1);
    
    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *imgUrlString = model.imageUrl;
    cell.nameLB.text = @"厦门钢鲸科技";
    cell.timeLB.text = @"2-09";
//    [cell.firstBTN setTitle:@"#精品  #最新" forState:(UIControlStateNormal)];
    cell.firstBTN.text = @"    #精品  #最新";
//    [cell.secondBTN setTitle:@"#最新" forState:UIControlStateNormal];
    cell.contentLB.text = _titleArr[indexPath.row];
    CGFloat currentHeight = [cell heightForCellWithContent:_titleArr[indexPath.row]];
    
    
    [cell.partPic sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"placerholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            
            //            (SCREEN_WIDTH/2-5)/image.size.width *image.size.height
            if (!CGSizeEqualToSize(model.imageSize, image.size)) {
                model.imageSize = CGSizeMake(SCREEN_WIDTH/2-5, 100 + currentHeight);
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                //                DebugLog(@"当前cell的宽高为%f",(SCREEN_WIDTH/2-5)/image.size.width *image.size.height);
                
            }
        }
    }];
    //    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    
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
///** 每个cell的尺寸*/
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
//    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
//        return model.imageSize;
//    }
//
//    return CGSizeMake(0, 0);
//}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
        return model.imageSize;
    }
    
    return CGSizeMake(150, 150);
}


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
//    BoutiqueDetalVC *detailVC = [BoutiqueDetalVC new];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
    
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
