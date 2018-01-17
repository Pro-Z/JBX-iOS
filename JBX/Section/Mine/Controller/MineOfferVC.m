//
//  MineOfferVC.m
//  JBX
//
//  Created by 证 on 2018/1/16.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MineOfferVC.h"
#import "MineOfferListVC.h"

@interface MineOfferVC ()
@property (nonatomic,strong) DZSegmentController *segmentVC;
@end

@implementation MineOfferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationView];
    [self initTabLayout];
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    if (_currentID == 2) {
        self.title = @"我的报价";
    }else if(_currentID == 3){
        self.title = @"我的询价";
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
    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_job_user"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
//    rightBtn.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = rightBtn;
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// 初始化tabLayout
- (void) initTabLayout {
    self.navigationController.navigationBar.translucent = NO;
    NSArray *titleArr = @[@"待报价",@"已报价"];
    NSMutableArray *array  = [NSMutableArray arrayWithCapacity:titleArr.count];
    for (int i = 0; i<titleArr.count; i++) {
        MineOfferListVC *mineOfferListVC = [MineOfferListVC new];
        mineOfferListVC.pageID = _currentID;
        mineOfferListVC.titleStr = titleArr[i];
        [array addObject:mineOfferListVC];
    }
    
    self.segmentVC = [[DZSegmentController alloc] initWithFrame:self.view.bounds titles:titleArr];
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = APP_COLOR_BASE_NAV;
    self.segmentVC.viewControllers = array;
    //    if (array.count == 1) {
    //        self.segmentVC.segmentView.style = SegmentStyleDefault;
    //    } else {
    self.segmentVC.segmentView.style = SegmentStyleDefault;
    //    }
    [self.segmentVC  enumerateBadges:@[@(1),@10]];
    
    [self addSegmentController:self.segmentVC withView:self.view];
    [self.segmentVC  setSelectedAtIndex:1];
    [self.segmentVC setSelectedAtIndex:0];
    
    
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
