//
//  OrganizeHeaderCell.m
//  JBX
//
//  Created by 证 on 2017/12/16.
//  Copyright © 2017年 证. All rights reserved.
//

#import "OrganizeHeaderCell.h"

@implementation OrganizeHeaderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.goPic];
        [self.contentView addSubview:self.lineView];
//        _titleLabel.backgroundColor = [UIColor greenColor];
//        _subTitleLabel.backgroundColor = [UIColor redColor];
        _weekSelf(weakSelf)
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.height.equalTo(@25);
        }];
        [_goPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@16);
            make.width.equalTo(@9);
        }];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.right.equalTo(weakSelf.goPic.mas_left).offset(-5);
            make.height.equalTo(@25);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView).offset(-1);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
        
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"测试主标题"
                                          withTextColor:[UIColor blackColor]
                                               withFont:PINGFANG_FONT_SIZE(15)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (_subTitleLabel == nil) {
        self.subTitleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@"测试副标题"
                                             withTextColor:RGBA(152, 152, 152, 1)
                                                  withFont:PINGFANG_FONT_SIZE(14)
                                               withGbColor:[UIColor whiteColor]
                                         withTextAlignment:NSTextAlignmentLeft];
    }
    return _subTitleLabel;
}

- (UIImageView *)goPic {
    if (_goPic == nil) {
        self.goPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"organ_more"];
    }
    return _goPic;
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
