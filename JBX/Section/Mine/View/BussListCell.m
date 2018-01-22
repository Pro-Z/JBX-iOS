//
//  BussListCell.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "BussListCell.h"

@implementation BussListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headerPic];
        _weekSelf(weakSelf)
        [_headerPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.width.equalTo(@25);
            make.height.equalTo(@25);
        }];
        
        [self.contentView addSubview:self.firstLB];
        
        [_firstLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.headerPic.mas_centerY);
            make.left.equalTo(weakSelf.headerPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-16);
        }];
        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerPic.mas_bottom).offset(7);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
        
        [self.contentView addSubview:self.firstBTN];
        
        [_firstBTN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(20);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.equalTo(@36);
            make.width.equalTo(@76);
        }];
    
        [self.contentView addSubview:self.secondLB];
        [_secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.firstBTN.mas_left).offset(-10);
        }];
        [self.contentView addSubview:self.threeLB];
        [_threeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.secondLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.width.equalTo(@100);
        }];
        [self.contentView addSubview:self.fourLB];
        [_fourLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.secondLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.threeLB.mas_right).offset(0);
            make.right.equalTo(weakSelf.firstBTN.mas_left).offset(0);
        }];
        [self.contentView addSubview:self.fiveLB];
        _fiveLB.numberOfLines = 0;
        [_fiveLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.fourLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.contentView).offset(-16);
//            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
        [self.contentView addSubview:lineView2];
        
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.fiveLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
        }];
        
        
    }
    return self;
}
- (UIImageView *)headerPic {
    if (_headerPic==nil) {
        self.headerPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
       
        
    }
    return _headerPic;
}
- (UILabel *)firstLB {
    if (_firstLB==nil) {
        self.firstLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE_BOLD(16)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _firstLB;
}
- (UILabel *)secondLB {
    if (_secondLB==nil) {
        self.secondLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _secondLB;
}
- (UILabel *)threeLB {
    if (_threeLB==nil) {
        self.threeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _threeLB;
}
- (UILabel *)fourLB {
    if (_fourLB==nil) {
        self.fourLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(0, 118, 255, 1)
                                                           withFont:PINGFANG_FONT_SIZE(16)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
    }
    return _fourLB;
}
- (UILabel *)fiveLB {
    if (_fiveLB==nil) {
        self.fiveLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(102, 102, 102, 1)
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _fiveLB;
}
- (UIButton *)firstBTN {
    if (_firstBTN==nil) {
        self.firstBTN = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                               withFrame:CGRectZero
                                                               withTitle:@"转订货单"
                                                          withTitleColor:[UIColor whiteColor]
                                                                  withGB:RGBA(0, 118, 255, 1)
                                                                withFont:PINGFANG_FONT_SIZE(14)];
        
        ViewRadius(_firstBTN, 6);
    }
    return _firstBTN;
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
