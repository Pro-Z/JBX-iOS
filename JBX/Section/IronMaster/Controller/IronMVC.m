//
//  IronMVC.m
//  JBX
//
//  Created by 证 on 2018/1/9.
//  Copyright © 2018年 证. All rights reserved.
//

#import "IronMVC.h"

@interface IronMVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *wkWebView;
@end

@implementation IronMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    [self initNavigationView];
    [self initWKWebView];
}

- (void) initNavigationView {
    self.title = @"钣金大师";
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

// 初始化wkwebview
- (void) initWKWebView {
    self.wkWebView = [WKWebView new];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    [self.view addSubview:_wkWebView];
    _weekSelf(weakSelf)
    [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(10);
        make.bottom.equalTo(weakSelf.view);
    }];
    NSString *nowTime = [NSDate initGetCurrentTime];
//    DebugLog("当前事件%@",nowTime);
    NSString *des = [desFile encryptWithText:[nowTime stringByAppendingString:@"73"]];
    NSString *base = [GTMBase64 encodeBase64String:des];
    NSString *urlStr = [APP_IRON_MASETER_URL stringByAppendingString:base];
    NSURL *baseUrl = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseUrl];
    [_wkWebView loadRequest:request];
}




- (void) goToBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark mark -- wkwebview的代理方法

/**
 开始加载网页
 
 @param webView webView description
 @param navigation navigation description
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [LWLoadingView showInView:self.view];
}

/**
 完成加载

 @param webView webView description
 @param navigation navigation description
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [LWLoadingView hideInViwe:self.view];
}


/**
 加载失败

 @param webView webView description
 @param navigation navigation description
 @param error error description
 */
//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    [LWLoadingView showError:error];
//}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
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
