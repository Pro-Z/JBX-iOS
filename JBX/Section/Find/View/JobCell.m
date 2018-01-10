//
//  JobCell.m
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import "JobCell.h"

@implementation JobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.expericeLab];
        [self.contentView addSubview:self.commitLab];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.companyLab];
        [self.contentView addSubview:self.applyBtn];
        
        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
        [self.contentView addSubview:lineView];
        UIView *bottomView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(240, 240, 240, 1)];
        [self.contentView addSubview:bottomView];
        
        // 排版
        _weekSelf(weakSelf)
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(19);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.mas_equalTo(@17);
            make.width.mas_equalTo(@60);
        }];
//        _timeLab.backgroundColor = [UIColor orangeColor];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(16);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.timeLab.mas_left).offset(-10);
            make.height.equalTo(@20);
        }];
//        _nameLab.backgroundColor = [UIColor greenColor];
        
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLab.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.width.equalTo(@70);
            make.height.equalTo(@18);
        }];
//        _priceLab.backgroundColor = [UIColor greenColor];
        
        
        [_expericeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLab.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.priceLab.mas_right).offset(15);
            make.width.equalTo(@150);
            make.height.equalTo(@18);
        }];
//        _expericeLab.backgroundColor = [UIColor redColor];
        
    
        [_commitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.priceLab.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.equalTo(@18);
        }];
//        _companyLab.backgroundColor = [UIColor orangeColor];
        
        [_applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.timeLab.mas_bottom).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.equalTo(@30);
            make.width.equalTo(@60);
        }];
        ViewRadius(_applyBtn, 2);
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.commitLab.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
    
        [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.equalTo(@20);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.companyLab.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@10);
        }];
        
        
    }
    return self;
}
- (UILabel *)nameLab {
    if (_nameLab == nil) {
        self.nameLab = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@""
                                       withTextColor:RGBA(34, 34, 34, 1)
                                            withFont:PINGFANG_FONT_SIZE_BOLD(15)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _nameLab;
}
- (UILabel *)priceLab {
    if (_priceLab == nil) {
        self.priceLab = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@""
                                       withTextColor:RGBA(250, 117, 2, 1)
                                            withFont:PINGFANG_FONT_SIZE(13)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _priceLab;
}
- (UILabel *)expericeLab {
    if (_expericeLab == nil) {
        self.expericeLab = [UILabel initUILabelWithFrame:CGRectZero
                                                withText:@""
                                           withTextColor:RGBA(135, 135, 135, 1)
                                                withFont:PINGFANG_FONT_SIZE(13)
                                             withGbColor:[UIColor whiteColor]
                                       withTextAlignment:NSTextAlignmentLeft];
    }
    return _expericeLab;
}

- (UILabel *)commitLab {
    if (_commitLab == nil) {
        self.commitLab = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@""
                                         withTextColor:RGBA(135, 135, 135, 1)
                                              withFont:PINGFANG_FONT_SIZE(13)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
    }
    return _commitLab;
}
- (UILabel *)timeLab {
    if (_timeLab == nil) {
        self.timeLab = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@""
                                       withTextColor:RGBA(135, 135, 135, 1)
                                            withFont:PINGFANG_FONT_SIZE(12)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentLeft];
    }
    return _timeLab;
}

- (UILabel *)companyLab {
    if (_companyLab == nil) {
        self.companyLab = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@""
                                          withTextColor:RGBA(135, 135, 135, 1)
                                               withFont:PINGFANG_FONT_SIZE(13)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    }
    return _companyLab;
}

- (UIButton *)applyBtn {
    if (_applyBtn == nil) {
        self.applyBtn = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                 withFrame:CGRectZero
                                                 withTitle:@"申请"
                                            withTitleColor:[UIColor whiteColor]
                                                    withGB:RGBA(3, 115, 228, 1)
                                                  withFont:PINGFANG_FONT_SIZE(14)];
    }
    return _applyBtn;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
