//
//  ConfirmVC.m
//  JBX
//
//  Created by 证 on 2017/12/7.
//  Copyright © 2017年 证. All rights reserved.
//

#import "ConfirmVC.h"

@interface ConfirmVC ()
@property (nonatomic,strong) UIImageView *forgetIcon;
@property (nonatomic,strong) UITextField *cnewPasswordEdt;
@property (nonatomic,strong) UITextField *confirmPawEdt;
@property (nonatomic,strong) UIButton *confirmBtn;
@end

@implementation ConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self initConformView];
}

- (void) initNavigationBar {
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"确认新密码";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImage *leftIcon = [[UIImage imageNamed:@"navi_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:leftIcon style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void) backBtn:(UIButton *)btn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void) initConformView {
    self.forgetIcon = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"login_icon"];
    [self.view addSubview:_forgetIcon];
    self.cnewPasswordEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                      withName:@""
                                               withPlaceholder:@"请输入新密码" withHintColor:TEXTFILED_HINT_COLOR withHintSize:PINGFANG_FONT_SIZE(15) withTextAlignment:NSTextAlignmentLeft
                                                  withFontSize:PINGFANG_FONT_SIZE(15)
                                                 withTextColor:[UIColor blackColor]
                                                  withDelegate:self];
    _cnewPasswordEdt.keyboardType = UIKeyboardTypeDefault;
    _cnewPasswordEdt.secureTextEntry = YES;
    [self.view addSubview:_cnewPasswordEdt];
    
    UIView *line_user = [UIView initWithUIViewWithFrame:CGRectZero withBackground:APP_COLOR_BASE_LINE_GRAY];
    [self.view addSubview:line_user];
    
    self.confirmPawEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                        withName:@""
                                                 withPlaceholder:@"请再次输入新密码"
                                                   withHintColor:TEXTFILED_HINT_COLOR
                                                    withHintSize:PINGFANG_FONT_SIZE(15)
                                               withTextAlignment:NSTextAlignmentLeft
                                                    withFontSize:PINGFANG_FONT_SIZE(15)
                                                   withTextColor:[UIColor blackColor]
                                                    withDelegate:self];
    _confirmPawEdt.keyboardType = UIKeyboardTypeDefault;
    _confirmPawEdt.secureTextEntry = YES;
    [self.view addSubview:_confirmPawEdt];
    
    UIView *line_verify = [UIView initWithUIViewWithFrame:CGRectZero withBackground:APP_COLOR_BASE_LINE_GRAY];
    [self.view addSubview:line_verify];
    
    self.confirmBtn = [UIButton initButtonWithButtonType:UIButtonTypeCustom
                                              withFrame:CGRectZero
                                              withTitle:@"下一步"
                                         withTitleColor:[UIColor whiteColor]
                                                 withGB:APP_COLOR_BASE_NAV
                                               withFont:PINGFANG_FONT_SIZE(16)];
    ViewRadius(_confirmBtn, 20);
    [self.view addSubview:_confirmBtn];
    
    _weekSelf(weakSelf)
    [_forgetIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.view).offset(100);
        make.centerX.equalTo(weakSelf.view);
    }];
    [_cnewPasswordEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.forgetIcon.mas_bottom).offset(60);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@40);
    }];
    [line_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.cnewPasswordEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@1);
    }];
    [_confirmPawEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_user.mas_bottom).offset(30);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@40);
    }];
    [_confirmPawEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_user.mas_bottom).offset(30);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        
    }];
    
    [line_verify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.confirmPawEdt.mas_bottom).offset(10);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@1);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(line_verify.mas_bottom).offset(60);
        make.leftMargin.equalTo(weakSelf.view).offset(20);
        make.rightMargin.equalTo(weakSelf.view).offset(-20);
        make.height.equalTo(@44);
    }];
    [_confirmBtn addTarget:self action:@selector(findNewPaw) forControlEvents:(UIControlEventTouchUpInside)];
}

// 找回密码
- (void) findNewPaw {
    ForgetPawModel *forgetModel = [ForgetPawModel new];
    forgetModel.phone = _phoneStr;
    forgetModel.verifyCode = _verifyCodeStr;
    forgetModel.password = _cnewPasswordEdt.text;
    NSString *isEmpty = [forgetModel checkIsEmpty];
    if (isEmpty) {
        [NSObject showInfoHudTipStr:isEmpty];
        return;
    }
    NSString *confirmPawStr = _confirmPawEdt.text;
    if (confirmPawStr.length<=0) {
        [NSObject showInfoHudTipStr:@"请输入确认密码!"];
        return;
    }
    if (_cnewPasswordEdt.text != _confirmPawEdt.text) {
        [NSObject showInfoHudTipStr:@"两次输入的密码不一致!"];
        return;
    }
    [[NetAPIManager sharedManager] request_FindPaw_WithParams:forgetModel successBlock:^(id data) {
        
    } failure:^(id data, NSError *error) {
        
    }];
    
    
//    [[NetAPIManager sharedManager] request_common_WithPath:APP_FORGETPAW_URL Params:forgetModel succesBlack:^(id data) {
//        RequestModel *requestModel = [MTLJSONAdapter modelOfClass:[RequestModel class] fromJSONDictionary:data error:nil];
//        if (requestModel.status == 200) {
//            [NSObject showSuccessHudTipStr:@"找回密码成功!"];
//        }else{
//            [NSObject showInfoHudTipStr:requestModel.msg];
//        }
//
//    } failue:^(id data, NSError *error) {
//        [NSObject showError:error];
//    }];
    
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
