//
//  AddtionalVC.m
//  JBX
//
//  Created by 证 on 2017/12/20.
//  Copyright © 2017年 证. All rights reserved.
//

#import "AddtionalVC.h"
#import "AddPartmentModel.h"

@interface AddtionalVC ()
@property (nonatomic,strong) NSString *addType;
@property (nonatomic,strong) UILabel *nameLabel,*phoneLabel,*offerLabel,*emailLabel,*partmentLabel,*managerLabel,*phoneTipLabel,*managerTipsLabel;
@property (nonatomic,strong) UITextField *nameEdt,*phoneEdt,*offerEdt,*emailEdt;
@property (nonatomic,strong) UIView *nameLineview,*phoneLineView,*offerLineView,*emailLineView;
@property (nonatomic,strong) UIImageView *goPic;
@property (nonatomic,strong) UISwitch *managerSwitchBtn;
@property (nonatomic,assign) BOOL isNetWorkDone;
@end

@implementation AddtionalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isNetWorkDone = YES;
    self.addType = DEFAULTS_GET_OBJ(@"TYPE");
    [self initUI];
}
- (void) initUI {
    [self initNavigationView];
    
    if ([_addType isEqual:@"1"]) {
        // 添加员工
        [self initAddPeopleView];
    }else if([_addType isEqual:@"2"]){
        // 添加部门
        [self initAddPartmentView];
    }else if([_addType isEqual:@"3"]){
        // 添加子部门
        [self initAddPartmentView];
    }
    
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    if ([_addType isEqual:@"1"]) {
        self.title = @"添加员工";
    }else if([_addType isEqual:@"2"]){
        self.title = @"添加部门";
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
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) operateBtn {
    if ([_addType isEqual:@"1"]) {
        
    }else if([_addType isEqual:@"2"]){
        // 添加部门
        [self initAddPartmentData];
    }else if([_addType isEqual:@"3"]){
        // 添加子部门
        [self initAddPartmentData];
    }
}
- (void) initAddPartmentData {
    if (_emailEdt.text.length <=0) {
        [NSObject showHudTipStr:@"请输入部门名称!"];
        return;
    }
    AddPartmentModel *addPartmentModel = [AddPartmentModel new];
    addPartmentModel.token = DEFAULTS_GET_OBJ(@"token");
    addPartmentModel.name = _emailEdt.text;
    addPartmentModel.org_id = DEFAULTS_GET_OBJ(@"org_id");
    if ([_addType isEqual:@"2"]) {
        addPartmentModel.parent_dept_id = @"";
    }else if([_addType isEqual:@"3"]){
        addPartmentModel.parent_dept_id = DEFAULTS_GET_OBJ(@"dept_id");
    }
    
    DebugLog(@"传递的参数%@",addPartmentModel);
    [[NetAPIManager sharedManager] request_common_WithPath:APP_ADD_PARTMENT_URL Params:addPartmentModel autoShowProgressHUD:YES succesBlack:^(id data) {
        RequestModel *request = [MTLJSONAdapter modelOfClass:[RequestModel class] fromJSONDictionary:data error:nil];
        if (request.status == 200) {
            [NSObject showSuccessHudTipStr:@"部门添加成功!"];
            _isNetWorkDone = NO;
        }else{
            [NSObject showHudTipStr:request.msg];
        }
        
    } failue:^(id data, NSError *error) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(!_isNetWorkDone) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 添加员工
- (void) initAddPeopleView {
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectZero];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    self.nameLabel = [UILabel initUILabelWithFrame:CGRectZero
                                          withText:@"姓名"
                                     withTextColor:RGBA(34, 34, 34, 1)
                                          withFont:PINGFANG_FONT_SIZE(15)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentLeft];
    [nameView addSubview:_nameLabel];
    self.nameEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                  withName:@""
                                           withPlaceholder:@"必填"
                                             withHintColor:RGBA(152, 152, 152, 1)
                                              withHintSize:PINGFANG_FONT_SIZE(15)
                                         withTextAlignment:NSTextAlignmentLeft
                                              withFontSize:PINGFANG_FONT_SIZE(15)
                                             withTextColor:[UIColor blackColor]
                                              withDelegate:self];
    [nameView addSubview:_nameEdt];
    self.nameLineview = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    [nameView addSubview:_nameLineview];
    _weekSelf(weakSelf)
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView.mas_centerY).offset(0);
        make.left.equalTo(nameView).offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@62);
    }];
    [_nameEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView.mas_centerY).offset(0);
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(20);
        make.right.equalTo(nameView).offset(10);
        make.height.equalTo(@25);
    }];
    [_nameLineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nameView.mas_bottom).offset(-1);
        make.left.equalTo(nameView).offset(10);
        make.right.equalTo(nameView).offset(0);
        make.height.equalTo(@1);
    }];
    
    // 手机号
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectZero];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    self.phoneLabel = [UILabel initUILabelWithFrame:CGRectZero
                                          withText:@"手机号"
                                     withTextColor:RGBA(34, 34, 34, 1)
                                          withFont:PINGFANG_FONT_SIZE(15)
                                       withGbColor:[UIColor whiteColor]
                                 withTextAlignment:NSTextAlignmentLeft];
    [phoneView addSubview:_phoneLabel];
    self.phoneEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                  withName:@""
                                           withPlaceholder:@"必填(国际号码输入)"
                                             withHintColor:RGBA(152, 152, 152, 1)
                                              withHintSize:PINGFANG_FONT_SIZE(15)
                                         withTextAlignment:NSTextAlignmentLeft
                                              withFontSize:PINGFANG_FONT_SIZE(15)
                                             withTextColor:[UIColor blackColor]
                                              withDelegate:self];
    [phoneView addSubview:_phoneEdt];
    self.phoneLineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    [phoneView addSubview:_phoneLineView];
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView.mas_centerY).offset(0);
        make.left.equalTo(phoneView).offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@62);
    }];
    [_phoneEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView.mas_centerY).offset(0);
        make.left.equalTo(weakSelf.phoneLabel.mas_right).offset(20);
        make.right.equalTo(phoneView).offset(10);
        make.height.equalTo(@25);
    }];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(phoneView.mas_bottom).offset(-1);
        make.left.equalTo(phoneView).offset(10);
        make.right.equalTo(phoneView).offset(0);
        make.height.equalTo(@1);
    }];
    // 职位
    UIView *offerView = [[UIView alloc] initWithFrame:CGRectZero];
    offerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:offerView];
    self.offerLabel = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"职位"
                                      withTextColor:RGBA(34, 34, 34, 1)
                                           withFont:PINGFANG_FONT_SIZE(15)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [offerView addSubview:_offerLabel];
    self.offerEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                   withName:@""
                                            withPlaceholder:@"选填"
                                              withHintColor:RGBA(152, 152, 152, 1)
                                               withHintSize:PINGFANG_FONT_SIZE(15)
                                          withTextAlignment:NSTextAlignmentLeft
                                               withFontSize:PINGFANG_FONT_SIZE(15)
                                              withTextColor:[UIColor blackColor]
                                               withDelegate:self];
    [offerView addSubview:_offerEdt];
    self.offerLineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    [offerView addSubview:_offerLineView];
    
    [offerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    [_offerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(offerView.mas_centerY).offset(0);
        make.left.equalTo(offerView).offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@62);
    }];
    [_offerEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(offerView.mas_centerY).offset(0);
        make.left.equalTo(weakSelf.offerLabel.mas_right).offset(20);
        make.right.equalTo(offerView).offset(10);
        make.height.equalTo(@25);
    }];
    [_offerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(offerView.mas_bottom).offset(-1);
        make.left.equalTo(offerView).offset(10);
        make.right.equalTo(offerView).offset(0);
        make.height.equalTo(@1);
    }];
    // 企业邮箱
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectZero];
    emailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:emailView];
    self.emailLabel = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"企业邮箱"
                                      withTextColor:RGBA(34, 34, 34, 1)
                                           withFont:PINGFANG_FONT_SIZE(15)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [emailView addSubview:_emailLabel];
    self.emailEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                   withName:@""
                                            withPlaceholder:@"选填"
                                              withHintColor:RGBA(152, 152, 152, 1)
                                               withHintSize:PINGFANG_FONT_SIZE(15)
                                          withTextAlignment:NSTextAlignmentLeft
                                               withFontSize:PINGFANG_FONT_SIZE(15)
                                              withTextColor:[UIColor blackColor]
                                               withDelegate:self];
    [emailView addSubview:_emailEdt];
    self.emailLineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    [emailView addSubview:_emailLineView];
    
    [emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offerView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(emailView.mas_centerY).offset(0);
        make.left.equalTo(emailView).offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@62);
    }];
    [_emailEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(emailView.mas_centerY).offset(0);
        make.left.equalTo(weakSelf.emailLabel.mas_right).offset(20);
        make.right.equalTo(offerView).offset(10);
        make.height.equalTo(@25);
    }];
    [_emailLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(emailView.mas_bottom).offset(-1);
        make.left.equalTo(emailView).offset(10);
        make.right.equalTo(emailView).offset(0);
        make.height.equalTo(@1);
    }];
    // 部门
    UIView *partmentView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [self.view addSubview:partmentView];
    self.partmentLabel = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@"部门"
                                         withTextColor:RGBA(34, 34, 34, 1)
                                              withFont:PINGFANG_FONT_SIZE(15)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    [partmentView addSubview:_partmentLabel];
    self.goPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"organ_more"];
    [partmentView addSubview:_goPic];
    
    [partmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emailView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    
    [_goPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partmentView.mas_centerY).offset(0);
        make.right.equalTo(partmentView).offset(-10);
        make.height.equalTo(@16);
        make.width.equalTo(@8.8);
    }];
    [_partmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partmentView.mas_centerY).offset(0);
        make.left.equalTo(partmentView).offset(10);
        make.right.equalTo(weakSelf.goPic.mas_left).offset(-10);
        make.height.equalTo(@25);
    }];
    // 手机自动提示注册
    self.phoneTipLabel  = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"提交后手机号码自动注册为聚不锈用户，默认密码为手机后六位"
                                          withTextColor:RGBA(152, 152, 152, 1)
                                               withFont:PINGFANG_FONT_SIZE(14)
                                            withGbColor:RGBA(243, 243, 243, 1)
                                      withTextAlignment:NSTextAlignmentLeft];
    _phoneTipLabel.numberOfLines = 0;
    [self.view addSubview:_phoneTipLabel];
    [_phoneTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(partmentView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(10);
        make.right.equalTo(weakSelf.view).offset(-10);
    }];
    // 高管模式
    UIView *managerView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [self.view addSubview:managerView];
    self.managerLabel = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@"高管模式"
                                        withTextColor:RGBA(34, 34, 34, 1)
                                             withFont:PINGFANG_FONT_SIZE(15)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
    [managerView addSubview:_managerLabel];
    self.managerSwitchBtn = [[UISwitch alloc] initWithFrame:CGRectZero];
    [_managerSwitchBtn setOn:YES animated:YES];
    [managerView addSubview:_managerSwitchBtn];
    
    [managerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneTipLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    
    [_managerSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(managerView.mas_centerY).offset(0);
        make.right.equalTo(managerView).offset(-10);
        make.height.equalTo(@31);
        make.width.equalTo(@51);
    }];
    [_managerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(managerView.mas_centerY).offset(0);
        make.left.equalTo(managerView).offset(10);
        make.right.equalTo(weakSelf.managerSwitchBtn.mas_left).offset(0);
        make.height.equalTo(@25);
    }];
    // 底部提示
    self.managerTipsLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@"开启后，该成员可指派订单到该部门某个成员"
                                            withTextColor:RGBA(152, 152, 152, 1)
                                                 withFont:PINGFANG_FONT_SIZE(14)
                                              withGbColor:RGBA(243, 243, 243, 1)
                                        withTextAlignment:NSTextAlignmentLeft];
    _managerTipsLabel.numberOfLines = 0;
    [self.view addSubview:_managerTipsLabel];
    [_managerTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(managerView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.view).offset(10);
        make.right.equalTo(weakSelf.view).offset(10);
    }];
}
// 添加部门
- (void) initAddPartmentView {
    // 添加部门
    UIView *partmentView = [[UIView alloc] initWithFrame:CGRectZero];
    partmentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:partmentView];
    self.emailLabel = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"部门名称"
                                      withTextColor:RGBA(34, 34, 34, 1)
                                           withFont:PINGFANG_FONT_SIZE(15)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
    [partmentView addSubview:_emailLabel];
    self.emailEdt = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                   withName:@""
                                            withPlaceholder:@"必填"
                                              withHintColor:RGBA(152, 152, 152, 1)
                                               withHintSize:PINGFANG_FONT_SIZE(15)
                                          withTextAlignment:NSTextAlignmentLeft
                                               withFontSize:PINGFANG_FONT_SIZE(15)
                                              withTextColor:[UIColor blackColor]
                                               withDelegate:self];
    [partmentView addSubview:_emailEdt];
    
    _weekSelf(weakSelf);
    [partmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@52);
    }];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partmentView.mas_centerY).offset(0);
        make.left.equalTo(partmentView).offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@62);
    }];
    [_emailEdt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partmentView.mas_centerY).offset(0);
        make.left.equalTo(weakSelf.emailLabel.mas_right).offset(20);
        make.right.equalTo(partmentView).offset(-10);
        make.height.equalTo(@25);
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
