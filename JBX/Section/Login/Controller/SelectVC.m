//
//  SelectVC.m
//  JBX
//
//  Created by 证 on 2017/12/18.
//  Copyright © 2017年 证. All rights reserved.
//

#import "SelectVC.h"
#import "SelectOrganCell.h"
#import "SetOrganIDModel.h"

@interface SelectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *checkOrganTableView;
@property (nonatomic,strong) NSIndexPath *lastIndexPath;
@property (nonatomic,strong) SelectOrganCell *cellx;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSString *org_id;
@property (nonatomic,strong) NSString *appName;
@end

@implementation SelectVC
- (NSMutableArray *)titleArr {
    if (_titleArr == nil) {
        self.titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)viewWillAppear:(BOOL)animated {
    BLACK_STATUS_BAR_COLOR
}

- (void)viewWillDisappear:(BOOL)animated {
    WHITE_STATUS_BAR_COLOR
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
}

- (void) initDataSource {
    self.tokenModel = _tokenModel;
    self.appName = @"";
}

- (void) initUI {
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"请选择组织机构名称";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIImage *leftIcon = [[UIImage imageNamed:@"navi_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:leftIcon style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleEnsure)];
    [rightBtn setTintColor:APP_COLOR_BASE_NAV];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self initTableView];
    
}

- (void) backBtn:(UIButton *)btn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void) handleEnsure {
    // 点击确定
    if (self.org_id == nil) {
        [NSObject showInfoHudTipStr:@"组织机构不能为空!"];
        return;
    }
    [self initSetOrganData:_org_id];
    
}

- (void) initTableView {
    self.checkOrganTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _checkOrganTableView.backgroundColor = RGBA(216, 216, 216, 1);
    _checkOrganTableView.delegate = self;
    _checkOrganTableView.dataSource = self;
    [self.view addSubview:_checkOrganTableView];
    _weekSelf(weakSelf);
    [_checkOrganTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
}

// 设置组织机构
- (void) initSetOrganData:(NSString *)org_id {
    SetOrganIDModel *setOrgidModel = [SetOrganIDModel new];
    NSString *tokens = DEFAULTS_GET_OBJ(@"token");
    setOrgidModel.token = tokens;
    setOrgidModel.org_id = org_id;
    [[NetAPIManager sharedManager] request_SetOrgan_WithParams:setOrgidModel successBlock:^(id data) {
        RequestModel *requestModel = data;
        if (requestModel.status == 200) {
            [NSObject showSuccessHudTipStr:@"设置成功!"];
            DEFAULTS_SET_OBJ(_appName,@"appname");
            DEFAULTS_SET_OBJ(org_id, @"org_id");
        }else{
            [NSObject showInfoHudTipStr:requestModel.msg];
        }
    } failure:^(id data, NSError *error) {
        
    }];
    
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tokenModel.otherData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"SelectOrganCell";
    SelectOrganCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[SelectOrganCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        // 设置选择效果
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastIndexPath row];
        if (row == oldRow && self.lastIndexPath != nil) {
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"organ_yes"] forState:UIControlStateNormal];
            
        }else{
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"organ_no"] forState:UIControlStateNormal];
            
        }
        // 给cell 赋值
        _titleArr = [NSMutableArray arrayWithArray:_tokenModel.otherData];
        [cell.titleLabel setText:[_titleArr[indexPath.row] name]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = (self.lastIndexPath !=nil)?[self.lastIndexPath row]:-1;
    if (newRow != oldRow) {
        self.cellx = [tableView cellForRowAtIndexPath:indexPath];
        [self.cellx.selectBtn setImage:[UIImage imageNamed:@"organ_yes"] forState:UIControlStateNormal];
        self.cellx = [tableView cellForRowAtIndexPath:self.lastIndexPath];
        [self.cellx.selectBtn setImage:[UIImage imageNamed:@"organ_no"] forState:UIControlStateNormal];
        self.lastIndexPath = indexPath;
    }
    DebugLog(@"选择了%@",[_titleArr[indexPath.row] org_id]);
    self.org_id = [_titleArr[indexPath.row] org_id];
    self.appName = [_titleArr[indexPath.row] name];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
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
