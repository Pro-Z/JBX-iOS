//
//  WorkVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "WorkVC.h"
#import "WorkHeaderReusableView.h"
#import "WorkCollectionViewCell.h"
#import "WorkFooterReusableView.h"
#import "WorkWithBannerReusableView.h"
#import "IronMasterVC.h"

@interface WorkVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic,strong) UICollectionView *xCollectionView;
@property (nonatomic,copy) NSString *appName;
@end

@implementation WorkVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.appName = DEFAULTS_GET_OBJ(@"appname");
    if ([_appName isEqual:@""]) {
        self.navigationItem.title = COMPANY_NAME;
    }else{
        self.navigationItem.title = _appName;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initRightBarButton];
    // 初始化数据源
    [self initWorkDataSource];
    // 初始化collectionView
    [self initXCollectionView];
}

- (void) initRightBarButton {
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(jumpToLogin)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (void) jumpToLogin {
    LoginVC *loginVC = [LoginVC new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

// 初始化数据源
- (void) initWorkDataSource {
    self.dataArr = @[
                     @{
                         @"menuname":@"管理员控制台",
                         @"submenus":@[@{@"menuname":@"组织架构",@"picid":@"icon_org.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                       @{@"menuname":@"订单流转",@"picid":@"icon_cir.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                       @{@"menuname":@"移交管理",@"picid":@"icon_transfer.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                       @{@"menuname":@"管理工作台",@"picid":@"icon_Admin.png",@"URL":@"http://www.jubuxiu.com/GCGL/html/wap/gc/html/index.html"},
                                       ]
                      },
                     @{@"menuname":@"我常用的",
                       @"submenus":@[@{@"menuname":@"消息通知",@"picid":@"icon_notice.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"业务流转",@"picid":@"icon_business.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"交易管理",@"picid":@"icon_rec.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"钣金大师",@"picid":@"Shape.png",@"URL":@"http://www.jubuxiu.com/GCGL/html/wap/gc/html/index.html"},
                                     ]
                       },
                     @{@"menuname":@"业务汇报",
                       @"submenus":@[@{@"menuname":@"日报",@"picid":@"icon_day.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"周报",@"picid":@"icon_week.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"月报",@"picid":@"icon_mon.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     ]
                       },
                     @{@"menuname":@"客户/渠道管理",
                       @"submenus":@[@{@"menuname":@"客户",@"picid":@"icon_Customer.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"商机",@"picid":@"icon_bus.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"添加客户",@"picid":@"icon_addclient.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"拜访记录",@"picid":@"icon_visiting.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     ]
                       },
                     @{@"menuname":@"经营统计",
                       @"submenus":@[@{@"menuname":@"订单统计",@"picid":@"icon_ordersta.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"应收/实收统计",@"picid":@"icon_rec.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     ]
                       },
                     ];
}

- (void) initXCollectionView {
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_flowLayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
    _flowLayout.minimumLineSpacing = 0;
    self.xCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    self.xCollectionView.dataSource = self;
    self.xCollectionView.delegate = self;
    self.xCollectionView.backgroundColor = [UIColor whiteColor];
    [self.xCollectionView registerClass:[WorkHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headid"];
    [self.xCollectionView registerClass:[WorkFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerid"];
    [self.xCollectionView registerClass:[WorkCollectionViewCell class] forCellWithReuseIdentifier:@"WorkCollectionViewCell"];
    [self.xCollectionView registerClass:[WorkWithBannerReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannerhead"];
    
    self.xCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_xCollectionView];
    _weekSelf(weakSelf)
    [_xCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind==UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            WorkWithBannerReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannerhead" forIndexPath:indexPath];
            [reusableView setTitle:[[self.dataArr objectAtIndex:indexPath.section]objectForKey:@"menuname"]];
            return reusableView;
        }else{
            WorkHeaderReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headid" forIndexPath:indexPath];
            [reusableView setTitle:[[self.dataArr objectAtIndex:indexPath.section]objectForKey:@"menuname"]];
            return reusableView;
        }
        
        return nil;
    }
    if(kind == UICollectionElementKindSectionFooter){
        WorkFooterReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerid" forIndexPath:indexPath];
//        [reusableView setTitle:[[self.dataArr objectAtIndex:indexPath.section]objectForKey:@"menuname"]];
        
        return reusableView;
        
    }
    return nil;
}



#pragma mark -- UICollectionViewDataSource
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSInteger sizex = 0;
    if (section == 0) {
        sizex = 205;
    }else{
        sizex = 60;
    }
    CGSize size = {self.view.frame.size.width, sizex};
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    CGSize size = {self.view.frame.size.width, 10};

    return size;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[self.dataArr objectAtIndex:section] objectForKey:@"submenus"] count];
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
    
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"WorkCollectionViewCell";
    WorkCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *arr = [[self.dataArr objectAtIndex:indexPath.section]objectForKey:@"submenus"];
    [cell setWorkIcon:[[arr objectAtIndex:indexPath.row] objectForKey:@"picid"] withSubTitle:[[arr objectAtIndex:indexPath.row] objectForKey:@"menuname"]];
    return cell;
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
//同行cell之间的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/4-2, 69);;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0,0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"点击事件%ld+第几个%ld",indexPath.section, indexPath.row);
    // 跳转到组织架构
    if (indexPath.section == 0 && indexPath.row == 0) {
        OrganizeVC *organizeVC = [OrganizeVC new];
        organizeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:organizeVC animated:YES];
    }else if(indexPath.section == 1 && indexPath.row == 3){
        // 钣金大师
        NSString *nowTime = [NSDate initGetCurrentTime];
        DebugLog("当前事件%@",nowTime);
        
        NSString *des = [desFile encryptWithText:[nowTime stringByAppendingString:@"73"]];
        NSString *base = [GTMBase64 encodeBase64String:des];
        
        DebugLog(@"加密的数据为%@",base);
        DEFAULTS_SET_OBJ(base, @"BASE64");
        DEFAULTS_SET_INTEGER(1, @"WEBTYPE");
        IronMasterVC *ironMasterVC = [IronMasterVC new];
        ironMasterVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ironMasterVC animated:YES];
    }
//    HtmlWebViewController *hwvc = [[HtmlWebViewController alloc]init];
//    hwvc.hidesBottomBarWhenPushed = YES;
//    NSArray *arr = [[self.dataArr objectAtIndex:indexPath.section]objectForKey:@"submenus"];
//
//    hwvc.title = [[arr objectAtIndex:indexPath.row] objectForKey:@"menuname"];
//    [self.navigationController pushViewController:hwvc animated:YES];
//
//    [hwvc showUrl:[[arr objectAtIndex:indexPath.row] objectForKey:@"URL"]];
}



/**
 * 配置首页界面
 */
- (void)initView {
    
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
