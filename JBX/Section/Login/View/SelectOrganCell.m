//
//  SelectOrganCell.m
//  JBX
//
//  Created by 证 on 2017/12/18.
//  Copyright © 2017年 证. All rights reserved.
//

#import "SelectOrganCell.h"

@implementation SelectOrganCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.bottomLine];
        _weekSelf(weakSelf)
//        _selectBtn.backgroundColor = [UIColor redColor];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.height.equalTo(@20);
            make.width.equalTo(@20);
        }];
//        _titleLabel.backgroundColor = [UIColor greenColor];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.contentView.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.selectBtn.mas_right).offset(30);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@44);
        }];
    
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-1);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
        
        
    }
    return self;
}

- (UIButton *)selectBtn {
    if (_selectBtn == nil) {
        self.selectBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_selectBtn setImage:[UIImage imageNamed:@"organ_no"] forState:(UIControlStateNormal)];
    }
    return _selectBtn;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        self.titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"测试标题"
                                          withTextColor:[UIColor blackColor]
                                               withFont:PINGFANG_FONT_SIZE(15)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}
- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        self.bottomLine = [UIView initWithUIViewWithFrame:CGRectZero withBackground:CELL_LINE_GRAY_COLOR];
    }
    return _bottomLine;
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
