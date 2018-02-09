//
//  MessageVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "MessageVC.h"
#import "BoutiqueListVC.h"
#import "BoutiqueListModel.h"

@interface MessageVC ()
@property (nonatomic,strong) DZSegmentController *segmentVC;
@property (nonatomic,strong) BoutiqueListVC *boutiqueListVC;
@property (nonatomic,strong) BoutiqueListModel *boutiqueListModel;
@property (nonatomic,strong) BoutiqueDataListModel *boutiqueDataListModel;
@property (nonatomic,strong) NSMutableArray *dataSource,*titleArr,*idArr;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    self.idArr = [NSMutableArray array];
    [self initNavigationView];
    [self initTabLayoutData];
    
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.navigationItem.title = @"精品加工图";
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_job_user"] style:(UIBarButtonItemStylePlain) target:self action:@selector(operateBtn)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:PINGFANG_FONT_SIZE(15),NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void) operateBtn {
    // TO DO SOMETHING
    
}


/**
 初始化tab数据
 */
- (void) initTabLayoutData {
    [[NetAPIManager sharedManager] request_common_WithPath:APP_BOUTIQUE_TAB_URL Params:nil autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        self.boutiqueListModel = [BoutiqueListModel mj_objectWithKeyValues:data];
        if (_boutiqueListModel.code == 200) {
//            NSArray *arr = [BoutiqueDataListModel mj_keyValuesArrayWithObjectArray:_boutiqueListModel.data];
//            _dataSource = [NSMutableArray arrayWithArray:arr];
            NSMutableArray *arr = [BoutiqueDataListModel mj_objectArrayWithKeyValuesArray:_boutiqueListModel.data];
            for (int i = 0; i<arr.count; i++) {
                self.boutiqueDataListModel = arr[i];
                [_titleArr addObject:_boutiqueDataListModel.name];
                [_idArr addObject:_boutiqueDataListModel.mID];
            }
            [self initTabLayout];
        }else{
            [NSObject showHudTipStr:@"请求失败!"];
        }
    } failue:^(id data, NSError *error) {
        
    }];
}

// 初始化tabLayout
- (void) initTabLayout {
    // 初始化tablayout
    self.navigationController.navigationBar.translucent = NO;
//    NSArray *titleArr = @[@"展柜",@"屏风",@"制品",@"配件",@"雕塑"];
//    NSArray *newsIDArr = @[@"1",@"2",@"3",@"4",@"5"];
    NSMutableArray *array  = [NSMutableArray arrayWithCapacity:_titleArr.count];
    for (int i = 0; i<_titleArr.count; i++) {
        self.boutiqueListVC = [BoutiqueListVC new];
        _boutiqueListVC.pageID = _idArr[i];
        [array addObject:_boutiqueListVC];
    }
    
    self.segmentVC = [[DZSegmentController alloc] initWithFrame:self.view.bounds titles:_titleArr];
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
    [self.segmentVC  setSelectedAtIndex:0];
    
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
