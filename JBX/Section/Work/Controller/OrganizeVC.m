//
//  OrganizeVC.m
//  JBX
//
//  Created by 证 on 2017/12/15.
//  Copyright © 2017年 证. All rights reserved.
//

#import "OrganizeVC.h"
#import "OrganizeCell.h"
#import "OrganizeHeaderCell.h"
#import "GetPartmentListModel.h"
#import "PartmentListModel.h"
#import "AddtionalVC.h"
#import "SecondOrganVC.h"


@interface OrganizeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *organizeTableview;
@property (nonatomic,strong) DZCenterSearchBar *headerSearchBar;
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *addPeopleBtn,*addPartmentBtn;
@property (nonatomic,strong) PartmentListModel *partmentModel;
@end

@implementation OrganizeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationView];
    [self initSearchBarViewx];
//    [self initTableView];
    [self initBottomView];
    
    [self initDataSource];
}

- (void) initDataSource {
    GetPartmentListModel *getPartmentModel = [GetPartmentListModel new];
    getPartmentModel.token = DEFAULTS_GET_OBJ(@"token");
    getPartmentModel.org_id = DEFAULTS_GET_OBJ(@"org_id");
    getPartmentModel.parent_dept_id = @"root";
    [[NetAPIManager sharedManager] request_common_WithPath:APP_GET_PARTMENT_BY_PARENTID_URL Params:getPartmentModel autoShowProgressHUD:YES typeGet:YES succesBlack:^(id data) {
        self.partmentModel = [MTLJSONAdapter modelOfClass:[PartmentListModel class] fromJSONDictionary:data error:nil];
        if (_partmentModel.code == 200) {
            [NSObject showSuccessHudTipStr:@"部门列表获取成功!"];
            [self initTableView];
        }else{
            [NSObject showHudTipStr:_partmentModel.msg];
        }
    } failue:^(id data, NSError *error) {
        
    }];
}

- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = DEFAULTS_GET_OBJ(@"appname");
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
// 初始化tableview
- (void) initTableView {
    self.organizeTableview = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _organizeTableview.backgroundColor = RGBA(243, 243, 243, 1);
    _organizeTableview.delegate = self;
    _organizeTableview.dataSource = self;
    [self.view addSubview:_organizeTableview];
    _weekSelf(weakSelf)
    [_organizeTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.searchView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(-48);
    }];
}

// 添加员工和添加部门
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
    DEFAULTS_SET_OBJ(@"2", @"TYPE");
    AddtionalVC *addVC = [AddtionalVC new];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - searchBar 代理

#pragma mark - 实现tableview 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _partmentModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
//    if (indexPath.row <=_dataSource.count) {
        static NSString *rid=@"OrganizeHeaderCell";
        OrganizeHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            cell=[[OrganizeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
//            DebugLog(@"名字%@",[_partmentModel.data[indexPath.row] name]);
            [cell.titleLabel setText:[_partmentModel.data[indexPath.row] name]];
//            cell.textLabel.text = @"测试顶部cell";
        }
        return cell;
//    }else{
//        static NSString *rid=@"OrganizeCell";
//        OrganizeCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
//        if(cell==nil){
//            cell=[[OrganizeCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
//            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
////            cell.textLabel.text = @"测试底部cell";
//        }
//        return cell;
//    }
//    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row <=_dataSource.count) {
//        return 52;
//    }else {
//        return 64;
//    }
    return 52;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondOrganVC *organVC = [SecondOrganVC new];
    organVC.secondTitle = [_partmentModel.data[indexPath.row] name];
    organVC.dept_id = [_partmentModel.data[indexPath.row] dept_id];
    [self.navigationController pushViewController:organVC animated:YES];
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
