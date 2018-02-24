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
#import "HomeListModel.h"
#import "SetOrganIDModel.h"
#import "ShopListCell.h"
#import "RealTradeView.h"
#import "AdverFootCell.h"
#import "TokenModel.h"
#import <CoreLocation/CoreLocation.h>
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

@interface WorkVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,CLLocationManagerDelegate,JFLocationDelegate, JFCityViewControllerDelegate>
// 定位功能
@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度
@property (nonatomic,strong) UILabel *locaLB;
@property (nonatomic, strong) JFLocation *jfLocationManager;// 城市定位管理器
@property (nonatomic, strong) JFAreaDataManager *manager;// 城市数据管理器
// 工作界面
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) UICollectionViewFlowLayout  *flowLayout;
@property (nonatomic,strong) UICollectionView *xCollectionView;
@property (nonatomic,copy) NSString *appName;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,strong) UILabel *backTxt;
@property (nonatomic,strong) NSString *state;
// 判断用户种类
@property (nonatomic,strong) HomeLoginModel *homeLoginModel;
@property (nonatomic,strong) HomeLoginDataModel *homeLoginDataModel;
@property (nonatomic,strong) HomeLoginOtherModel *homeLoginOtherModel;

// 商城界面
@property (nonatomic,strong) UITableView *hortoalTableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *itemViews;
@property (nonatomic,strong) NSArray *marketDataSource;

// 广告界面
@property (nonatomic,strong) UIView *adverHeaderView;
@property (nonatomic,strong) SDCycleScrollView *adverBanner;
@property (nonatomic,strong) UILabel *registerLB,*tradeLB,*orderLB,*newsLB;
@property (nonatomic,strong) UITableView *advertiseTableView;
@property (nonatomic,strong) UITableView *adverFooterTableView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) HomeAdvertiseDataModel *homeAdvertiseDataModel;
@property (nonatomic,strong) HomeAdvertiseBannerListModel *homeAdvertiseBannerListModel;
@property (nonatomic,strong) HomeAdvertiseRealListModel *homeAdvertiseRealListModel;
@property (nonatomic,strong) HomeAdvertiseOrgListModel *homeAdvertiseOrgListModel;
@property (nonatomic,strong) HomeAdvertiseModel *homeAdvertiseModel;
@property (nonatomic,strong) NSString *userTotal,*matchinfoTotal,*itemTotal,*informationTotal;
@property (nonatomic,strong) NSMutableArray *realDataSource;
@property (nonatomic,strong) NSMutableArray *orgDataSource;
@end


#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]
@implementation WorkVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initRightBarButton];

    [self initNavigationView];
//    [self initLocationView];
    [self initJFLocationView];
    // 用户角色通知中心
    [self initReceiveNotification];
    // 商城点击通知中心
    [self initShopNotificationView];
    // 先初始化登录状态,判断是 VIP用户还是普通用户(游客)
    [self initRefreshTokenData];
}


/**
 初始化定位服务
 */
- (void) initLocationView {
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
}

// 实现定位方法代理
#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    _locaLB.text = @"定位失败";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//    if (locationAge > 1.0){//如果调用已经一次，不再执行
//        return;
//    }
    // 判断是否定位成功
    if (![_locaLB.text isEqualToString:@"定位失败"] || ![_locaLB.text isEqualToString:@"城市定位"]) {
        return;
    }
    
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            if (!_currentCity) {
                _currentCity = @"定位失败";
            }
            //看需求定义一个全局变量来接收赋值
            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
            NSLog(@"当前城市 - %@",_currentCity);//当前城市
            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
            _locaLB.text = [NSString stringWithFormat:@"  %@",_currentCity];
            _locaLB.textAlignment = NSTextAlignmentLeft;
//            NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placeMark.country,_currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
//            [alert show];
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
}
// 第三方定位
- (void) initJFLocationView {
    self.jfLocationManager = [[JFLocation alloc] init];
    _jfLocationManager.delegate = self;
}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareInstance];
        [_manager areaSqliteDBData];
    }
    return _manager;
}
#pragma mark - JFCityViewControllerDelegate

- (void)cityName:(NSString *)name {
    _locaLB.text = name;
}

#pragma mark --- JFLocationDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    DebugLog(@"之前的城市为%@",city);
    if (![_locaLB.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self initLocationView];
            _locaLB.text = @"定位失败";
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _locaLB.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
    _locaLB.text = @"定位失败";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
    _locaLB.text = @"定位失败";
}


/**
 刷新用户信息
 */
- (void) initRefreshTokenData {
    self.isLogin = NO;
    NSString *userName = DEFAULTS_GET_OBJ(@"APP_USERNAME");
    NSString *passWord = DEFAULTS_GET_OBJ(@"APP_PAW");
    if (userName.length <= 0 || passWord.length <= 0) {
        // 通知首页未登录
        _isLogin = NO;
        [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
    }else {
//        NSDictionary *dict = @{
//                               @"userName":userName,
//                               @"password":passWord
//                               };
//        [[NetAPIManager sharedManager] request_common_WithPath:APP_LOGIN_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
//            self.homeLoginModel = [HomeLoginModel mj_objectWithKeyValues:data];
//            if (_homeLoginModel.code == 200) {
//                if (_homeLoginModel.otherData != NULL) {
//                    DebugLog(@"用户有组织");
////                    [self initRefreshOrginData];
//                    _isLogin = YES;
//                    [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
//                }else{
//                    DebugLog(@"用户无组织");
//                    _isLogin = NO;
//                    [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
//                }
//
//            }else{
//                DebugLog(@"用户无组织");
//                _isLogin = NO;
//                [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
//            }
//        } failue:^(id data, NSError *error) {
//            DebugLog(@"用户无组织");
//            _isLogin = NO;
//            [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
//        }];
        LoginModel *loginModel = [[LoginModel alloc] init];
        if ([userName isEqual: @"001"]) {
            loginModel.username = @"15539910985";
            loginModel.password = @"123456";
        }else{
            loginModel.username = userName;
            loginModel.password = passWord;
        }
        NSString *tips = [loginModel goToLoginModelWithCheck];
        if (tips) {
            [NSObject showHudTipStr:tips];
            return;
        }
        [[NetAPIManager sharedManager] request_Login_WithParams:loginModel successBlock:^(id data) {
            TokenModel *tokenModel = data;
            DebugLog(@"登陆的JSON--:%@",tokenModel);
            if (tokenModel.code == 200) {
                if (tokenModel.otherData != nil) {
                    DebugLog(@"用户有组织");
                    _isLogin = YES;
                    [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
                }else{
                    DebugLog(@"用户无组织");
                    _isLogin = NO;
                    [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
                }
            }else{
                DebugLog(@"用户无组织");
                _isLogin = NO;
                [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
            }
        } failure:^(id data, NSError *error) {
            DebugLog(@"登录失败!");
            DebugLog(@"用户无组织");
            _isLogin = NO;
            [NOTIFICATIONCENTER postNotification:NOTIFICATION(@"LOGIN", @{@"isLogin":@(_isLogin)})];
        }];
    }
    
}
// 默认给用户设置第一个组织机构
- (void) initRefreshOrginData{
    NSString *token = _homeLoginModel.data.token;
    NSMutableArray *orgList = [HomeLoginOtherModel mj_objectArrayWithKeyValuesArray:_homeLoginModel.otherData];
    self.homeLoginOtherModel = [HomeLoginOtherModel mj_objectWithKeyValues:orgList[0]];
    NSString *org_id = _homeLoginOtherModel.org_id;
    SetOrganIDModel *setOrgidModel = [SetOrganIDModel new];
    setOrgidModel.token = token;
    setOrgidModel.org_id = org_id;
    [[NetAPIManager sharedManager] request_SetOrgan_WithParams:setOrgidModel successBlock:^(id data) {
        BaseModel *requestModel = data;
        if (requestModel.code == 200) {
            [NSObject showHudTipStr:@"设置成功!"];
            DEFAULTS_SET_OBJ(org_id, @"org_id");
            
        }else{
            [NSObject showInfoHudTipStr:requestModel.msg];
        }
    } failure:^(id data, NSError *error) {
        
    }];
}

/**
 判断用户的通知
 */
- (void) initReceiveNotification {
    [NOTIFICATIONCENTER addObserver:self selector:@selector(isLoginAction:) name:@"LOGIN" object:nil];
}

// 接受通知来刷新界面
- (void) isLoginAction:(NSNotification *)loginStatue {
    DebugLog(@"是否登录%@",loginStatue.userInfo[@"isLogin"]);
    _state = [NSString stringWithFormat:@"%@",loginStatue.userInfo[@"isLogin"]];
    if ([_state isEqualToString:@"1"]) {
        // vip用户  SAS + 商城
        [self initWorkView];
    }else{
        // 普通用户  广告 + 商城
        [self initAdvertiseData];
        [self initAdvertisementView];
    }
    
}


/**
 通知点击商城的通知
 */
- (void) initShopNotificationView{
    [NOTIFICATIONCENTER addObserver:self selector:@selector(isShopClick:) name:@"SHOP" object:nil];
}
- (void) isShopClick:(NSNotification *)notice {
    DebugLog(@"是否点击商城%@",notice.userInfo[@"isShop"]);
    if ([notice.userInfo[@"isShop"] isEqualToString:@"商家"]) {
        // 显示商城的界面
        self.navigationItem.title = @"聚不锈云商城";
        if ([_state isEqualToString:@"1"]) {
            _backTxt.text = @"工作";
        }else{
            _backTxt.text = @"首页";
        }
        
        REMOVE_ALL_VIEW
        [self initMarketDataSource];
        [self initMarketTableviewHeader];
        [self initShopListView];
    }
}

- (void) initNavigationView {
    self.state = @"";
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.navigationItem.title = @"首页";
    self.navigationItem.hidesBackButton = YES;
    UIView *backView = [[UIView alloc] initWithFrame:VIEWFRAME(0, 0, 100, 44)];
    UIImageView *backPic = [UIImageView initWithImageViewWithFrame:VIEWFRAME(5, 14, 12, 16) withImageName:@""];
    self.backTxt = [[UILabel alloc] initWithFrame:VIEWFRAME(22, 0, 73, 44)];
    _backTxt.text = @"";
    _backTxt.textColor = [UIColor whiteColor];
    [backView addSubview:backPic];
    [backView addSubview:_backTxt];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToBack)];
    [backView addGestureRecognizer:tap];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // 地区选择按钮
    UIView *locationView = [[UIView alloc] initWithFrame:VIEWFRAME(SCREEN_WIDTH-80, 0, 80, 44)];
//    locationView.backgroundColor = [UIColor orangeColor];
    UIImageView *locationPic = [UIImageView initWithImageViewWithFrame:VIEWFRAME(10, 14, 12, 16) withImageName:@"icon_ad_loc"];
    self.locaLB = [[UILabel alloc] initWithFrame:VIEWFRAME(22, 0, 53, 44)];
    _locaLB.text = @"城市定位";
    _locaLB.textColor = [UIColor whiteColor];
    _locaLB.font = PINGFANG_FONT_SIZE(13);
    _locaLB.textAlignment = NSTextAlignmentRight;
    [locationView addSubview:locationPic];
    [locationView addSubview:_locaLB];
    locationView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operateBtn)];
    [locationView addGestureRecognizer:tap1];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:locationView];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_ad_switch"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
//    rightBtn.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = rightBtn;
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
//
//    [self.navigationItem.titleView setUserInteractionEnabled:YES];
//    UITapGestureRecognizer *tapx = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToLogin)];
//    [self.navigationItem.titleView addGestureRecognizer:tapx];
}

- (void) goToBack {
//    [self.navigationController popViewControllerAnimated:YES];
    if ([_backTxt.text isEqual:@"工作"]) {
        REMOVE_ALL_VIEW
        [self initWorkView];
    }else{
        REMOVE_ALL_VIEW
        [self initAdvertiseData];
        [self initAdvertisementView];
    }
    
}

- (void) operateBtn {
    DebugLog(@"地区选择界面");
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.delegate = self;
    cityViewController.title = @"城市";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

// 广告界面
- (void) initAdvertisementView{
    self.realDataSource = [NSMutableArray array];
    self.orgDataSource = [NSMutableArray array];
    self.navigationItem.title = @"聚不锈云平台";
    _backTxt.text = @"";
    [self initAdvertiseHeaderView];
    [self initAdvertiseFooterView];
    [self initAdvertiseTableView];
}


/**
 广告统计数据
 */
- (void) initAdvertiseData {
    _weekSelf(weakSelf);
    [[NetAPIManager sharedManager] request_common_WithPath:APP_ADVERTISE_LIST_URL Params:nil autoShowProgressHUD:NO typeGets:NO succesBlack:^(id data) {
        self.homeAdvertiseModel = [HomeAdvertiseModel mj_objectWithKeyValues:data];
        if (_homeAdvertiseModel.code == 200) {
            // 轮播图
            NSArray *arr = [HomeAdvertiseBannerListModel mj_objectArrayWithKeyValuesArray:_homeAdvertiseModel.data.top_pic_list];
            NSMutableArray *picArr = [NSMutableArray array];
            
            for (int i = 0; i<arr.count; i++) {
                self.homeAdvertiseBannerListModel = [HomeAdvertiseBannerListModel mj_objectWithKeyValues:arr[i]];
                [picArr addObject:_homeAdvertiseBannerListModel.picUrl];
            }
            _adverBanner.imageURLStringsGroup = picArr;
            
            // 统计模块
            _registerLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseModel.data.userTotal];
            _tradeLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseModel.data.itemTotal];
            _orderLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseModel.data.matchinfoTotal];
            _newsLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseModel.data.informationTotal];
            
            
            
            // 实时交易
            if (_realDataSource != nil) {
                [_realDataSource removeAllObjects];
            }
            _realDataSource = [NSMutableArray arrayWithArray:_homeAdvertiseModel.data.realtimeList];
            [weakSelf.advertiseTableView reloadData];
            
            // 商家列表
            if (_orgDataSource != nil) {
                [_orgDataSource removeAllObjects];
            }
            _orgDataSource = [NSMutableArray arrayWithArray:_homeAdvertiseModel.data.orgList];
            [weakSelf.adverFooterTableView reloadData];
            
//            CGFloat height = [weakSelf.footView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            CGRect frame = weakSelf.footView.bounds;
            frame.size.height = _orgDataSource.count*120+80;
            weakSelf.footView.frame = frame;
            [weakSelf.advertiseTableView setTableFooterView:weakSelf.footView];
            
            
        }else{
            
        }
    } failue:^(id data, NSError *error) {
        
    }];
}

// header
- (void) initAdvertiseHeaderView{
    _weekSelf(weakSelf);
    self.adverHeaderView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
//    [self.view addSubview:_adverHeaderView];
//    [_adverHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view).offset(0);
//        make.left.equalTo(weakSelf.view).offset(0);
//        make.right.equalTo(weakSelf.view).offset(0);
//        make.bottom.equalTo(weakSelf.view);
//    }];
    
    self.adverBanner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_icon"]];
    //        self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.adverBanner.currentPageDotColor = APP_COLOR_BASE_NAV;
    self.adverBanner.pageDotColor = [UIColor whiteColor];
    self.adverBanner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [_adverHeaderView addSubview:_adverBanner];
    [_adverBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.adverHeaderView).offset(0);
        make.left.equalTo(weakSelf.adverHeaderView).offset(0);
        make.right.equalTo(weakSelf.adverHeaderView).offset(0);
        make.height.equalTo(@150);
    }];
    
    UIView *firstView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    
    [_adverHeaderView addSubview:firstView];
    
    UIView *secondView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    
    [_adverHeaderView addSubview:secondView];
    
    UIView *threeView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    
    [_adverHeaderView addSubview:threeView];
    
    UIView *fourView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    
    [_adverHeaderView addSubview:fourView];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.adverBanner.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.adverHeaderView).offset(20);
        make.right.equalTo(secondView.mas_left).offset(-10);
        make.width.equalTo(secondView);
        make.height.equalTo(@44);
    }];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.adverBanner.mas_bottom).offset(20);
        make.left.equalTo(firstView.mas_right).offset(10);
        make.right.equalTo(weakSelf.adverHeaderView).offset(-20);
        make.height.equalTo(firstView);
    }];
    [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.adverHeaderView).offset(20);
        make.right.equalTo(fourView.mas_left).offset(-10);
        make.width.equalTo(fourView);
        make.height.equalTo(firstView);
    }];
    [fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_bottom).offset(20);
        make.left.equalTo(threeView.mas_right).offset(10);
        make.right.equalTo(weakSelf.adverHeaderView).offset(-20);
        make.height.equalTo(firstView);
    }];
    // 注册人数
    UIImageView *firstPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                            withImageName:@"icon_ad_reg"];
    [firstView addSubview:firstPic];
    
    [firstPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(firstView.mas_centerX).offset(-30);
        make.centerY.equalTo(firstView.mas_centerY).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    UILabel *firstTxt = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"注册用户"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [firstView addSubview:firstTxt];
    [firstTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView).offset(0);
        make.left.equalTo(firstPic.mas_right).offset(5);
        make.right.equalTo(firstView).offset(-10);
    }];
    self.registerLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"0"
                                                  withTextColor:RGBA(3, 115, 228, 1)
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [_registerLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [firstView addSubview:_registerLB];
    [_registerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(firstView.mas_bottom).offset(0);
        make.left.equalTo(firstPic.mas_right).offset(5);
//        make.right.equalTo(firstView).offset(-25);
    }];
    UILabel *firTxt = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"人"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentCenter];
    [firstView addSubview:firTxt];
    [firTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(firstView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.registerLB.mas_right).offset(0);
        make.right.equalTo(firstView.mas_right).offset(-10);
    }];
    
    
    // 交易笔数
    UIImageView *secondPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                      withImageName:@"icon_ad_Num"];
    [secondView addSubview:secondPic];
    
    [secondPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(secondView.mas_centerX).offset(-30);
        make.centerY.equalTo(secondView.mas_centerY).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    UILabel *secondTxt = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"交易笔数"
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
    [secondView addSubview:secondTxt];
    [secondTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView).offset(0);
        make.left.equalTo(secondPic.mas_right).offset(5);
        make.right.equalTo(secondView).offset(-10);
    }];
    self.tradeLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"0"
                                      withTextColor:RGBA(3, 115, 228, 1)
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [_tradeLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [secondView addSubview:_tradeLB];
    [_tradeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secondView.mas_bottom).offset(0);
        make.left.equalTo(secondPic.mas_right).offset(5);
    }];
    UILabel *secTxt = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"笔"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentCenter];
    [secondView addSubview:secTxt];
    [secTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secondView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.tradeLB.mas_right).offset(0);
        make.right.equalTo(secondView.mas_right).offset(-10);
    }];
    
    // 加工单数
    UIImageView *threePic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                       withImageName:@"icon_ad_mac"];
    [threeView addSubview:threePic];
    
    [threePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(threeView.mas_centerX).offset(-30);
        make.centerY.equalTo(threeView.mas_centerY).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    UILabel *threeTxt = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"撮合信息"
                                         withTextColor:[UIColor blackColor]
                                              withFont:PINGFANG_FONT_SIZE(14)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [threeView addSubview:threeTxt];
    [threeTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(threeView).offset(0);
        make.left.equalTo(threePic.mas_right).offset(5);
        make.right.equalTo(threeView).offset(-10);
    }];
    self.orderLB = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"0"
                                   withTextColor:RGBA(3, 115, 228, 1)
                                        withFont:PINGFANG_FONT_SIZE(14)
                                     withGbColor:[UIColor whiteColor]
                               withTextAlignment:NSTextAlignmentLeft];
    [_orderLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [threeView addSubview:_orderLB];
    [_orderLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(threeView.mas_bottom).offset(0);
        make.left.equalTo(threePic.mas_right).offset(5);
//        make.right.equalTo(threeView).offset(-25);
    }];
    UILabel *thrTxt = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"个"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentCenter];
    [threeView addSubview:thrTxt];
    [thrTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(threeView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.orderLB.mas_right).offset(0);
        make.right.equalTo(threeView.mas_right).offset(-10);
    }];
    
    // 平台咨询
    UIImageView *fourPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                      withImageName:@"icon_ad_infor"];
    [fourView addSubview:fourPic];
    
    [fourPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fourView.mas_centerX).offset(-30);
        make.centerY.equalTo(fourView.mas_centerY).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    UILabel *fourTxt = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"平台资讯"
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
    [fourView addSubview:fourTxt];
    [fourTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fourView).offset(0);
        make.left.equalTo(fourPic.mas_right).offset(5);
        make.right.equalTo(fourView).offset(-10);
    }];
    self.newsLB = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"0"
                                   withTextColor:RGBA(3, 115, 228, 1)
                                        withFont:PINGFANG_FONT_SIZE(14)
                                     withGbColor:[UIColor whiteColor]
                               withTextAlignment:NSTextAlignmentLeft];
    [_newsLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [fourView addSubview:_newsLB];
    [_newsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fourView.mas_bottom).offset(0);
        make.left.equalTo(fourPic.mas_right).offset(5);
//        make.right.equalTo(fourView).offset(-25);
    }];
    UILabel *fouTxt = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"条"
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentCenter];
    [fourView addSubview:fouTxt];
    [fouTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fourView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.newsLB.mas_right).offset(0);
        make.right.equalTo(fourView.mas_right).offset(-10);
    }];
    
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.adverHeaderView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(threeView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.adverHeaderView).offset(0);
        make.right.equalTo(weakSelf.adverHeaderView).offset(0);
        make.height.equalTo(@10);
    }];
    
    UILabel *realTradeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"实时交易"
                                                  withTextColor:RGBA(3, 115, 228, 1)
                                                       withFont:PINGFANG_FONT_SIZE(16)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentCenter];
    [self.adverHeaderView addSubview:realTradeLB];
    [realTradeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.centerX.equalTo(weakSelf.adverHeaderView.mas_centerX).offset(0);
    }];
    UIImageView *xie = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                            withImageName:@"icon_ad_xie"];
    [self.adverHeaderView addSubview:xie];
    
    [xie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(realTradeLB.mas_centerY).offset(0);
        make.right.equalTo(realTradeLB.mas_left).offset(-10);
        make.height.equalTo(@7);
        make.width.equalTo(@9);
    }];
    UIImageView *xie1 = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                 withImageName:@"icon_ad_xie"];
    [self.adverHeaderView addSubview:xie1];
    
    [xie1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(realTradeLB.mas_centerY).offset(0);
        make.left.equalTo(realTradeLB.mas_right).offset(10);
        make.height.equalTo(@7);
        make.width.equalTo(@9);
    }];
    UIView *lineView1 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.adverHeaderView addSubview:lineView1];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realTradeLB.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.adverHeaderView).offset(16);
        make.right.equalTo(weakSelf.adverHeaderView).offset(-16);
        make.height.equalTo(@1);
    }];
    UILabel *nameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"商家名称"
                                                  withTextColor:RGBA(102, 102, 102, 1)
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentCenter];
    [_adverHeaderView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(14);
        make.left.equalTo(weakSelf.adverHeaderView.mas_left).offset(16);
        make.width.equalTo(@((SCREEN_WIDTH-32)/6*2));
    }];
    
    UILabel *orderCountLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"加工单个数"
                                      withTextColor:RGBA(102, 102, 102, 1)
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentCenter];
    [_adverHeaderView addSubview:orderCountLB];
    [orderCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(14);
        make.left.equalTo(nameLB.mas_right).offset(0);
        make.width.equalTo(@((SCREEN_WIDTH-32)/6*2));
    }];
    UILabel *sumLB = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@""
                                            withTextColor:RGBA(102, 102, 102, 1)
                                                 withFont:PINGFANG_FONT_SIZE(14)
                                              withGbColor:[UIColor whiteColor]
                                        withTextAlignment:NSTextAlignmentCenter];
    
    [_adverHeaderView addSubview:sumLB];
    [sumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(14);
        make.left.equalTo(orderCountLB.mas_right).offset(0);
        make.width.equalTo(@((SCREEN_WIDTH-32)/6*1.5));
    }];
    
    UIView *lineView3 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [_adverHeaderView addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.adverHeaderView).offset(0);
        make.right.equalTo(weakSelf.adverHeaderView).offset(0);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.adverHeaderView);
    }];
    // 动态设置header高度
    CGFloat height = [weakSelf.adverHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = weakSelf.adverHeaderView.bounds;
    frame.size.height = height;
    weakSelf.adverHeaderView.frame = frame;
    [weakSelf.advertiseTableView setTableHeaderView:weakSelf.adverHeaderView];
    
}

// footer
- (void) initAdvertiseFooterView{
    _weekSelf(weakSelf);
    self.footView = [UIView initWithUIViewWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, 300) withBackground:[UIColor whiteColor]];
    
    UILabel *realTradeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                withText:@"平台商家"
                                           withTextColor:RGBA(3, 115, 228, 1)
                                                withFont:PINGFANG_FONT_SIZE(16)
                                             withGbColor:[UIColor whiteColor]
                                       withTextAlignment:NSTextAlignmentCenter];
    [self.footView addSubview:realTradeLB];
    [realTradeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.footView).offset(15);
        make.centerX.equalTo(weakSelf.footView.mas_centerX).offset(0);
    }];
    UIImageView *xie = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                 withImageName:@"icon_ad_xie"];
    [self.footView addSubview:xie];
    
    [xie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(realTradeLB.mas_centerY).offset(0);
        make.right.equalTo(realTradeLB.mas_left).offset(-10);
        make.height.equalTo(@7);
        make.width.equalTo(@9);
    }];
    UIImageView *xie1 = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                  withImageName:@"icon_ad_xie"];
    [self.footView addSubview:xie1];
    
    [xie1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(realTradeLB.mas_centerY).offset(0);
        make.left.equalTo(realTradeLB.mas_right).offset(10);
        make.height.equalTo(@7);
        make.width.equalTo(@9);
    }];
    UIView *lineView1 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.footView addSubview:lineView1];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realTradeLB.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.footView).offset(16);
        make.right.equalTo(weakSelf.footView).offset(-16);
        make.height.equalTo(@1);
    }];
    self.adverFooterTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _adverFooterTableView.delegate =self;
    _adverFooterTableView.dataSource = self;
    _adverFooterTableView.userInteractionEnabled = NO;
//    _adverFooterTableView.estimatedRowHeight = 60;
//    _adverFooterTableView.rowHeight = UITableViewAutomaticDimension;
    [_adverFooterTableView registerClass:[AdverFootCell class] forCellReuseIdentifier:@"footTab"];
    [_footView addSubview:_adverFooterTableView];
    [_adverFooterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.footView);
        make.right.equalTo(weakSelf.footView);
//        make.height.equalTo(@(60*_orgDataSource.count));
//        make.bottom.equalTo(weakSelf.footView);
    }];
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.footView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.adverFooterTableView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.footView).offset(0);
        make.right.equalTo(weakSelf.footView).offset(0);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.footView);
    }];
    
    
//    // 动态设置header高度
//    CGFloat height = [weakSelf.footView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    CGRect frame = weakSelf.footView.bounds;
//    frame.size.height = height;
//    weakSelf.footView.frame = frame;
//    [weakSelf.advertiseTableView setTableFooterView:weakSelf.footView];
//    [_footView layoutIfNeeded];
    
}

- (void) initAdvertiseTableView {
    self.advertiseTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _advertiseTableView.delegate =self;
    _advertiseTableView.dataSource = self;
    [self.view addSubview:_advertiseTableView];
    _advertiseTableView.tableHeaderView = _adverHeaderView;
    [_advertiseTableView layoutIfNeeded];
    _advertiseTableView.tableFooterView = _footView;
    [_advertiseTableView registerClass:[RealTradeView class] forCellReuseIdentifier:@"cellid"];
    _weekSelf(weakSelf)
    [_advertiseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}



/**
 初始化工作模块的界面和数据源
 */
// SAS界面
- (void) initWorkView {
    self.navigationItem.title = @"聚不锈云服务";
    _backTxt.text = @"";
    // 初始化数据源
    [self initWorkDataSource];
    // 初始化collectionView
    [self initXCollectionView];
}
// 初始化数据源
- (void) initWorkDataSource {
    self.dataArr = @[
//                     @{
//                         @"menuname":@"管理员控制台",
//                         @"submenus":@[@{@"menuname":@"组织架构",@"picid":@"icon_org.png",@"URL":@"http://106.14.154.136:8080/webapp"},
//                                       @{@"menuname":@"订单流转",@"picid":@"icon_cir.png",@"URL":@"http://106.14.154.136:8080/webapp"},
//                                       @{@"menuname":@"移交管理",@"picid":@"icon_transfer.png",@"URL":@"http://106.14.154.136:8080/webapp"},
//                                       @{@"menuname":@"管理工作台",@"picid":@"icon_Admin.png",@"URL":@"http://www.jubuxiu.com/GCGL/html/wap/gc/html/index.html"},
//                                       ]
//                      },
                     @{@"menuname":@"我常用的",
                       @"submenus":@[@{@"menuname":@"消息通知",@"picid":@"icon_notice.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"业务流转",@"picid":@"icon_business.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"交易管理",@"picid":@"icon_rec.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"钣金大师",@"picid":@"Shape.png",@"URL":@"http://www.jubuxiu.com/GCGL/html/wap/gc/html/index.html"},
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
                                     @{@"menuname":@"应收统计",@"picid":@"icon_rec.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"实收统计",@"picid":@"icon_rec.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     ]
                       },
                     @{@"menuname":@"业务汇报",
                       @"submenus":@[@{@"menuname":@"日报",@"picid":@"icon_day.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"周报",@"picid":@"icon_week.png",@"URL":@"http://106.14.154.136:8080/webapp"},
                                     @{@"menuname":@"月报",@"picid":@"icon_mon.png",@"URL":@"http://106.14.154.136:8080/webapp"},
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *obj = [[self.dataArr objectAtIndex:section] objectForKey:@"submenus"];
    return [obj count];
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
//    // 跳转到组织架构
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        OrganizeVC *organizeVC = [OrganizeVC new];
//        organizeVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:organizeVC animated:YES];
//    }else if(indexPath.section == 1 && indexPath.row == 3){
//        // 钣金大师
//        NSString *nowTime = [NSDate initGetCurrentTime];
//        DebugLog("当前事件%@",nowTime);
//
//        NSString *des = [desFile encryptWithText:[nowTime stringByAppendingString:@"73"]];
//        NSString *base = [GTMBase64 encodeBase64String:des];
//
//        DebugLog(@"加密的数据为%@",base);
//        DEFAULTS_SET_OBJ(base, @"BASE64");
//        DEFAULTS_SET_INTEGER(1, @"WEBTYPE");
//        IronMasterVC *ironMasterVC = [IronMasterVC new];
//        ironMasterVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ironMasterVC animated:YES];
//    }
////    HtmlWebViewController *hwvc = [[HtmlWebViewController alloc]init];
////    hwvc.hidesBottomBarWhenPushed = YES;
////    NSArray *arr = [[self.dataArr objectAtIndex:indexPath.section]objectForKey:@"submenus"];
////
////    hwvc.title = [[arr objectAtIndex:indexPath.row] objectForKey:@"menuname"];
////    [self.navigationController pushViewController:hwvc animated:YES];
////
////    [hwvc showUrl:[[arr objectAtIndex:indexPath.row] objectForKey:@"URL"]];
}



/**
 商城模块的界面和数据源
 */
// 初始化数据源
- (void) initMarketDataSource {
    self.marketDataSource = @[
                     @{
                         @"menuname":@"今日现货",
                         @"menupic":@"shop_tit_spot"
                         },
                     @{
                         @"menuname":@"优质供应商",
                         @"menupic":@"shop_tit_sup"
                         },
                     @{
                         @"menuname":@"优质加工商",
                         @"menupic":@"shop_tab_con"
                         }
                     ];
}

// 初始化tableview header
- (void) initMarketTableviewHeader {
    self.itemViews = [[NSMutableArray alloc] init];
    self.headerView = [UIView initWithUIViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) withBackground:RGBA(242, 242, 242, 1)];
    // 初始化三个item
    NSArray *iconArr = @[@"shop_tab_spot",@"shop_tab_sup",@"shop_tab_conx"];
    NSArray *titleArr = @[@"找现货",@"找供应商",@"找加工商"];
    for (int i = 0; i<iconArr.count; i++) {
        UIView *views = [UIView initWithUIViewWithFrame:CGRectMake(i*SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 110) withBackground:[UIColor whiteColor]];
        views.tag = i;
        views.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleItem:)];
        [views addGestureRecognizer:tapGes];
        UIImageView *itemPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:iconArr[i]];
        UILabel *titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                   withText:titleArr[i]
                                              withTextColor:RGBA(34, 34, 34, 1)
                                                   withFont:PINGFANG_FONT_SIZE(15)
                                                withGbColor:[UIColor whiteColor]
                                          withTextAlignment:NSTextAlignmentCenter];
        [views addSubview:itemPic];
        [views addSubview:titleLabel];
        
        [itemPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(views).offset(35);
            make.centerX.equalTo(views.mas_centerX).offset(0);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(itemPic.mas_bottom).offset(15);
            make.centerX.equalTo(views.mas_centerX).offset(0);
        }];
        
        //        [_itemViews addObject:views];
        [_headerView addSubview:views];
    }
    //    [_headerView addSubview:views];
}

// UIView的点击事件
-(void) handleItem: (id) sender{
    UITapGestureRecognizer *tapClick = (UITapGestureRecognizer *)sender;
    DebugLog(@"点击了第几个%ld",(long)[tapClick view].tag);
}

// 初始化商品界面
- (void) initShopListView {
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.conte
    self.hortoalTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _hortoalTableView.delegate = self;
    _hortoalTableView.dataSource = self;
    [_hortoalTableView registerClass:[ShopListCell class] forCellReuseIdentifier:@"ShopListCell"];
    _hortoalTableView.tableHeaderView = _headerView;
    [self.view addSubview:_hortoalTableView];
    _weekSelf(weakSelf)
    [_hortoalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.view).offset(0);
        make.leftMargin.equalTo(weakSelf.view).offset(0);
        make.rightMargin.equalTo(weakSelf.view).offset(0);
        make.bottomMargin.equalTo(weakSelf.view).offset(0);
    }];
}

#pragma mark - 初始化tableview的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_advertiseTableView]) {
        return 5;
    }else if([tableView isEqual:_hortoalTableView]){
        return 3;
    }else if ([tableView isEqual:_adverFooterTableView]){
        return _orgDataSource.count;
    }
    return 0;
}
#pragma mark - 初始化tableview的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    if ([tableView isEqual:_advertiseTableView]) {
        RealTradeView *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        if (_realDataSource.count != 0) {
            self.homeAdvertiseRealListModel = [HomeAdvertiseRealListModel mj_objectWithKeyValues:_realDataSource[indexPath.row]];
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = RGBA(241, 241, 241, 1);
                cell.nameLB.backgroundColor = RGBA(241, 241, 241, 1);
                cell.numberLB.backgroundColor = RGBA(241, 241, 241, 1);
                cell.timeLB.backgroundColor = RGBA(241, 241, 241, 1);
            }else{
                cell.backgroundColor = [UIColor whiteColor];
                cell.nameLB.backgroundColor = [UIColor whiteColor];
                cell.numberLB.backgroundColor = [UIColor whiteColor];
                cell.timeLB.backgroundColor = [UIColor whiteColor];
            }
            cell.nameLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseRealListModel.org_name];
            cell.numberLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseRealListModel.count];
            cell.timeLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseRealListModel.create_ts];
        }
        
        
        return cell;
    }else if([tableView isEqual:_hortoalTableView]){
        ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        NSString *arr = [[self.marketDataSource objectAtIndex:indexPath.row]objectForKey:@"menuname"];
        NSString *arrPic = [[self.marketDataSource objectAtIndex:indexPath.row]objectForKey:@"menupic"];
        //    DebugLog(@"遍历%@",[arr objectAtIndex:indexPath.row]);
        
        if (indexPath.row == 0) {
            NSArray *firstPic = @[@"xianhuo1",@"xianhuo2",@"xianhuo3"
                                  ,@"xianhuo4",@"xianhuo5",@"xianhuo6"];
            NSArray *firstTxt = @[@"201不锈钢板",@"不锈钢方管",@"304不锈钢板",
                                  @"不锈钢圆管",@"不锈钢圆管",@"不锈钢卷"];
            NSArray *firstPrice = @[@"¥ 16.8/kg",@"¥ 10.0/kg",@"¥ 16.9/kg",
                                    @"¥ 18.7/kg",@"¥ 16.0/kg",@"¥ 16.8/kg"];
            [cell setFirstTxt:arr  withFirstPic:arrPic withFirstPic:firstPic withFirstTxt:firstTxt withFirstPrice:firstPrice];
        }else if (indexPath.row == 1){
            NSArray *firstPic = @[@"shangjia1",@"shangjia2",@"shangjia3"
                                  ,@"shangjia4",@"shangjia5",@"shangjia6"];
            NSArray *firstTxt = @[@"金龙不锈钢",@"双兴隆顺不锈钢",@"鑫利恒不锈钢",@"宏昌烨不锈钢",
                                  @"兴伟企业",@"鑫晨不锈钢"];
            NSArray *firstPrice = @[@"",@"",@"",@"",@"",@""];
            [cell setFirstTxt:arr  withFirstPic:arrPic withFirstPic:firstPic withFirstTxt:firstTxt withFirstPrice:firstPrice];
        }else if (indexPath.row == 2){
            NSArray *firstPic = @[@"shang1",@"shang2",@"shang3"
                                  ,@"shang4",@"shang5",@"shang6"];
            NSArray *firstTxt = @[@"金顺不锈钢",@"奥胜火不锈钢",@"华业不锈钢",@"金润德不锈钢",
                                  @"铭一不锈钢",@"天仁不锈钢"];
            NSArray *firstPrice = @[@"",@"",@"",@"",@"",@""];
            [cell setFirstTxt:arr  withFirstPic:arrPic withFirstPic:firstPic withFirstTxt:firstTxt withFirstPrice:firstPrice];
        }
        
        
        //    cell.textLabel.text = @"测试";
        return cell;
    }else if([tableView isEqual:_adverFooterTableView]){
        AdverFootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footTab" forIndexPath:indexPath];
        self.homeAdvertiseOrgListModel = [HomeAdvertiseOrgListModel mj_objectWithKeyValues:_orgDataSource[indexPath.row]];
        cell.nameLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseOrgListModel.name];
        cell.addressLB.text = [NSString stringWithFormat:@"%@",_homeAdvertiseOrgListModel.address];
        NSString *person = @"";
        if (_homeAdvertiseOrgListModel.contact_person == nil) {
            person = @"暂无";
        }else{
            person = _homeAdvertiseOrgListModel.contact_person;
        }
        NSString *phone = @"";
        if (_homeAdvertiseOrgListModel.shop_phone == nil) {
            phone = @"暂无";
        }else{
            phone = _homeAdvertiseOrgListModel.shop_phone;
        }
        cell.contactLB.text = [NSString stringWithFormat:@"%@    %@",person,phone];
        NSString *picUrl = [NSString stringWithFormat:@"%@",_homeAdvertiseOrgListModel.logo];
        [cell.pic sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"placerholder"]];
        
        
        return cell;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_advertiseTableView]) {
        return 32;
    }else if([tableView isEqual:_hortoalTableView]){
        return 251;
    }else if ([tableView isEqual:_adverFooterTableView]){
        return 120;
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
