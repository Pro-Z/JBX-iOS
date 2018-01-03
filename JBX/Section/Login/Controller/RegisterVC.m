//
//  RegisterVC.m
//  JBX
//
//  Created by 证 on 2017/12/7.
//  Copyright © 2017年 证. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (nonatomic,strong) UIImageView *registerIcon;
@property (nonatomic,strong) UITextField *usernameEdt;
@property (nonatomic,strong) UITextField *passwordEdt;
@property (nonatomic,strong) UITextField *verifyCodeEdt;
@property (nonatomic,strong) UIButton *registerBtn;
@property (nonatomic,strong) UIImageView *checkIcon;
@property (nonatomic,strong) UILabel *agreeLabel;
@property (nonatomic,strong) UIButton *sendVerifyBtn;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self initRegsiterView];
}

- (void) initNavigationBar {
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"快速注册";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImage *leftIcon = [[UIImage imageNamed:@"navi_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:leftIcon style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void) backBtn:(UIButton *)btn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 初始化界面
- (void) initRegsiterView {
    self.registerIcon = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"login_icon"];
    [self.view addSubview:_registerIcon];
    self.usernameEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                       withName:@""
                                                withPlaceholder:@"请输入手机号码" withHintColor:TEXTFILED_HINT_COLOR withHintSize:PINGFANG_FONT_SIZE(15) withTextAlignment:NSTextAlignmentLeft
                                                   withFontSize:PINGFANG_FONT_SIZE(15)
                                                  withTextColor:[UIColor blackColor]
                                                   withDelegate:self];
    _usernameEdt.keyboardType = UIKeyboardTypeNumberPad;
    [_usernameEdt addTarget:self action:@selector(userNameTF:) forControlEvents:(UIControlEventEditingChanged)];
    [self.view addSubview:_usernameEdt];
    
    UIView *line_user = [UIView initWithUIViewWithFrame:CGRectZero withBackground:APP_COLOR_BASE_LINE_GRAY];
    [self.view addSubview:line_user];
    
    self.verifyCodeEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                      withName:@""
                                               withPlaceholder:@"请输入验证码"
                                                 withHintColor:TEXTFILED_HINT_COLOR
                                                  withHintSize:PINGFANG_FONT_SIZE(15)
                                             withTextAlignment:NSTextAlignmentLeft
                                                  withFontSize:PINGFANG_FONT_SIZE(15)
                                                 withTextColor:[UIColor blackColor]
                                                  withDelegate:self];
    _verifyCodeEdt.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyCodeEdt addTarget:self action:@selector(verifyTF:) forControlEvents:(UIControlEventEditingChanged)];
    [self.view addSubview:_verifyCodeEdt];
    
    self.sendVerifyBtn = [UIButton initButtonWithButtonType:UIButtonTypeCustom
                                                  withFrame:CGRectZero
                                                  withTitle:@" 获取验证码 "
                                             withTitleColor:APP_COLOR_BASE_NAV
                                                     withGB:[UIColor whiteColor]
                                                   withFont:PINGFANG_FONT_SIZE(14)];
    ViewBorderRadius(_sendVerifyBtn, 8,1,APP_COLOR_BASE_NAV);
    [self.view addSubview:_sendVerifyBtn];
    
    UIView *line_verify = [UIView initWithUIViewWithFrame:CGRectZero withBackground:APP_COLOR_BASE_LINE_GRAY];
    [self.view addSubview:line_verify];
    
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
    
    self.registerBtn = [UIButton initButtonWithButtonType:UIButtonTypeCustom
                                             withFrame:CGRectZero
                                             withTitle:@"下一步"
                                        withTitleColor:[UIColor whiteColor]
                                                withGB:APP_COLOR_BASE_NAV
                                              withFont:PINGFANG_FONT_SIZE(16)];
    ViewRadius(_registerBtn, 20);
    [self.view addSubview:_registerBtn];

    self.checkIcon = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"check_icon"];
    [self.view addSubview:_checkIcon];
    
    self.agreeLabel = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"我已阅读并同意聚不锈使用协议和隐私政策"
                                      withTextColor:RGBA(34, 34, 34, 1)
                                           withFont:SYSTEMFONT(12)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentCenter];
//    _agreeLabel.font = PINGFANG_FONT_SIZE(14);
    [self.view addSubview:_agreeLabel];
    
    _weekSelf(weakSelf)
    [_registerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.view).offset(80);
        make.centerX.equalTo(weakSelf.view);
    }];
    [_usernameEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.registerIcon.mas_bottom).offset(60);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@40);
    }];
    [line_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.usernameEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@1);
    }];
    [_verifyCodeEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_user.mas_bottom).offset(30);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@40);
    }];
    [_sendVerifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_user.mas_bottom).offset(30);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        
    }];
    
    [line_verify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.verifyCodeEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@1);
    }];
    
    [_passwordEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_verify.mas_bottom).offset(30);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@40);
    }];
    [line_paw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.passwordEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@1);
    }];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_paw.mas_bottom).offset(50);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@44);
    }];
    [_checkIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.registerBtn.mas_bottom).offset(12);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
    }];
    [_agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.registerBtn.mas_bottom).offset(18);
        make.leftMargin.equalTo(weakSelf.checkIcon.mas_right).offset(16);
        make.height.equalTo(@12);
    }];
    
    [_registerBtn addTarget:self action:@selector(handleRegister) forControlEvents:(UIControlEventTouchUpInside)];
    [_sendVerifyBtn addTarget:self action:@selector(sendVerifyCode) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 注册
- (void)handleRegister {
    RegisterModel *registerModel = [RegisterModel new];
    registerModel.userName = self.usernameEdt.text;
    registerModel.password = _passwordEdt.text;
    registerModel.verifyCode = _verifyCodeEdt.text;
    NSString *isEmpty = [registerModel checkIsEmpty];
    if (isEmpty) {
        [NSObject showInfoHudTipStr:isEmpty];
        return;
    }
    [[NetAPIManager sharedManager] request_register_WithParams:registerModel successBlock:^(id data) {
        
    } failure:^(id data, NSError *error) {
        
    }];
}

// 获取验证码
- (void) sendVerifyCode {
    if (_usernameEdt.text.length<=0) {
        [NSObject showInfoHudTipStr:@"请输入手机号码!"];
        return;
    }
    [self openCountdown];
    SendSmsModel *sendSMSModel = [[SendSmsModel alloc] init];
    sendSMSModel.toPhone = _usernameEdt.text;
    NSString *isEmpty = [sendSMSModel checkIsEmpty];
    if (isEmpty) {
        [NSObject showInfoHudTipStr:isEmpty];
        return ;
    }
    [[NetAPIManager sharedManager] request_SendSms_WithParams:sendSMSModel successBlock:^(id data) {
        
    } failure:^(id data, NSError *error) {
        
    }];
    
    
}

// 倒计时
-(void)openCountdown{
    __block NSInteger time = 29; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [_sendVerifyBtn setTitle:@" 重新获取验证码 " forState:UIControlStateNormal];
                [_sendVerifyBtn setTitleColor:APP_COLOR_BASE_NAV forState:UIControlStateNormal];
                _sendVerifyBtn.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [_sendVerifyBtn setTitle:[NSString stringWithFormat:@" %.2ds后重新发送 ", seconds] forState:UIControlStateNormal];
                [_sendVerifyBtn setTitleColor:APP_COLOR_BASE_NAV forState:UIControlStateNormal];
                _sendVerifyBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



- (void) userNameTF:(UITextField*)textField {
    if (textField == self.usernameEdt) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
- (void) verifyTF:(UITextField*)textField {
    if (textField == self.verifyCodeEdt) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
