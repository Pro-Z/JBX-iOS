//
//  WorkWithBannerReusableView.m
//  JBX
//
//  Created by 证 on 2017/12/8.
//  Copyright © 2017年 证. All rights reserved.
//

#import "WorkWithBannerReusableView.h"

@implementation WorkWithBannerReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //        self.backgroundColor = [UIColor whiteColor];
        NSArray *imageUrls = @[@"http://oot34wnx6.bkt.clouddn.com/banner1.png",@"http://oot34wnx6.bkt.clouddn.com/banner2.png"];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.bannerSV];
        
        _weekSelf(weakSelf)
//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@55);
//        }];
        [_bannerSV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf).offset(0);
            make.leftMargin.equalTo(weakSelf).offset(0);
            make.rightMargin.equalTo(weakSelf).offset(0);
            make.height.equalTo(@145);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.bannerSV.mas_bottom).offset(30);
            make.leftMargin.equalTo(weakSelf).offset(20);
            make.height.equalTo(@24);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.titleLabel.mas_bottom).offset(22);
            make.leftMargin.equalTo(weakSelf).offset(0);
            make.rightMargin.equalTo(weakSelf).offset(0);
            make.height.equalTo(@1);
        }];
        
        _bannerSV.imageURLStringsGroup = imageUrls;
        
    }
    return self;
}

- (SDCycleScrollView *)bannerSV {
    if (_bannerSV == nil) {
        self.bannerSV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner_icon"]];
//        self.bannerSV.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.bannerSV.currentPageDotColor = APP_COLOR_BASE_NAV;
        self.bannerSV.pageDotColor = [UIColor whiteColor];
        self.bannerSV.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _bannerSV;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        self.lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(243, 243, 243, 1)];
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@""
                                          withTextColor:RGBA(34, 34, 34, 1)
                                               withFont:PINGFANG_FONT_SIZE(17)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
        _titleLabel.font = PINGFANG_FONT_SIZE(17);
        
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
#pragma mark - 轮播图代理

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    DebugLog(@"----点击了第%ld张",index);
}

@end
