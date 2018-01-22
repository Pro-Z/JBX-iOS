//
//  OfferListAutoSizeCell.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "OfferListAutoSizeCell.h"

@implementation OfferListAutoSizeCell


- (void)initSecondCell {
    _weekSelf(weakSelf);
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(236, 238, 241, 1)];
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(0);
        make.left.equalTo(weakSelf.contentView).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(0);
        make.height.equalTo(@10);
    }];
    [self.contentView addSubview:self.orderNumberLB];
    [_orderNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.right.equalTo(weakSelf.contentView).offset(-16);
    }];
    [self.contentView addSubview:self.nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderNumberLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.right.equalTo(weakSelf.contentView).offset(-16);
    }];
    [self.contentView addSubview:self.publishTimeLB];
    [_publishTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.right.equalTo(weakSelf.contentView).offset(-16);
        //        make.bottom.equalTo(weakSelf.contentView).offset(-10);
    }];
    UIView *lineView2 = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
    [self.contentView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publishTimeLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(0);
        make.height.equalTo(@1);
    }];
    [self.contentView addSubview:self.orderTimeLB];
    [_orderTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.width.equalTo(@((SCREEN_WIDTH-32)/2));
    }];
    [self.contentView addSubview:self.totalMonryLB];
    [_totalMonryLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.orderTimeLB.mas_right).offset(0);
        make.width.equalTo(@((SCREEN_WIDTH-32)/4));
    }];
    [self.contentView addSubview:self.priceLB];
    [_priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.totalMonryLB.mas_right).offset(0);
        make.right.equalTo(weakSelf.contentView).offset(-16);
    }];
    [self.contentView addSubview:self.remarkLB];
    [_remarkLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderTimeLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.right.equalTo(weakSelf.contentView).offset(-16);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10);
    }];
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSecondCell];
    }
    return self;
}

- (UILabel *)orderNumberLB {
    if (_orderNumberLB==nil) {
        self.orderNumberLB = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@""
                                             withTextColor:[UIColor blackColor]
                                                  withFont:PINGFANG_FONT_SIZE_BOLD(15)
                                               withGbColor:[UIColor whiteColor]
                                         withTextAlignment:NSTextAlignmentLeft];
    }
    return _orderNumberLB;
}
- (UILabel *)nameLB {
    if (_nameLB==nil) {
        self.nameLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@""
                                      withTextColor:RGBA(102, 102, 102, 1)
                                           withFont:PINGFANG_FONT_SIZE(14)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _nameLB;
}


- (UILabel *)publishTimeLB {
    if (_publishTimeLB==nil) {
        self.publishTimeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                  withText:@""
                                             withTextColor:RGBA(102, 102, 102, 1)
                                                  withFont:PINGFANG_FONT_SIZE(14)
                                               withGbColor:[UIColor whiteColor]
                                         withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _publishTimeLB;
}
- (UILabel *)orderTimeLB {
    if (_orderTimeLB==nil) {
        self.orderTimeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                withText:@""
                                           withTextColor:RGBA(102, 102, 102, 1)
                                                withFont:PINGFANG_FONT_SIZE(14)
                                             withGbColor:[UIColor whiteColor]
                                       withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _orderTimeLB;
}
- (UILabel *)totalMonryLB {
    if (_totalMonryLB==nil) {
        self.totalMonryLB = [UILabel initUILabelWithFrame:CGRectZero
                                                 withText:@""
                                            withTextColor:RGBA(102, 102, 102, 1)
                                                 withFont:PINGFANG_FONT_SIZE(14)
                                              withGbColor:[UIColor whiteColor]
                                        withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _totalMonryLB;
}
- (UILabel *)priceLB {
    if (_priceLB==nil) {
        self.priceLB = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@""
                                       withTextColor:RGBA(0, 118, 255, 1)
                                            withFont:PINGFANG_FONT_SIZE(16)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentCenter];
        
    }
    return _priceLB;
}
- (UILabel *)remarkLB {
    if (_remarkLB==nil) {
        self.remarkLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:RGBA(102, 102, 102, 1)
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        _remarkLB.numberOfLines = 0;
    }
    return _remarkLB;
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
