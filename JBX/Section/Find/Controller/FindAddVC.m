//
//  FindAddVC.m
//  JBX
//
//  Created by 证 on 2018/1/12.
//  Copyright © 2018年 证. All rights reserved.
//

#import "FindAddVC.h"
#import "LabelWithTFView.h"
#import "SelectWordView.h"
#import "XTextField.h"
#import "NSDate+BRAdd.h"

@interface FindAddVC ()
@property (nonatomic,strong) LabelWithTFView *titleView;
@property (nonatomic,strong) UIScrollView *scrollView,*scrollView1;
@property (nonatomic,strong) UIButton *saveBtn,*saveBtn1;
@property (nonatomic,strong) SelectWordView *selectSexView,*selectBirthdayView;
//@property (nonatomic,strong) SelectWordView *selectWordView;
@end

@implementation FindAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationView];
    if (_currentID == 0) {
        // 添加简历
        [self initAddWordView];
    }else if(_currentID == 2){
        // 添加招聘信息
        [self initAddHrView];
    }
    
}
- (void) initNavigationView {
    self.view.backgroundColor = RGBA(243, 243, 243, 1);
    self.title = _findAddTitle;
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
    
    
}
- (void) goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加简历
- (void) initAddWordView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.backgroundColor = RGBA(242, 242, 242, 1);
    [self.view addSubview:_scrollView];
    _weekSelf(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    UIView *contentView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [_scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
    }];


    self.titleView = [[LabelWithTFView alloc] initWithFrame:CGRectZero];
    [_titleView setTitleLBName:@"标题" withSubPlacerholder:@"请填写标题"];
    [contentView addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@50);
    }];
    
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleView.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];


    LabelWithTFView *labout1 = [[LabelWithTFView alloc] initWithFrame:CGRectZero];;
    [labout1 setTitleLBName:@"姓名" withSubPlacerholder:@"请填写真实姓名"];
    [contentView addSubview:labout1];
    [labout1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView1 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView1];

    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labout1.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];

    self.selectSexView = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [_selectSexView setTitleLBName:@"性别" withSubTitle:@"请选择性别"];
    _selectSexView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSexAction)];
    [_selectSexView addGestureRecognizer:tap];
    [contentView addSubview:_selectSexView];

    [_selectSexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    
    
    
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView2];
    

    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.selectSexView.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];

    self.selectBirthdayView = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [_selectBirthdayView setTitleLBName:@"出生年月" withSubTitle:@"请选择出生年月"];
    _selectBirthdayView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBirthdayAction)];
    [_selectBirthdayView addGestureRecognizer:tap1];
    [contentView addSubview:_selectBirthdayView];

    [_selectBirthdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView3 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView3];

    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.selectBirthdayView.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];

    SelectWordView *selectView2 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView2 setTitleLBName:@"薪资待遇" withSubTitle:@"请选择薪资范围"];
    [contentView addSubview:selectView2];

    [selectView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView4 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView4];

    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView2.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];

    SelectWordView *selectView3 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView3 setTitleLBName:@"工作年限" withSubTitle:@"请选择工作年限"];
    [contentView addSubview:selectView3];

    [selectView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView5 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView5];

    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView3.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];

    LabelWithTFView *labout2 = [[LabelWithTFView alloc] initWithFrame:CGRectZero];;
    [labout2 setTitleLBName:@"联系电话" withSubPlacerholder:@"请填写有效的手机号码"];
    [contentView addSubview:labout2];
    [labout2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView5.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView6 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView6];

    [lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labout2.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@10);
    }];

    SelectWordView *selectView4 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView4 setTitleLBName:@"求职岗位" withSubTitle:@"请选择职位"];
    [contentView addSubview:selectView4];

    [selectView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView6.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView7 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView7];

    [lineView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView4.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];
    UILabel *introLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"一句话介绍一下自己吧"
                                                  withTextColor:RGBA(102, 102, 102, 1)
                                                       withFont:PINGFANG_FONT_SIZE(15)
                                                    withGbColor:[UIColor whiteColor]
                                              withTextAlignment:NSTextAlignmentLeft];
    [contentView addSubview:introLB];

    [introLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView7.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
    }];

    UITextField *introTF = [UITextField initWithTextFiledWithFrame:CGRectZero
                                                          withName:@""
                                                   withPlaceholder:@"【示例】本人已从事不锈钢行业10年，熟练掌握各种专业技能，性格热情开朗，待人友好，为人诚实谦虚。"
                                                     withHintColor:RGBA(213, 213, 213, 1)
                                                      withHintSize:PINGFANG_FONT_SIZE(15)
                                                 withTextAlignment:NSTextAlignmentLeft
                                                      withFontSize:PINGFANG_FONT_SIZE(15)
                                                     withTextColor:RGBA(102, 102, 102, 1)
                                                      withDelegate:self];
//    introTF.adjustsFontSizeToFitWidth = YES;

    [contentView addSubview:introTF];

    [introTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introLB.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
    }];

    UIView *lineView8 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView8];

    [lineView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introTF.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@124);
    }];
    self.saveBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                           withFrame:CGRectZero
                                                           withTitle:@"保存"
                                                      withTitleColor:RGBA(255, 255, 255, 1)
                                                              withGB:RGBA(3, 115, 228, 1)
                                                            withFont:PINGFANG_FONT_SIZE(16)];

    [lineView8 addSubview:_saveBtn];

    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView8.mas_top).offset(50);
        make.left.equalTo(lineView8).offset(16);
        make.right.equalTo(lineView8).offset(-16);
        make.height.equalTo(@44);
    }];


    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView8.mas_bottom).offset(0);
    }];

}

// 选择性别
- (void) selectSexAction {
    _weekSelf(weakSelf);
    [BRStringPickerView showStringPickerWithTitle:@"" dataSource:@[@"男", @"女", @"其他"] defaultSelValue:@"男" isAutoSelect:YES resultBlock:^(id selectValue) {
//        NSString *title = [NSString stringWithFormat:@"%@", selectValue ];
        [weakSelf.selectSexView setText:selectValue];
    }];
}
// 选择出生年月
- (void) selectBirthdayAction {
    _weekSelf(weakSelf);
    [BRDatePickerView showDatePickerWithTitle:@"" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:nil maxDateStr:[NSDate currentDateString] isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        [weakSelf.selectBirthdayView setText:selectValue];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}



// 添加招聘信息
- (void) initAddHrView {
    self.scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView1.backgroundColor = RGBA(242, 242, 242, 1);
    [self.view addSubview:_scrollView1];
    _weekSelf(weakSelf);
    [_scrollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    UIView *contentView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    [_scrollView1 addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView1);
        make.width.equalTo(weakSelf.scrollView1);
    }];
    
    SelectWordView *selectView = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView setTitleLBName:@"我要招聘" withSubTitle:@"请选择职位"];
    [contentView addSubview:selectView];
    
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];
    
    SelectWordView *selectView1 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView1 setTitleLBName:@"薪资待遇" withSubTitle:@"请选择薪资待遇"];
    [contentView addSubview:selectView1];
    
    [selectView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView3 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView1.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];
    
    SelectWordView *selectView2 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView2 setTitleLBName:@"福利待遇" withSubTitle:@"请选择福利范围"];
    [contentView addSubview:selectView2];
    
    [selectView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView4 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView4];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView2.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];
    
    SelectWordView *selectView3 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView3 setTitleLBName:@"工作年限" withSubTitle:@"请选择工作年限"];
    [contentView addSubview:selectView3];
    
    [selectView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView5 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView5];
    
    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView3.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];
    
    SelectWordView *selectView4 = [[SelectWordView alloc] initWithFrame:CGRectZero];
    [selectView4 setTitleLBName:@"招聘人数" withSubTitle:@"请选择人数"];
    [contentView addSubview:selectView4];
    
    [selectView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView5.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@50);
    }];
    UIView *lineView6 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView6];
    
    [lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView4.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@1);
    }];
    UILabel *introLB = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@"职位描述"
                                       withTextColor:RGBA(102, 102, 102, 1)
                                            withFont:PINGFANG_FONT_SIZE(15)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentLeft];
    [contentView addSubview:introLB];
    
    [introLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView6.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(16);
        make.right.equalTo(contentView).offset(-16);
    }];
    
    UIView *introView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor clearColor]];
    [contentView addSubview:introView];
    [introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introLB.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view).offset(-16);
        make.height.equalTo(@80);
    }];

    XTextField *introTV = [[XTextField alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH-32, 80)];
    introTV.backgroundColor = [UIColor whiteColor];
    introTV.placehoder = @"【示例】本人已从事不锈钢行业10年，熟练掌握各种专业技能，性格热情开朗，待人友好，为人诚实谦虚。";
    introTV.placehoderColor = RGBA(213, 213, 213, 1);
    introTV.font = PINGFANG_FONT_SIZE(15);
    introTV.textColor = RGBA(102, 102, 102, 1);
    [introView addSubview:introTV];
    
    UIView *lineView8 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [contentView addSubview:lineView8];
    
    [lineView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introView.mas_bottom).offset(15);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.equalTo(@124);
    }];
    self.saveBtn1 = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                            withFrame:CGRectZero
                                            withTitle:@"发布"
                                       withTitleColor:RGBA(255, 255, 255, 1)
                                               withGB:RGBA(3, 115, 228, 1)
                                             withFont:PINGFANG_FONT_SIZE(16)];
    
    [lineView8 addSubview:_saveBtn1];
    
    [_saveBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView8.mas_top).offset(50);
        make.left.equalTo(lineView8).offset(16);
        make.right.equalTo(lineView8).offset(-16);
        make.height.equalTo(@44);
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView8.mas_bottom).offset(0);
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
