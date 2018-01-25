//
//  BoutiqueDetalVC.m
//  JBX
//
//  Created by 证 on 2018/1/24.
//  Copyright © 2018年 证. All rights reserved.
//

#import "BoutiqueDetalVC.h"
#import "XTextField.h"

@interface BoutiqueDetalVC ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *headPic,*userPic,*raisePic,*commentPic;
@property (nonatomic,strong) UIButton *backBTN,*shareBTN;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *userNameLB,*titleLB,*timeLB,*cutLB,*raiseLB,*commentLB;
@property (nonatomic,strong) UILabel *materialLB,*heightLB,*colorLB,*lengthLB,*widthLB,*sumLB,*contentLB;

@property (nonatomic,strong) UIButton *commentListBTN,*raiseActionBTN;

@end

@implementation BoutiqueDetalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    self.navigationController.navigationBarHidden = YES;
    [self initScrollView];
    
}
- (void) initScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:VIEWFRAME(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    self.contentView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(246, 246, 246, 1)];
    
    [self.scrollView addSubview:_contentView];
    
    _weekSelf(weakSelf);
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
    }];
    
    
    self.headPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"placerholder"];
    _headPic.contentMode = UIViewContentModeScaleAspectFill;
    _headPic.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_headPic];
    
    [_headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(0);
        make.left.equalTo(weakSelf.contentView).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(0);
        make.height.equalTo(@180);
    }];
    
//    [_headPic sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276956551&di=2b22a48af81000d2ccea3ccb772e4bf8&imgtype=0&src=http%3A%2F%2Fimg5.niutuku.com%2Fphone%2F1212%2F5952%2F5952-niutuku.com-89417.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//    }];
    

    self.backBTN = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_backBTN setImage:[UIImage imageNamed:@"icon__in_back"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_backBTN];
    [_backBTN addTarget:self action:@selector(handleBack) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(15+STATUS_BAR_HEIGHT);
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    
    
    self.shareBTN = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_shareBTN setImage:[UIImage imageNamed:@"icon_in_more"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_shareBTN];
    [_shareBTN addTarget:self action:@selector(shareForFriend) forControlEvents:(UIControlEventTouchUpInside)];

    [_shareBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(15+STATUS_BAR_HEIGHT);
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    
    UIView *bottomView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(246, 246, 246, 1)];
    
    [self.contentView addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headPic.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.contentView).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(0);
        make.bottom.equalTo(weakSelf.contentView);
    }];
    
    
    
    
    self.userPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                            withImageName:@"placerholder"];
    ViewRadius(_userPic, 11);
    [bottomView addSubview:_userPic];
    
    [_userPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(20);
        make.left.equalTo(bottomView).offset(16);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    
    self.userNameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"测试名称"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:RGBA(246, 246, 246, 1)
                                              withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_userNameLB];
    
    [_userNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.userPic.mas_centerY).offset(0);
        make.left.equalTo(weakSelf.userPic.mas_right).offset(10);
        make.right.equalTo(bottomView).offset(-16);
    }];
    
    self.titleLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"可定制展柜，珠宝展示柜"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE_BOLD(18)
                                                    withGbColor:RGBA(246, 246, 246, 1)
                                              withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_titleLB];
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userPic.mas_bottom).offset(20);
        make.left.equalTo(bottomView).offset(16);
        make.right.equalTo(bottomView).offset(-16);
    }];
    
    self.timeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"02-19"
                                                  withTextColor:RGBA(102, 102, 102, 1)
                                                       withFont:PINGFANG_FONT_SIZE(12)
                                                    withGbColor:RGBA(246, 246, 246, 1)
                                              withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_timeLB];
//    _timeLB.backgroundColor = [UIColor orangeColor];
    
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(20);
        make.left.equalTo(bottomView).offset(16);
        make.width.equalTo(@60);
    }];
    
    self.cutLB = [UILabel initUILabelWithFrame:CGRectZero
                                       withText:@"169"
                                  withTextColor:RGBA(102, 102, 102, 1)
                                       withFont:PINGFANG_FONT_SIZE(12)
                                    withGbColor:RGBA(246, 246, 246, 1)
                              withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_cutLB];
//    _cutLB.backgroundColor = [UIColor greenColor];
    
    [_cutLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.timeLB.mas_right).offset(0);
        make.width.equalTo(@60);
    }];
    
    self.raisePic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                            withImageName:@"icon_fab"];
    [bottomView addSubview:_raisePic];
    
    [_raisePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.cutLB.mas_right).offset(10);
        make.width.equalTo(@14);
        make.height.equalTo(@14);
    }];
    
    self.raiseLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"20121"
                                                  withTextColor:RGBA(102, 102, 102, 1)
                                                       withFont:PINGFANG_FONT_SIZE(12)
                                                    withGbColor:RGBA(246, 246, 246, 1)
                                              withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_raiseLB];
    
    [_raiseLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.raisePic.mas_right).offset(5);
        make.width.equalTo(@60);
    }];
    
    self.commentPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                              withImageName:@"icon_com"];
    [bottomView addSubview:_commentPic];
    
    [_commentPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.raiseLB.mas_right).offset(5);
        make.width.equalTo(@14);
        make.height.equalTo(@14);
    }];
    
    self.commentLB = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"20121"
                                   withTextColor:RGBA(102, 102, 102, 1)
                                        withFont:PINGFANG_FONT_SIZE(12)
                                     withGbColor:RGBA(246, 246, 246, 1)
                               withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_commentLB];
    
    [_commentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.commentPic.mas_right).offset(5);
        make.width.equalTo(@60);
    }];
    
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(216, 216, 216, 1)];
    [bottomView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLB.mas_bottom).offset(20);
        make.left.equalTo(bottomView).offset(16);
        make.width.equalTo(@2);
        make.height.equalTo(@80);
    }];
    

    self.materialLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"材质：铁板"
                                                  withTextColor:RGBA(102, 102, 102, 1)
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:RGBA(246, 246, 246, 1)
                                              withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_materialLB];
    
    [_materialLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLB.mas_bottom).offset(20);
        make.left.equalTo(lineView).offset(20);
        make.width.equalTo(@80);
    }];
    self.heightLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"厚度：0.8"
                                      withTextColor:RGBA(102, 102, 102, 1)
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:RGBA(246, 246, 246, 1)
                                  withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_heightLB];
    
    [_heightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLB.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.materialLB.mas_right).offset(20);
        make.width.equalTo(@80);
    }];
    self.colorLB = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"板材颜色：玫瑰金拉丝"
                                    withTextColor:RGBA(102, 102, 102, 1)
                                         withFont:PINGFANG_FONT_SIZE(14)
                                      withGbColor:RGBA(246, 246, 246, 1)
                                withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_colorLB];
    
    [_colorLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.materialLB.mas_bottom).offset(10);
        make.left.equalTo(lineView.mas_right).offset(20);
        make.width.equalTo(@160);
    }];
    
    self.lengthLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@"长度：1100"
                                      withTextColor:RGBA(102, 102, 102, 1)
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:RGBA(246, 246, 246, 1)
                                  withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_lengthLB];
    
    [_lengthLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.colorLB.mas_bottom).offset(10);
        make.left.equalTo(lineView).offset(20);
        make.width.equalTo(@80);
    }];
    self.widthLB = [UILabel initUILabelWithFrame:CGRectZero
                                         withText:@"宽度：1100"
                                    withTextColor:RGBA(102, 102, 102, 1)
                                         withFont:PINGFANG_FONT_SIZE(14)
                                      withGbColor:RGBA(246, 246, 246, 1)
                                withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_widthLB];
    
    [_widthLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.colorLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.lengthLB.mas_right).offset(20);
        make.width.equalTo(@80);
    }];
    
    self.sumLB = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@"总面积：1100"
                                   withTextColor:RGBA(102, 102, 102, 1)
                                        withFont:PINGFANG_FONT_SIZE(14)
                                     withGbColor:RGBA(246, 246, 246, 1)
                               withTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:_sumLB];
    
    [_sumLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.colorLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.widthLB.mas_right).offset(20);
        make.width.equalTo(@100);
    }];
    
    self.contentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                       withText:@"位于澳大利亚帕丁顿的珠宝零售店，由Landini Associates设计。这是一家珠宝定制店，与商业大众零售市场形成鲜明对比的是店内从内至外几乎看不到成品陈列，打破了传统意义上的零售店，仅能看到陈列小珠宝盒的长方形珠宝陈列柜台。产品作为定制体验的一部分，通过原材料和流程与客户进行交流，引导客户从中找到最完美的首饰。从选材到定制成品，均在该店完成，这也是品牌的一种理念。"
                                                  withTextColor:[UIColor blackColor]
                                                       withFont:PINGFANG_FONT_SIZE(14)
                                                    withGbColor:RGBA(246, 246, 246, 1)
                                              withTextAlignment:NSTextAlignmentLeft];
    _contentLB.numberOfLines = 0;
    [bottomView addSubview:_contentLB];
    
    [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.widthLB.mas_bottom).offset(20);
        make.left.equalTo(bottomView).offset(16);
        make.right.equalTo(bottomView).offset(-16);
//        make.bottom.equalTo(weakSelf.contentView).offset(-50);
    }];
    
    // 为了约束scrollview
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentLB.mas_bottom).offset(100);
    }];
    
    // 底部输入框
    UIView *inputView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
    
    [self.view addSubview:inputView];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(0);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.height.equalTo(@48);
    }];
    
    UIView *insideView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(236, 236, 236, 1)];
    [inputView addSubview:insideView];
    ViewRadius(insideView, 8);
    
    [insideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView).offset(6);
        make.left.equalTo(inputView).offset(16);
        make.right.equalTo(inputView).offset(-90);
        make.height.equalTo(@36);
    }];
    UIImageView *writePic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                            withImageName:@"icon_speak"];
    [insideView addSubview:writePic];
    
    [writePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(insideView).offset(8);
        make.left.equalTo(insideView).offset(10);
        make.width.equalTo(@18);
        make.height.equalTo(@18);
    }];
    
    
    XTextField *introTV = [[XTextField alloc] initWithFrame:CGRectZero];
    introTV.backgroundColor = RGBA(236, 236, 236, 1);
    introTV.placehoder = @"我有话说";
    introTV.placehoderColor = RGBA(213, 213, 213, 1);
    introTV.font = PINGFANG_FONT_SIZE(15);
    introTV.textColor = RGBA(102, 102, 102, 1);
    introTV.returnKeyType = UIReturnKeySend;
    [insideView addSubview:introTV];
    
    [introTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(insideView).offset(0);
        make.left.equalTo(writePic.mas_right).offset(5);
        make.right.equalTo(insideView).offset(0);
        make.height.equalTo(@36);
    }];
    
    self.commentListBTN = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_commentListBTN setImage:[UIImage imageNamed:@"comment_list"] forState:(UIControlStateNormal)];
    [inputView addSubview:_commentListBTN];
    
    [_commentListBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView).offset(13);
        make.left.equalTo(insideView.mas_right).offset(15);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    
    
    self.raiseActionBTN = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_raiseActionBTN setImage:[UIImage imageNamed:@"icon_tab_fab"] forState:(UIControlStateNormal)];
    [inputView addSubview:_raiseActionBTN];
    
    [_raiseActionBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputView).offset(13);
        make.right.equalTo(inputView).offset(-15);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    
    
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
//    DebugLog(@"当前的高度为%lf",-(-STATUS_BAR_HEIGHT*CGRectGetWidth(self.view.frame)/375));
    if (point.y < 0) {
        CGRect rect = self.headPic.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y+180+STATUS_BAR_HEIGHT;
        rect.size.width = SCREEN_WIDTH;
        self.headPic.frame = rect;
    }
//    }else {
//        CGRect rect = self.headPic.frame;
//        rect.size.height = (180+STATUS_BAR_HEIGHT);
//        rect.size.width = SCREEN_WIDTH;
//        self.headPic.frame = rect;
//    }
    
}

- (void) handleBack {
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 * 分享到朋友圈
 */
- (void) shareForFriend {
    DebugLog(@"开始分享");
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString=@"分享给好友...";//标题的名字
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow=false;//不显示取消按钮
//    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewBackgroundColor=[UIColor whiteColor];//屏幕中间显示
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType=UMSocialSharePageGroupViewPositionType_Middle;//屏幕中间显示
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        DebugLog(@"当前的平台为%ld",(long)platformType);
        // 创建分享对象
        UMSocialMessageObject *messageObj = [UMSocialMessageObject messageObject];
        // 设置文本
        messageObj.text = @"测试分享";
        // 分享
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObj currentViewController:self completion:^(id result, NSError *error) {
            if(error){
                UMSocialLogInfo(@"*******分享失败:%@",error);
            }else{
                if([result isKindOfClass:[UMSocialShareResponse class]]){
                    UMSocialShareResponse *resp = result;
                    // 分享结果
                }
            }
            
            
            
        }];
        
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
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
