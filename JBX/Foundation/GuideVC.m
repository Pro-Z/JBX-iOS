//
//  GuideVC.m
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#import "GuideVC.h"
#import "TabBarVC.h"

#define ImageCount 3
@interface GuideVC ()<UIScrollViewDelegate>

@property(nonatomic,retain) UIPageControl *pageController;
@property(nonatomic,retain) UIScrollView *scrollView;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initScrollView];
    [self initPageControl];
}


/**
 初始化滚动条
 */
- (void) initScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:APP_BOUNDS];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ImageCount * SCREEN_WIDTH, SCREEN_HIGHT);
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    for (int i =0; i<ImageCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%d.png",i+1]];
        UIImageView *iamgeView = [[UIImageView alloc] initWithImage:image];
        iamgeView.frame = VIEWFRAME(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HIGHT);
        [_scrollView addSubview:iamgeView];
        if (ImageCount - 1 == i) {
            iamgeView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [iamgeView addGestureRecognizer:tap];
        }
    }
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    DEFAULTS_SET_BOOL(YES, @"isFirst1");
    TabBarVC *tabBar = [TabBarVC new];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}


/**
 初始化pageControl
 */
- (void)initPageControl{
    self.pageController = [[UIPageControl alloc]initWithFrame:VIEWFRAME(0, SCREEN_HIGHT-40, SCREEN_WIDTH, 30)];
    _pageController.numberOfPages = ImageCount;
    _pageController.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    [_pageController addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageController];
}

- (void)handlePageControl:(UIPageControl*)sender {
    _scrollView.contentOffset = CGPointMake(sender.currentPage * SCREEN_WIDTH, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageController.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
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
