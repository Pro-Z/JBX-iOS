//
//  JobVC.m
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import "JobVC.h"
#import "TipsVC.h"
#import "HotTVC.h"
#import "hotCateCell.h"
#import "FindThreeVC.h"

@interface JobVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView *hotTitleView;
@property (nonatomic,strong) UICollectionView *hotCollectionView;
@property (nonatomic,strong) DZSegmentController *segmentVC;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) UITableViewController *hotTVC;
@property (nonatomic,strong) UIScrollView *hotScrollView;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation JobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    [self initNavigationView];
    [self initHotView];
    [self initDataSource];
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = @"求职招聘";
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
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_job_user"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) operateBtn {
    // 退出一个下拉框
    TipsVC *tipsVC = [[TipsVC alloc] initWithShowFrame:VIEWFRAME(0, NAVIGATION_HEIGHTS+STATUS_BAR_HEIGHT, SCREEN_WIDTH, 92) ShowStyle:1 callback:^(id callback) {
        if ([callback isEqual:[NSNumber numberWithInteger:0]]) {
            [self initJumpToThreeView:0 withTitle:@"我的简历"];
        }else if ([callback isEqual:[NSNumber numberWithInteger:1]]) {
            [self initJumpToThreeView:1 withTitle:@"我的求职"];
        }else {
            [self initJumpToThreeView:2 withTitle:@"我要招人"];
        }
    }];
    [self presentViewController:tipsVC animated:YES completion:nil];
}
- (void) initJumpToThreeView:(NSInteger) currentID withTitle:(NSString*)titles {
    FindThreeVC *findThreeVC = [FindThreeVC new];
    findThreeVC.currentID = currentID;
    findThreeVC.titleStr = titles;
    [self.navigationController pushViewController:findThreeVC animated:YES];
}


- (void) initDataSource {
    self.dataArr = @[
                     @{
                         @"pic":@"icon_fire",
                         @"text":@"切割师傅"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"折板师傅"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"销售人员"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"仓管人员"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"配送人员"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"财务人员"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"后勤人员"
                         },
                     @{
                         @"pic":@"",
                         @"text":@"制图人员"
                         }
                     ];
}


/**
 初始化热门推荐148
 */
- (void) initHotView {
    self.hotScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _hotScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HIGHT);
    [self.view addSubview:_hotScrollView];
    self.hotTitleView = [UIView initWithUIViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 148) withBackground:[UIColor whiteColor]];
    [_hotScrollView addSubview:_hotTitleView];
    // 顶部分类框
    UIView *titTxt = [UILabel initUILabelWithFrame:CGRectZero
                                          withText:@"热门推荐"
                                     withTextColor:RGBA(3, 115, 228, 1)
                                          withFont:PINGFANG_FONT_SIZE(15)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentLeft];
    [_hotTitleView addSubview:titTxt];
    _weekSelf(weakSelf)
    [titTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hotTitleView).offset(15);
        make.left.equalTo(weakSelf.hotTitleView).offset(15);
        make.height.equalTo(@20);
    }];
    
    // 分类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _hotCollectionView.backgroundColor = RGBA(242, 242, 242, 1);
    _hotCollectionView.delegate = self;
    _hotCollectionView.dataSource = self;
    _hotCollectionView.bounces = NO;
    _hotCollectionView.showsHorizontalScrollIndicator = NO;
    [_hotCollectionView registerClass:[hotCateCell class] forCellWithReuseIdentifier:@"hotCateCell"];
    [_hotTitleView addSubview:_hotCollectionView];

    [_hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titTxt.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.hotTitleView).offset(0);
        make.right.equalTo(weakSelf.hotTitleView).offset(0);
        make.height.equalTo(@105);
    }];
    
    
    
    [self initTabLayout];
}

// 初始化tabLayout
- (void) initTabLayout {
    // 初始化tablayout
    self.navigationController.navigationBar.translucent = NO;
    self.titleArr = @[@"为你推荐",@"热门岗位",@"求职专场"];
    NSMutableArray *array  = [NSMutableArray arrayWithCapacity:_titleArr.count];
    for (int i = 0; i<_titleArr.count; i++) {
        self.hotTVC = [HotTVC new];
//        _newsListVC.pageID = _newsIDArr[i];
        [array addObject:_hotTVC];
    }
    self.segmentVC = [[DZSegmentController alloc] initWithFrame:VIEWFRAME(0, 155, SCREEN_WIDTH, SCREEN_HIGHT-(STATUS_BAR_HEIGHT+NAVIGATION_HEIGHTS+155)) titles:_titleArr];
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = APP_COLOR_BASE_NAV;
    self.segmentVC.viewControllers = array;
    //    if (array.count == 1) {
    //        self.segmentVC.segmentView.style = SegmentStyleDefault;
    //    } else {
    self.segmentVC.segmentView.style = SegmentStyleDefault;
    //    }
    //    [self.segmentVC  enumerateBadges:@[@(1),@10]];
    [self addSegmentController:self.segmentVC withView:_hotScrollView];
    [self.segmentVC  setSelectedAtIndex:1];
    [self.segmentVC  setSelectedAtIndex:0];
}


#pragma mark -- collectionView dataSource

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    hotCateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCateCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    cell.txt.text = [_dataArr[indexPath.row] objectForKey:@"text"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.txt.textColor = RGBA(249, 3, 0, 1);
        cell.pic.image = [UIImage imageNamed:[_dataArr[indexPath.row] objectForKey:@"pic"]];
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4-1, 45);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
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
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    
    
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
