//
//  LookOrderCell.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "LookOrderCell.h"

@implementation LookOrderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _weekSelf(weakSelf);
        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(0);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
        
        [self.contentView addSubview:self.firstPic];
        
        [_firstPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.width.equalTo(@99);
            make.height.equalTo(@66);
        }];
        
        [self.contentView addSubview:self.firstLB];
       
        [_firstLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-38);
        }];
        [self.contentView addSubview:self.secondLB];
        
        [_secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.firstLB.mas_bottom).offset(3);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-38);
            
        }];
        [self.contentView addSubview:self.threeLB];
        
        [_threeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.secondLB.mas_bottom).offset(3);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-38);
        }];
        
        [self.contentView addSubview:self.secondPic];
        
        [_secondPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(25);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        
        [self.contentView addSubview:self.fourLB];
        
        [_fourLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.secondPic.mas_bottom).offset(0);
            make.centerX.equalTo(weakSelf.secondPic.mas_centerX);
        }];
        
        
    }
    return self;
}
- (UIImageView *)firstPic {
    if (_firstPic==nil) {
        self.firstPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
    }
    return _firstPic;
}

- (UIImageView *)secondPic {
    if (_secondPic==nil) {
        self.secondPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"icon_details"];

    }
    return _secondPic;
}

- (UILabel *)firstLB {
    if (_firstLB==nil) {
        self.firstLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(16)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _firstLB;
}

- (UILabel *)secondLB {
    if (_secondLB==nil) {
        self.secondLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(102, 102, 102, 1)
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
                                                      withTextColor:RGBA(102, 102, 102, 1)
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _threeLB;
}
- (UILabel *)fourLB {
    if (_fourLB==nil) {
        self.fourLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@"详情"
                                                      withTextColor:RGBA(0, 118, 225, 1)
                                                           withFont:PINGFANG_FONT_SIZE(10)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentCenter];
        
    }
    return _fourLB;
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
