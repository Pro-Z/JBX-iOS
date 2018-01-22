//
//  OfferListCell.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "OfferListCell.h"


@implementation OfferListCell



-(void)setCellTypeWithNumber:(NSInteger)type {
    DebugLog(@"当前的CELL为%ld",type);
    switch (type) {
        case 1:
            // 我的报价 -- 待报价
            [self initFirstCell];
            break;
        case 2:
            // 我的报价 -- 已报
//            [self initFirstCell];
//            [self initSecondCell];
            break;
        case 3:
            // 我的询价 -- 待报价
            [self initThreeCell];
            break;
        case 4:
            // 我的询价 -- 已报价
            [self initFourCell];
            break;
        default:
            break;
    }
}

- (void) initFourCell {
    _weekSelf(weakSelf)
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(236, 238, 241, 1)];
    [self.contentView  addSubview:lineView];
    
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
    [self.contentView addSubview:self.totalBussnessLB];
    
    [_totalBussnessLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLB.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.contentView).offset(16);
        make.right.equalTo(weakSelf.contentView).offset(-16);
//        make.bottom.equalTo(weakSelf.contentView).offset(-10);
    }];
    
}

- (void) initThreeCell {
    _weekSelf(weakSelf)
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(236, 238, 241, 1)];
    [self.contentView  addSubview:lineView];
    
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
}

- (void) initFirstCell {
    _weekSelf(weakSelf)
    UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(236, 238, 241, 1)];
    [self.contentView  addSubview:lineView];
    
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
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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

- (UILabel *)totalBussnessLB {
    if (_totalBussnessLB==nil) {
        self.totalBussnessLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(0, 115, 255, 1)
                                                           withFont:PINGFANG_FONT_SIZE(13)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _totalBussnessLB;
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
