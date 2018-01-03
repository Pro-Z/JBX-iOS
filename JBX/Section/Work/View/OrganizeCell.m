//
//  OrganizeCell.m
//  JBX
//
//  Created by 证 on 2017/12/16.
//  Copyright © 2017年 证. All rights reserved.
//

#import "OrganizeCell.h"

@implementation OrganizeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.potalPic];
        [self.contentView addSubview:self.editPic];
        [self.contentView addSubview:self.lineView];
        _weekSelf(weakSelf);
        [_potalPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.height.equalTo(@44);
            make.width.equalTo(@44);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.potalPic.mas_right).offset(10);
            make.height.equalTo(@25);
        }];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.titleLabel.mas_right).offset(12);
            make.height.equalTo(@16);
        }];
        [_editPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView).offset(-1);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
        
        
    }
    return self;
}

- (UIImageView *)potalPic {
    if (_potalPic == nil) {
        self.potalPic = [[UIImageView alloc] initWithFrame:CGRectZero];
        _potalPic.backgroundColor = CELL_LINE_GRAY_COLOR;
        ViewRadius(_potalPic, 22);
    }
    return _potalPic;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"测试主标题"
                                          withTextColor:[UIColor blackColor]
                                               withFont:PINGFANG_FONT_SIZE(14)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (_subTitleLabel == nil) {
        self.subTitleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@"副标题"
                                             withTextColor:[UIColor whiteColor]
                                                  withFont:PINGFANG_FONT_SIZE(11)
                                               withGbColor:APP_COLOR_BASE_NAV
                                         withTextAlignment:NSTextAlignmentCenter];
    }
    return _subTitleLabel;
}

- (UIImageView *)editPic {
    if (_editPic == nil) {
        self.editPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"organ_edit"];
    }
    return _editPic;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        self.lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    }
    return _lineView;
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
