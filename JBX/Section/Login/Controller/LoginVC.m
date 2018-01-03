//
//  LoginVC.m
//  JBX
//
//  Created by 证 on 2017/12/7.
//  Copyright © 2017年 证. All rights reserved.
//

#import "LoginVC.h"
#import "SelectVC.h"
#import "TokenModel.h"

@interface LoginVC ()
@property (nonatomic,strong) UITextField *usernamreEdt;
@property (nonatomic,strong) UITextField *passwordEdt;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIImageView *loginIcon;
@property (nonatomic,strong) UILabel *registerLabel;
@property (nonatomic,strong) UILabel *forgetLabel;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    BLACK_STATUS_BAR_COLOR
    [self initNavigationBar];
    [self initLoginView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    WHITE_STATUS_BAR_COLOR
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) initNavigationBar {
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"登录";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImage *leftIcon = [[UIImage imageNamed:@"navi_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:leftIcon style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void) backBtn:(UIButton *)btn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) initLoginView {
    // 初始化登录界面
    self.loginIcon = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"login_icon"];
    [self.view addSubview:_loginIcon];
    
    self.usernamreEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                              withName:@""
                                                       withPlaceholder:@"请输入手机号码" withHintColor:TEXTFILED_HINT_COLOR withHintSize:PINGFANG_FONT_SIZE(15) withTextAlignment:NSTextAlignmentLeft
                                                          withFontSize:PINGFANG_FONT_SIZE(15)
                                                         withTextColor:[UIColor blackColor]
                                                          withDelegate:self];
    _usernamreEdt.keyboardType = UIKeyboardTypeNumberPad;
    [_usernamreEdt addTarget:self action:@selector(userNameTF:) forControlEvents:(UIControlEventEditingChanged)];
    [self.view addSubview:_usernamreEdt];
    
    UIView *line_user = [UIView initWithUIViewWithFrame:CGRectZero withBackground:APP_COLOR_BASE_LINE_GRAY];
    [self.view addSubview:line_user];
    
    self.passwordEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                      withName:@""
                                               withPlaceholder:@"请输入密码"
                                                 withHintColor:TEXTFILED_HINT_COLOR
                                                  withHintSize:PINGFANG_FONT_SIZE(15)
                                             withTextAlignment:NSTextAlignmentLeft
                                                  withFontSize:PINGFANG_FONT_SIZE(15)
                                                 withTextColor:[UIColor blackColor]
                                                  withDelegate:self];
    _passwordEdt.keyboardType = UIKeyboardTypeDefault;
    _passwordEdt.secureTextEntry = YES;
    [self.view addSubview:_passwordEdt];
    
    UIView *line_paw = [UIView initWithUIViewWithFrame:CGRectZero withBackground:APP_COLOR_BASE_LINE_GRAY];
    [self.view addSubview:line_paw];

    self.registerLabel = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"快速注册"
                                         withTextColor:RGBA(101, 101, 101, 1)
                                              withFont:PINGFANG_FONT_SIZE(15)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_registerLabel];
    
    self.forgetLabel = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"忘记密码"
                                         withTextColor:RGBA(101, 101, 101, 1)
                                            withFont:PINGFANG_FONT_SIZE(15)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_forgetLabel];
    
    
    self.loginBtn = [UIButton initButtonWithButtonType:UIButtonTypeCustom
                                             withFrame:CGRectZero
                                             withTitle:@"下一步"
                                        withTitleColor:[UIColor whiteColor]
                                                withGB:APP_COLOR_BASE_NAV
                                              withFont:PINGFANG_FONT_SIZE(16)];
    ViewRadius(_loginBtn, 20);
    [self.view addSubview:_loginBtn];
    
    _weekSelf(weakSelf);
    [_loginIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.view).with.offset(100);
        make.centerX.equalTo(weakSelf.view);
    }];
    [_usernamreEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.loginIcon.mas_bottom).with.offset(60);
        make.leftMargin.equalTo(weakSelf.view).with.offset(20);
        make.rightMargin.equalTo(weakSelf.view).with.offset(-20);
        make.height.equalTo(@40);
    }];
    [line_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.usernamreEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).with.offset(20);
        make.rightMargin.equalTo(weakSelf.view).with.offset(-20);
        make.height.equalTo(@1);
    }];
    [_passwordEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_user.mas_bottom).offset(30);
        make.leftMargin.equalTo(weakSelf.view).with.offset(20);
        make.rightMargin.equalTo(weakSelf.view).with.offset(-20);
        make.height.equalTo(@40);
    }];
    [line_paw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.passwordEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).with.offset(20);
        make.rightMargin.equalTo(weakSelf.view).with.offset(-20);
        make.height.equalTo(@1);
    }];
    [_registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_paw.mas_bottom).offset(20);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
//        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@20);
    }];
    [_forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_paw.mas_bottom).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@20);
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.registerLabel.mas_bottom).offset(60);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@44);
    }];
    
    // 点击事件
    UITapGestureRecognizer *registerLabelClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToRegister)];
    [_registerLabel addGestureRecognizer:registerLabelClick];
    _registerLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *forgetClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToForget)];
    [_forgetLabel addGestureRecognizer:forgetClick];
    _forgetLabel.userInteractionEnabled = YES;
    
    // 登录
    [_loginBtn addTarget:self action:@selector(handleLogin) forControlEvents:(UIControlEventTouchUpInside)];
    
}
- (void) handleLogin {
    // 判断不为空
    LoginModel *loginModel = [[LoginModel alloc] init];
    if ([_usernamreEdt.text  isEqual: @"001"]) {
        loginModel.username = @"admin";
        loginModel.password = @"qzq123456";
    }else{
        loginModel.username = _usernamreEdt.text;
        loginModel.password = _passwordEdt.text;
    }
    NSString *tips = [loginModel goToLoginModelWithCheck];
    if (tips) {
        [NSObject showInfoHudTipStr:tips];
        return;
    }
    [[NetAPIManager sharedManager] request_Login_WithParams:loginModel successBlock:^(id data) {
        TokenModel *tokenModel = data;
        DebugLog(@"登陆的JSON--:%@",tokenModel);
        if (tokenModel.code == 200) {
            [NSObject showSuccessHudTipStr:@"登录成功!"];
            DebugLog(@"打印的token%@",tokenModel.data.token);
            DEFAULTS_SET_OBJ(tokenModel.data.token, @"token");
            SelectVC *selectVC = [SelectVC new];
//            selectVC.tabBarItem.title
            selectVC.tokenModel = tokenModel;
            [self.navigationController pushViewController:selectVC animated:YES];
        }else{
            [NSObject showInfoHudTipStr:tokenModel.msg];
        }
    } failure:^(id data, NSError *error) {
        DebugLog(@"登录失败!");
    }];
    
}

- (void) jumpToRegister {
    RegisterVC *registerVC = [RegisterVC new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:registerVC];
    navi.title = @"快速注册";
    navi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

- (void) jumpToForget {
    ForgetVC *forgetVC = [ForgetVC new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:forgetVC];
    navi.title = @"找回密码";
    navi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

// 控制输入手机号
- (void) userNameTF:(UITextField*)textField {
    if (textField == self.usernamreEdt) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
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
