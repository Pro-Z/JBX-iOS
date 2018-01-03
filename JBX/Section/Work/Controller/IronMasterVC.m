//
//  IronMasterVC.m
//  JBX
//
//  Created by 证 on 2017/12/21.
//  Copyright © 2017年 证. All rights reserved.
//

#import "IronMasterVC.h"

@interface IronMasterVC ()
@property (nonatomic,strong) UIWebView *ironMasterView;
@property (nonatomic,assign) NSInteger type;
@end

@implementation IronMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DebugLog(@"加密的id%@",DEFAULTS_GET_OBJ(@"BASE64"));
    
    self.type = DEFAULTS_GET_INTEGER(@"WEBTYPE");
//    APP_IRON_MASETER_URL
    [self initNavigationView];
    
    [self initH5WebView];
}

- (void) initNavigationView {
    self.view.backgroundColor = [UIColor whiteColor];
    if (_type == 1) {
        self.title = @"钣金大师";
    }else if(_type == 2){
        self.title = @"资讯详情";
    }
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
}
- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// 初始化钣金大师
- (void) initH5WebView {
    self.ironMasterView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _ironMasterView.backgroundColor = [UIColor whiteColor];
    if (_type ==1) {
        //    _ironMasterView
        NSString *urlStr = [APP_IRON_MASETER_URL stringByAppendingString:DEFAULTS_GET_OBJ(@"BASE64")];
        NSURL *baseUrl = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:baseUrl];
        [_ironMasterView loadRequest:request];
    }else if(_type == 2){
        NSString *css = @"<head><style>img{max-width:340px !important;}</style></head>";
        [_ironMasterView loadHTMLString:[css stringByAppendingString:_content] baseURL:nil];
        
//        NSString *urlStr = [APP_IRON_MASETER_URL stringByAppendingString:DEFAULTS_GET_OBJ(@"BASE64")];
//        NSURL *baseUrl = [NSURL URLWithString:urlStr];
//        NSURLRequest *request = [NSURLRequest requestWithURL:baseUrl];
//        [_ironMasterView loadRequest:request];
    }
    [self.view addSubview:_ironMasterView];
    _weekSelf(weakSelf)
    [_ironMasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
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
