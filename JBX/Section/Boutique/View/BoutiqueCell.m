//
//  BoutiqueCell.m
//  JBX
//
//  Created by 证 on 2018/1/18.
//  Copyright © 2018年 证. All rights reserved.
//

#import "BoutiqueCell.h"

@implementation BoutiqueCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.pic];
        
        _weekSelf(weakSelf);
        [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView);
        }];
        [self.pic addSubview:self.txt];
        [_txt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.pic.mas_left).offset(0);
            make.right.equalTo(weakSelf.pic.mas_right).offset(0);
            make.bottom.equalTo(weakSelf.pic.mas_bottom).offset(0);
            make.height.equalTo(@20);
        }];
        
    }
    return self;
}
- (UIImageView *)pic {
    if (_pic==nil) {
        self.pic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
        _pic.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _pic.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _pic;
}
- (UILabel *)txt {
    if (_txt==nil) {
        self.txt = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(15)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentCenter];
    }
    return _txt;
}

@end
