//
//  OrderDetailListCell.m
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import "OrderDetailListCell.h"

@implementation OrderDetailListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.firstPic];
        _weekSelf(weakSelf);
        [_firstPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(26);
            make.width.equalTo(@85);
            make.height.equalTo(@85);
        }];
        [self.contentView addSubview:self.materialLB];
        
        [_materialLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.width.equalTo(@((SCREEN_WIDTH-147)/2));
        }];
        
        
        [self.contentView addSubview:self.heightLB];
        [_heightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.materialLB.mas_right).offset(0);
            make.width.equalTo(@((SCREEN_WIDTH-147)/2));
        }];
        
        
        [self.contentView addSubview:self.itchLB];
        [_itchLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.materialLB.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.width.equalTo(@((SCREEN_WIDTH-147)/2));
        }];
        
        [self.contentView addSubview:self.towardLB];
        [_towardLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.heightLB.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.itchLB.mas_right).offset(0);
            make.width.equalTo(@((SCREEN_WIDTH-147)/2));
        }];
        
        [self.contentView addSubview:self.colorLB];
        [_colorLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.itchLB.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-26);
        }];
        [self.contentView addSubview:self.profileLB];
        [_profileLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.colorLB.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-26);
        }];
        
        [self.contentView addSubview:self.technologyLB];
        [_technologyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.profileLB.mas_bottom).offset(5);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-26);
        }];
        [self.contentView addSubview:self.xlwidthLB];
        [_xlwidthLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.technologyLB.mas_bottom).offset(5);
            make.right.equalTo(weakSelf.contentView).offset(-26);
            make.left.equalTo(weakSelf.firstPic.mas_right).offset(10);
        }];
        

        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(242, 242, 242, 1)];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.xlwidthLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(16);
            make.right.equalTo(weakSelf.contentView).offset(-16);
            make.height.equalTo(@1);
            make.bottom.equalTo(weakSelf.contentView).offset(-10);
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

- (UILabel *)materialLB {
    if (_materialLB==nil) {
        self.materialLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _materialLB;
}

- (UILabel *)heightLB {
    if (_heightLB==nil) {
        self.heightLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _heightLB;
}


- (UILabel *)itchLB {
    if (_itchLB==nil) {
        self.itchLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _itchLB;
}

- (UILabel *)towardLB {
    if (_towardLB==nil) {
        self.towardLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _towardLB;
}

- (UILabel *)colorLB {
    if (_colorLB==nil) {
        self.colorLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _colorLB;
}

- (UILabel *)profileLB {
    if (_profileLB==nil) {
        self.profileLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _profileLB;
}

- (UILabel *)technologyLB {
    if (_technologyLB==nil) {
        self.technologyLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _technologyLB;
}

- (UILabel *)xlwidthLB {
    if (_xlwidthLB==nil) {
        self.xlwidthLB = [UILabel initUILabelWithFrame:CGRectZero
                                             withText:@""
                                        withTextColor:[UIColor blackColor]
                                             withFont:PINGFANG_FONT_SIZE(14)
                                          withGbColor:[UIColor whiteColor]
                                    withTextAlignment:NSTextAlignmentLeft];
        _xlwidthLB.numberOfLines = 0;
        
    }
    return _xlwidthLB;
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
