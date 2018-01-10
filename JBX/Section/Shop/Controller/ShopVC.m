//
//  ShopVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "ShopVC.h"
#import "DZSearchBarWithIcon.h"
#import "ShopListCell.h"

@interface ShopVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) UITableView *hortoalTableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *itemViews;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataSource];
    [self initNavigationBarView];
    [self initTableviewHeader];
    [self initShopListView];
    
}

// 初始化数据源
- (void) initDataSource {
    self.dataArr = @[
                     @{
                         @"menuname":@"今日现货",
                         @"menupic":@"shop_tit_spot"
                         },
                     @{
                         @"menuname":@"优质供应商",
                         @"menupic":@"shop_tit_sup"
                         },
                     @{
                         @"menuname":@"优质加工商",
                         @"menupic":@"shop_tab_con"
                         }
                     ];
}

// 自定义搜索导航栏
- (void) initNavigationBarView {
    self.navigationController.navigationBar.backgroundColor = RGBA(48, 127, 222, 1);
    UIView *newTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 30)];
//    newTitleView.backgroundColor = RGBA(48, 127, 222, 1);
    DZSearchBarWithIcon *searchView = [DZSearchBarWithIcon searchBar];
    UIImageView *iconPic = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 42, 4, 22, 22)];
    iconPic.image = [UIImage imageNamed:@"shop_nav_cart"];
    [newTitleView addSubview:searchView];
    [newTitleView addSubview:iconPic];
    self.navigationItem.titleView = newTitleView;
}

// 初始化tableview header
- (void) initTableviewHeader {
    self.itemViews = [[NSMutableArray alloc] init];
    self.headerView = [UIView initWithUIViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) withBackground:RGBA(242, 242, 242, 1)];
    // 初始化三个item
    NSArray *iconArr = @[@"shop_tab_spot",@"shop_tab_sup",@"shop_tab_conx"];
    NSArray *titleArr = @[@"找现货",@"找供应商",@"找加工商"];
    for (int i = 0; i<iconArr.count; i++) {
        UIView *views = [UIView initWithUIViewWithFrame:CGRectMake(i*SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 110) withBackground:[UIColor whiteColor]];
        views.tag = i;
        views.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleItem:)];
        [views addGestureRecognizer:tapGes];
        UIImageView *itemPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:iconArr[i]];
        UILabel *titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                   withText:titleArr[i]
                                              withTextColor:RGBA(34, 34, 34, 1)
                                                   withFont:PINGFANG_FONT_SIZE(15)
                                                withGbColor:[UIColor whiteColor]
                                          withTextAlignment:NSTextAlignmentCenter];
        [views addSubview:itemPic];
        [views addSubview:titleLabel];

        [itemPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(views).offset(35);
            make.centerX.equalTo(views.mas_centerX).offset(0);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(itemPic.mas_bottom).offset(15);
            make.centerX.equalTo(views.mas_centerX).offset(0);
        }];
        
//        [_itemViews addObject:views];
        [_headerView addSubview:views];
    }
//    [_headerView addSubview:views];
}

// UIView的点击事件
-(void) handleItem: (id) sender{
    UITapGestureRecognizer *tapClick = (UITapGestureRecognizer *)sender;
    DebugLog(@"点击了第几个%ld",(long)[tapClick view].tag);
}

// 初始化商品界面
- (void) initShopListView {
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.conte
    self.hortoalTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _hortoalTableView.delegate = self;
    _hortoalTableView.dataSource = self;
    [_hortoalTableView registerClass:[ShopListCell class] forCellReuseIdentifier:@"ShopListCell"];
    _hortoalTableView.tableHeaderView = _headerView;
    [self.view addSubview:_hortoalTableView];
    _weekSelf(weakSelf)
    [_hortoalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(weakSelf.view).offset(0);
        make.leftMargin.equalTo(weakSelf.view).offset(0);
        make.rightMargin.equalTo(weakSelf.view).offset(0);
        make.bottomMargin.equalTo(weakSelf.view).offset(0);
    }];
}

#pragma mark - 初始化tableview的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
#pragma mark - 初始化tableview的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    NSString *arr = [[self.dataArr objectAtIndex:indexPath.row]objectForKey:@"menuname"];
    NSString *arrPic = [[self.dataArr objectAtIndex:indexPath.row]objectForKey:@"menupic"];
//    DebugLog(@"遍历%@",[arr objectAtIndex:indexPath.row]);
    [cell setFirstTxt:arr  withFirstPic:arrPic];
//    cell.textLabel.text = @"测试";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 251;
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
