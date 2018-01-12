//
//  FindThreeCell.m
//  JBX
//
//  Created by 证 on 2018/1/12.
//  Copyright © 2018年 证. All rights reserved.
//

#import "FindThreeCell.h"


@implementation FindThreeCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLB];
        [self.contentView addSubview:self.timeLB];
        self.contentView.backgroundColor = [UIColor whiteColor];
    
        _weekSelf(weakSelf)
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(15);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.contentView).offset(-16);
        }];
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.width.equalTo(@((SCREEN_WIDTH-32)/3));
        }];
        
        [self.contentView addSubview:self.browserLB];
        
        [_browserLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.timeLB.mas_right).offset(0);
            make.width.equalTo(@((SCREEN_WIDTH-32)/3));
        }];
        
        [self.contentView addSubview:self.communicateLB];
       
        [_communicateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.browserLB.mas_right).offset(0);
            make.width.equalTo(@((SCREEN_WIDTH-32)/3));
        }];
        
        [self.contentView addSubview:self.offerNameLB];
        
        [_offerNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.timeLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.width.equalTo(@(SCREEN_WIDTH/5));
        }];
        
        [self.contentView addSubview:self.offerLB];
        
        [_offerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.timeLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.offerNameLB.mas_right).offset(16);
            make.right.equalTo(weakSelf.contentView).offset(-16);
        }];
        
        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.offerNameLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@10);
        }];
        
        
    }
    return self;
}
- (UILabel *)nameLB {
    if (_nameLB==nil) {
        self.nameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(15)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _nameLB;
}

- (UILabel *)timeLB {
    if (_timeLB==nil) {
        self.timeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(135, 135, 135, 1)
                                                           withFont:PINGFANG_FONT_SIZE(12)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _timeLB;
}
- (UILabel *)browserLB {
    if (_browserLB==nil) {
        self.browserLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(135, 135, 135, 1)
                                                           withFont:PINGFANG_FONT_SIZE(12)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentCenter];
        
    }
    return _browserLB;
}
- (UILabel *)communicateLB {
    if (_communicateLB==nil) {
        self.communicateLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(135, 135, 135, 1)
                                                           withFont:PINGFANG_FONT_SIZE(12)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentRight];
    }
    return _communicateLB;
}

- (UILabel *)offerNameLB {
    if (_offerNameLB==nil) {
       self.offerNameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                                              withText:@""
                                                                         withTextColor:RGBA(135, 135, 135, 1)
                                                                              withFont:PINGFANG_FONT_SIZE(14)
                                                                           withGbColor:[UIColor whiteColor]
                                                                     withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _offerNameLB;
}

- (UILabel *)offerLB {
    if (_offerLB==nil) {
        self.offerLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(3, 115, 228, 1)
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _offerLB;
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
