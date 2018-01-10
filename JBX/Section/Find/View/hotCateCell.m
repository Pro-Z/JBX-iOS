//
//  hotCateCell.m
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import "hotCateCell.h"

@implementation hotCateCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self.contentView addSubview:self.pic];
//        [self.contentView addSubview:self.txt];
        _weekSelf(weakSelf)
        
        UIView *centerView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
        [self.contentView addSubview:centerView];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(0);
            make.width.equalTo(@70);
            make.height.equalTo(@20);
        }];
        [centerView addSubview:self.pic];
        [centerView addSubview:self.txt];
        [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(centerView.mas_centerY).offset(0);
            make.left.equalTo(centerView).offset(0);
            make.width.mas_equalTo(@10);
            make.height.mas_equalTo(@12);
        }];
        [_txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(centerView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.pic.mas_right).offset(2);
            make.width.mas_equalTo(@56);
            make.height.mas_equalTo(@20);
        }];
        
    }
    return self;
}
- (UIImageView *)pic {
    if (_pic == nil) {
        self.pic = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _pic;
}
- (UILabel *)txt {
    if (_txt == nil) {
        self.txt = [UILabel initUILabelWithFrame:CGRectZero
                                        withText:@""
                                   withTextColor:[UIColor blackColor]
                                        withFont:PINGFANG_FONT_SIZE(14)
                                     withGbColor:[UIColor whiteColor]
                               withTextAlignment:NSTextAlignmentCenter];
    }
    return _txt;
}
@end
