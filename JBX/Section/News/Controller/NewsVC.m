//
//  NewsVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NewsVC.h"
#import "NewsListVC.h"
#import "NewsTitleListModel.h"

@interface NewsVC ()<UITextFieldDelegate>
@property (nonatomic,strong) DZSegmentController *segmentVC;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NewsTitleListModel *newsTitleListModel;
@property (nonatomic,strong) NewsListVC *newsListVC;
@property (nonatomic,strong) NSMutableArray *newsIDArr;
@property (nonatomic,strong) NSString *currentNewsID;
@end

@implementation NewsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initNavigationBarView];
    
}

// 自定义搜索导航栏
- (void) initNavigationBarView {
    self.navigationController.navigationBar.backgroundColor = RGBA(48, 127, 222, 1);
    DZSearchBar *searchView = [DZSearchBar searchBar];
    searchView.delegate = self;
    self.navigationItem.titleView = searchView;
    [self initTabLayoutData];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    DebugLog(@"搜索的内容为%@",textField.text);
    NSDictionary *dict = @{@"index":_currentNewsID,@"searchTxt":textField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeVC" object:nil userInfo:dict];
    [textField resignFirstResponder];
    return textField.text;
}

// 初始化标题栏数据
- (void) initTabLayoutData {
    self.titleArr = [NSMutableArray new];
    self.newsIDArr = [NSMutableArray new];
    [[NetAPIManager sharedManager] request_common_WithPath:APP_GET_NEWS_TITLE_LIST_URL Params:nil autoShowProgressHUD:YES typeGets:YES succesBlack:^(id data) {
        // 解析数据
        self.newsTitleListModel = [MTLJSONAdapter modelOfClass:[NewsTitleListModel class] fromJSONDictionary:data error:nil];
        if (_newsTitleListModel.code == 200) {
            [NSObject showSuccessHudTipStr:@"标题返回成功!"];
            for (int i = 0; i<_newsTitleListModel.data.count; i++) {
                DebugLog(@"打印的数据为%@",[_newsTitleListModel.data[i] key_name]);
                 [_titleArr addObject:[_newsTitleListModel.data[i] key_name]];
                [_newsIDArr addObject:[_newsTitleListModel.data[i] ids]];
            }
            self.currentNewsID = _newsIDArr[0];
            [self initTabLayout];
        }else{
            [NSObject showHudTipStr:_newsTitleListModel.msg];
        }

    } failue:^(id data, NSError *error) {
        [NSObject showHudTipStr:_newsTitleListModel.msg];
    }];

    
    
}


// 初始化tabLayout
- (void) initTabLayout {
    // 初始化tablayout
    self.navigationController.navigationBar.translucent = NO;
//    NSArray *titleArr = @[@"平台咨询",@"行业咨询",@"商业动态",@"下游咨询",@"平台咨询",@"行业咨询",@"商业动态"];
    NSMutableArray *array  = [NSMutableArray arrayWithCapacity:_titleArr.count];
    for (int i = 0; i<_titleArr.count; i++) {
         self.newsListVC = [NewsListVC new];
        _newsListVC.pageID = _newsIDArr[i];
        [array addObject:_newsListVC];
    }
    
    self.segmentVC = [[DZSegmentController alloc] initWithFrame:self.view.bounds titles:_titleArr];
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = APP_COLOR_BASE_NAV;
    self.segmentVC.viewControllers = array;
    //    if (array.count == 1) {
    //        self.segmentVC.segmentView.style = SegmentStyleDefault;
    //    } else {
    self.segmentVC.segmentView.style = SegmentStyleFlush;
    //    }
    //    [self.segmentVC  enumerateBadges:@[@(1),@10]];
    [self addSegmentController:self.segmentVC];
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
