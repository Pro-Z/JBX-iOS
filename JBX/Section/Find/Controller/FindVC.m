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

@interface FindVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) DZFindSearchView *centerSearchView;
@property (nonatomic,strong) UICollectionView *headerCollectionView;
@property (nonatomic,strong) UITableView *findTableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation FindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initCenterSearchView];
    [self initDataSource];
    [self initHeaderView];
    [self initTableView];
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
    self.dataArr = @[
                     @{
                         @"title":@"报价中心",
                         @"pic":@"offer_header_icon"
                         },
                     @{
                         @"title":@"求职招聘",
                         @"pic":@"job_header_icon"
                         },
                     @{
                         @"title":@"技术论坛",
                         @"pic":@"tech_header_icon"
                         },
                     @{
                         @"title":@"商家动态",
                         @"pic":@"shop_header_icon"
                         },
                     @{
                         @"title":@"平台咨询",
                         @"pic":@"plat_header_icon"
                         },
                     @{
                         @"title":@"行业资讯",
                         @"pic":@"ind_header_icon"
                         },
                     @{
                         @"title":@"商业资讯",
                         @"pic":@"business_header_icon"
                         },
                     @{
                         @"title":@"下游动态",
                         @"pic":@"downstream_header_icon"
                         }
                     ];
}
// 初始化头部界面
- (void) initHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 221)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
    self.headerCollectionView = [[UICollectionView alloc] initWithFrame:VIEWFRAME(10, 10, SCREEN_WIDTH-20, 170) collectionViewLayout:layout];
    _headerCollectionView.backgroundColor = [UIColor whiteColor];
    _headerCollectionView.delegate = self;
    _headerCollectionView.dataSource = self;
    _headerCollectionView.bounces = NO;
    _headerCollectionView.showsHorizontalScrollIndicator = NO;
    [_headerCollectionView registerClass:[FindHeaderCell class] forCellWithReuseIdentifier:@"FindHeaderCell"];
    [_headerView addSubview:_headerCollectionView];
    _weekSelf(weakSelf)
    [_headerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView).offset(0);
        make.left.equalTo(weakSelf.headerView).offset(0);
        make.right.equalTo(weakSelf.headerView).offset(0);
        make.height.mas_equalTo(@170);
    }];
    UIView *grapView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
    [_headerView addSubview:grapView];
    [grapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerCollectionView.mas_bottom).offset(10);
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
    return 8;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindHeaderCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor orangeColor];
    cell.txt.text = [_dataArr[indexPath.row] objectForKey:@"title"];
    cell.pic.image = [UIImage imageNamed:[_dataArr[indexPath.row] objectForKey:@"pic"]];
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 75);
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        JobVC *jov = [JobVC new];
//        BaseNavigationVC *naviVC = [[BaseNavigationVC alloc] initWithRootViewController:jov];
        jov.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:jov animated:YES];
        
    }
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"NewsListCell";
    NewsListCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil){
        cell=[[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.titleLabel.text = @"测试标题";
        cell.timeMillsLabel.text = @"测试副标题";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
