//
//  NoNetView.m
//  JBX
//
//  Created by 证 on 2018/1/17.
//  Copyright © 2018年 证. All rights reserved.
//

#import "NoNetView.h"

@implementation NoNetView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.noNetPic];
        [self addSubview:self.tipsLB];
        _weekSelf(weakSelf)
        [_noNetPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.height.equalTo(@90);
            make.width.equalTo(@90);
        }];
        [_tipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.noNetPic.mas_bottom).offset(10);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.equalTo(@25);
        }];
    }
    return self;
}

- (UIImageView *)noNetPic {
    if (_noNetPic==nil) {
        self.noNetPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
        
    }
    return _noNetPic;
}

- (UILabel *)tipsLB {
    if (_tipsLB==nil) {
        self.tipsLB = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@"网络已断开,请检查连接!"
                                       withTextColor:CELL_LINE_GRAY_COLOR
                                            withFont:PINGFANG_FONT_SIZE(15)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentCenter];
    }
    return _tipsLB;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
