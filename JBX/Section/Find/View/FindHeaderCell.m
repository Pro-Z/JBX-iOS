//
//  FindHeaderCell.m
//  JBX
//
//  Created by 证 on 2018/1/9.
//  Copyright © 2018年 证. All rights reserved.
//

#import "FindHeaderCell.h"

@implementation FindHeaderCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.pic];
        [self.contentView addSubview:self.txt];
        _weekSelf(weakSelf)
        [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(0);
            make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
            make.width.mas_equalTo(@35);
            make.height.mas_equalTo(@35);
        }];
        [_txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.pic.mas_bottom).offset(10);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(0);
            make.width.mas_equalTo(@65);
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
