//
//  FindThreeVC.m
//  JBX
//
//  Created by 证 on 2018/1/12.
//  Copyright © 2018年 证. All rights reserved.
//

#import "FindThreeVC.h"
#import "FindThreeCell.h"
#import "MineWorkCell.h"
#import "FindAddVC.h"

@interface FindThreeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *threeTableView;
@property (nonatomic,strong) FindAddVC *findAddVC;
@end

@implementation FindThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    self.currentID = _currentID;
    self.titleStr = _titleStr;
    [self initNavigationView];
    [self initTableView];
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = _titleStr;
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
    if (_currentID == 0 || _currentID == 2) {
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
        rightBtn.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightBtn;
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) operateBtn {
   self.findAddVC = [FindAddVC new];
    if (_currentID == 0) {
        // 添加简历
        _findAddVC.currentID = 0;
        _findAddVC.findAddTitle = @"添加简历";
    }else if(_currentID == 2){
        _findAddVC.currentID = 2;
        _findAddVC.findAddTitle = @"发布招聘信息";
    }
    [self.navigationController pushViewController:_findAddVC animated:YES];
}
- (void) initTableView {
    
    self.threeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _threeTableView.backgroundColor = RGBA(240, 240, 240, 1);
    _threeTableView.delegate =self;
    _threeTableView.dataSource = self;
    if (_currentID == 1) {
        [_threeTableView registerNib:[UINib nibWithNibName:@"MineWorkCell" bundle:nil] forCellReuseIdentifier:@"MineWorkCell"];
    }
    [self.view addSubview:_threeTableView];
    _weekSelf(weakSelf)
    [_threeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view);
    }];
}
#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
    if (_currentID == 0 || _currentID == 2) {
        static NSString *rid=@"FindThreeCell";
        FindThreeCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        
        if(cell==nil){
            cell=[[FindThreeCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            cell.nameLB.text = @"激光切割师傅";
            cell.timeLB.text = @"2018-01-07";
            cell.browserLB.text = @"浏览: 200";
            cell.communicateLB.text = @"沟通: 200";
            cell.offerNameLB.text = @"求职岗位: ";;
            cell.offerLB.text = @"切割师傅";
        }
        return cell;
        
    }else if(_currentID == 1){
        MineWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineWorkCell" forIndexPath:indexPath];
//        cell.nameLB.text = @"";
        return cell;
        
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentID == 0||_currentID == 2) {
        return 114;
    }else{
        return 148;
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
