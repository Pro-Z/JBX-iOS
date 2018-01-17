//
//  IronMasterVC.m
//  JBX
//
//  Created by 证 on 2017/12/21.
//  Copyright © 2017年 证. All rights reserved.
//

#import "IronMasterVC.h"


@interface IronMasterVC ()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *ironMasterView;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) WKWebView *wkWebView;
@end

@implementation IronMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DebugLog(@"加密的id%@",DEFAULTS_GET_OBJ(@"BASE64"));
    
    self.type = DEFAULTS_GET_INTEGER(@"WEBTYPE");
//    APP_IRON_MASETER_URL
    [self initNavigationView];
    
    if (_type == 1) {
        [self initWKWebView];
    }else if(_type == 2){
        [self initH5WebView];
    }
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

// 初始化wkwebview
- (void) initWKWebView {
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    
//    // 自适应屏幕宽度js
//
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//    // 添加自适应屏幕宽度js调用的方法
//
//    [wkUController addUserScript:wkUserScript];
//    
    
    self.wkWebView = [WKWebView new];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    [self.view addSubview:_wkWebView];
    _weekSelf(weakSelf)
    [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(10);
        make.right.equalTo(weakSelf.view).offset(-10);
        make.bottom.equalTo(weakSelf.view);
    }];
    if (_type ==1) {
        NSString *urlStr = [APP_IRON_MASETER_URL stringByAppendingString:DEFAULTS_GET_OBJ(@"BASE64")];
        NSURL *baseUrl = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:baseUrl];
        [_wkWebView loadRequest:request];
    }else if(_type == 2){
        
        
//        NSString *css = [NSString stringWithFormat:@"<html><head><style type=\"text/css\"> body {font-size:30px!important};img {width:100%%!important;}</style></head><body><script type='text/javascript'>window.onload = function(){var $img = document.getElementsByTagName('img');for(var p in  $img){$img[p].style.width = '100%%';$img[p].style.height ='auto'}</script>%@</body></html>",_content];
//        DebugLog(@"输出的html%@",css);
        
        
        [_wkWebView loadHTMLString:_content baseURL:nil];
    }
    
    
}
#pragma mark mark -- 初始化wkwebview的代理方法

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [LWLoadingView showInView:_wkWebView];
//    [ _wkWebView evaluateJavaScript:[NSString stringWithFormat:@"<html><head><style type=\"text/css\"> body {font-size:30px!important};img {width:100%%!important;}</style></head><body><script type='text/javascript'>window.onload = function(){var $img = document.getElementsByTagName('img');for(var p in  $img){$img[p].style.width = '100%%';$img[p].style.height ='auto'}</script>%@</body></html>",_content] completionHandler:nil];
    [ _wkWebView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#222222'" completionHandler:nil];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LWLoadingView hideInViwe:_wkWebView];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [LWLoadingView hideInViwe:_wkWebView];
}

#pragma mark mark -- webview

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [LWLoadingView showInView:_ironMasterView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [LWLoadingView hideInViwe:_ironMasterView];
}
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    // 图片缩放的js代码
//    NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=320;};window.alert('找到' + count + '张图');";
//    // 根据JS字符串初始化WKUserScript对象
//    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    [config.userContentController addUserScript:script];
//    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//    [_wkWebView loadHTMLString:_content baseURL:nil];
//    [self.view addSubview:_wkWebView];
//
//
//}






// 初始化钣金大师
- (void) initH5WebView {
    self.ironMasterView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _ironMasterView.backgroundColor = [UIColor whiteColor];
    _ironMasterView.delegate = self;
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
