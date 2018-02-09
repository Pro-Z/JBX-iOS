//
//  RealTradeView.m
//  JBX
//
//  Created by 证 on 2018/2/9.
//  Copyright © 2018年 证. All rights reserved.
//

#import "RealTradeView.h"

@implementation RealTradeView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLB];
        [self.contentView addSubview:self.numberLB];
        [self.contentView addSubview:self.timeLB];
        _weekSelf(weakSelf)
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(7);
            make.left.equalTo(weakSelf.contentView).offset(15);
            make.width.equalTo(@((SCREEN_WIDTH-32)/6*2));
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
        
        [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(7);
            make.left.equalTo(weakSelf.nameLB.mas_right).offset(0);
            make.width.equalTo(@((SCREEN_WIDTH-32)/6*2));
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
        
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(7);
            make.left.equalTo(weakSelf.numberLB.mas_right).offset(0);
            make.width.equalTo(@((SCREEN_WIDTH-32)/6*1.5));
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
        
        
    }
    return self;
}
- (UILabel *)nameLB {
    if (_nameLB==nil) {
        self.nameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(12)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentCenter];
    }
    return _nameLB;
}

- (UILabel *)numberLB {
    if (_numberLB==nil) {
        self.numberLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@""
                                      withTextColor:[UIColor blackColor]
                                           withFont:PINGFANG_FONT_SIZE(12)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentCenter];
    }
    return _numberLB;
}

- (UILabel *)timeLB {
    if (_timeLB==nil) {
        self.timeLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(12)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentCenter];
    }
    return _timeLB;
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
