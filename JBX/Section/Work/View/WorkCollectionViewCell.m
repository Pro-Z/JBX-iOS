//
//  WorkCollectionViewCell.m
//  JBX
//
//  Created by 证 on 2017/12/8.
//  Copyright © 2017年 证. All rights reserved.
//

#import "WorkCollectionViewCell.h"

@implementation WorkCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.contentView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.workIcon];
        [self.contentView addSubview:self.subTitleLabel];
//        [self.contentView addSubview:self.bottomView];
        _weekSelf(weakSelf)
        [_workIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.contentView).offset(10);
            make.centerX.equalTo(weakSelf.contentView);
            make.size.height.equalTo(@22);
            make.size.width.equalTo(@22);
        }];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.workIcon.mas_bottom).offset(20);
            make.leftMargin.equalTo(weakSelf.contentView).offset(5);
            make.rightMargin.equalTo(weakSelf.contentView).offset(-5);
        }];
        
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.subTitleLabel.mas_bottom).offset(20);
            make.leftMargin.equalTo(weakSelf.contentView).offset(0);
            make.rightMargin.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@10);
        }];
        
        
    }
    return self;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        self.bottomView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(243, 243, 243, 1)];
    }
    return _bottomView;
}

- (UIImageView *)workIcon {
    if (_workIcon == nil) {
        self.workIcon = [[UIImageView alloc] init];
//        _workIcon.backgroundColor = [UIColor redColor];
    }
    return _workIcon;
}

- (UILabel *)subTitleLabel {
    if(_subTitleLabel == nil){
        self.subTitleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@""
                                             withTextColor:RGBA(51, 51, 51, 1)
                                                  withFont:PINGFANG_FONT_SIZE(12)
                                               withGbColor:[UIColor whiteColor]
                                         withTextAlignment:NSTextAlignmentCenter];
        _subTitleLabel.font = PINGFANG_FONT_SIZE(12);
//        _subTitleLabel.backgroundColor = [UIColor greenColor];
    }
    return _subTitleLabel;
}

- (void)setWorkIcon:(NSString *)workIcon withSubTitle:(NSString *)title {
//    self.workIcon.image = workIcon;
    UIImage *images =[UIImage imageNamed:workIcon];
    self.workIcon.image = images;
    self.subTitleLabel.text = title;
}


@end
