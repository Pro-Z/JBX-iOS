//
//  SecondOrganVC.m
//  JBX
//
//  Created by 证 on 2017/12/25.
//  Copyright © 2017年 证. All rights reserved.
//

#import "SecondOrganVC.h"
#import "PartmentAndMemberModel.h"
#import "OrganizeHeaderCell.h"
#import "AddtionalVC.h"

@interface SecondOrganVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) DZCenterSearchBar *headerSearchBar;
@property (nonatomic,strong) UITableView *secondTableView;
@property (nonatomic,strong) PartmentAndMemberModel *partmentAndMemberModel;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *addPeopleBtn,*addPartmentBtn;
@end

@implementation SecondOrganVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
}

- (void) initData {
    DebugLog(@"传递的dept_id%@",_dept_id);
    NSDictionary *dict = @{
                           @"dept_id":_dept_id,
                           @"token":DEFAULTS_GET_OBJ(@"token"),
                           @"org_id":DEFAULTS_GET_OBJ(@"org_id")
                           };
    [[NetAPIManager sharedManager] request_common_WithPath:APP_GET_PARTMENT_AND_MEMBER_URL Params:dict autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        self.partmentAndMemberModel = [MTLJSONAdapter modelOfClass:[PartmentAndMemberModel class] fromJSONDictionary:data error:nil];
        if (_partmentAndMemberModel.code == 200) {
            [NSObject showSuccessHudTipStr:@"列表获取成功!"];
            [self initTableView];
        }else{
            [NSObject showHudTipStr:_partmentAndMemberModel.msg];
        }
        
        
    } failue:^(id data, NSError *error) {
        
    }];
    
}

- (void) initView {
    self.title = _secondTitle;
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
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
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"批量操作" style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self initSearchBarViewx];
    [self initBottomView];
    // 初始化tableview界面
//    [self initTableView];
}
- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) operateBtn {
    DebugLog(@"批量操作");
    UIAlertController *sheetView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *operaPeopleAction = [UIAlertAction actionWithTitle:@"批量移动成员" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *operaNumberAction = [UIAlertAction actionWithTitle:@"批量删除成员" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheetView addAction:operaPeopleAction];
    [sheetView addAction:operaNumberAction];
    [sheetView addAction:cancelAction];
    [self presentViewController:sheetView animated:YES completion:nil];
    
}
// 初始化searchbar
- (void) initSearchBarViewx {
    self.searchView = [[UIView alloc] initWithFrame:CGRectZero];
    _searchView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_searchView];
    _weekSelf(weakSelf)
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@44);
    }];
    
    self.headerSearchBar = [[DZCenterSearchBar alloc] initWithFrame:CGRectZero];
    _headerSearchBar.placeholder = @" 搜索成员";
    [_searchView addSubview:_headerSearchBar];
    
    [_headerSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchView).offset(0);
        make.left.equalTo(_searchView).offset(0);
        make.right.equalTo(_searchView).offset(0);
        make.height.equalTo(@44);
    }];
}

- (void) initBottomView {
    self.bottomView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [self.view addSubview:_bottomView];
    self.addPeopleBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                 withFrame:CGRectZero
                                                 withTitle:@"添加员工"
                                            withTitleColor:APP_COLOR_BASE_NAV
                                                    withGB:[UIColor whiteColor]
                                                  withFont:PINGFANG_FONT_SIZE(15)];
    [_bottomView addSubview:_addPeopleBtn];
    self.addPartmentBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                   withFrame:CGRectZero
                                                   withTitle:@"添加部门"
                                              withTitleColor:APP_COLOR_BASE_NAV
                                                      withGB:[UIColor whiteColor]
                                                    withFont:PINGFANG_FONT_SIZE(15)];
    [_bottomView addSubview:_addPartmentBtn];
    UIView *lines = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    [_bottomView addSubview:lines];
    UIView *verticalLine = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    [_bottomView addSubview:verticalLine];
    
    _weekSelf(weakSelf)
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@48);
    }];
    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomView).offset(0);
        make.left.equalTo(weakSelf.bottomView).offset(0);
        make.right.equalTo(weakSelf.bottomView).offset(0);
        make.height.equalTo(@1);
    }];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bottomView.mas_centerX).offset(0);
        make.top.equalTo(weakSelf.bottomView).offset(14);
        make.height.equalTo(@20);
        make.width.equalTo(@1);
    }];
    [_addPeopleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomView).offset(1);
        make.left.equalTo(weakSelf.bottomView).offset(0);
        make.right.equalTo(verticalLine.mas_left).offset(-1);
        make.height.equalTo(@47);
    }];
    [_addPartmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomView).offset(1);
        make.right.equalTo(weakSelf.bottomView).offset(0);
        make.left.equalTo(verticalLine.mas_right).offset(1);
        make.height.equalTo(@47);
    }];
    [_addPeopleBtn addTarget:self action:@selector(handleAppPeople) forControlEvents:(UIControlEventTouchUpInside)];
    [_addPartmentBtn addTarget:self action:@selector(handleAddPartment) forControlEvents:(UIControlEventTouchUpInside)];
}
// 添加员工
- (void) handleAppPeople {
    DEFAULTS_SET_OBJ(@"1", @"TYPE");
    
    AddtionalVC *addVC = [AddtionalVC new];
    [self.navigationController pushViewController:addVC animated:YES];
}
// 添加部门
- (void) handleAddPartment {
    DEFAULTS_SET_OBJ(@"3", @"TYPE");
    DEFAULTS_SET_OBJ(_dept_id, @"dept_id");
    AddtionalVC *addVC = [AddtionalVC new];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void) initTableView {
    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    [self.view addSubview:_secondTableView];
    _weekSelf(weakSelf)
    [_secondTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(-48);
    }];
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _partmentAndMemberModel.data.dept.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"OrganizeHeaderCell";
    OrganizeHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[OrganizeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.titleLabel.text = [_partmentAndMemberModel.data.dept[indexPath.row] name];
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondOrganVC *organVC = [SecondOrganVC new];
    organVC.secondTitle = [_partmentAndMemberModel.data.dept[indexPath.row] name];
    organVC.dept_id = [_partmentAndMemberModel.data.dept[indexPath.row] dept_id];
    [self.navigationController pushViewController:organVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
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
