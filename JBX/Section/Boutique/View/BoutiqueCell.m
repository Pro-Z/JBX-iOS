//
//  BoutiqueCell.m
//  JBX
//
//  Created by 证 on 2018/1/18.
//  Copyright © 2018年 证. All rights reserved.
//

#import "BoutiqueCell.h"

@implementation BoutiqueCell

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param value 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(NSString *)value andWidth:(float)width{
//    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
//    return sizeToFit.height;
    
    CGSize titleSize = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    return titleSize.height;
}



- (CGFloat)heightForCellWithContent:(NSString *)text {
    return 94+[self heightForString:text andWidth:(SCREEN_WIDTH-10)/2];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.headerPic];
        _weekSelf(weakSelf);
        [_headerPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(15);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.width.equalTo(@26);
            make.height.equalTo(@26);
        }];
        
        [self.contentView addSubview:self.nameLB];
        
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.headerPic.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.headerPic.mas_right).offset(5);
            make.right.equalTo(weakSelf.contentView).offset(-56);
        }];
        [self.contentView addSubview:self.timeLB];
        
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.headerPic.mas_centerY).offset(0);
            make.left.equalTo(weakSelf.nameLB.mas_right).offset(5);
            make.right.equalTo(weakSelf.contentView).offset(-10);
        }];
       
        [self.contentView addSubview:self.partPic];
        
        [_partPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerPic.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@85);
        }];
        
        [self.contentView addSubview:self.contentLB];
       
        [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.partPic.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-10);
        }];
        
        [self.contentView addSubview:self.firstBTN];
        
        [_firstBTN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.width.equalTo(@40);
        }];
        
        [self.contentView addSubview:self.secondBTN];
        
        [_secondBTN mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.firstBTN.mas_right).offset(10);
            make.width.equalTo(@40);
        }];
        
        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:[UIColor whiteColor]];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.firstBTN.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.bottom.equalTo(weakSelf.contentView);
        }];
        
    }
    return self;
}
- (UIImageView *)headerPic {
    if (_headerPic==nil) {
        self.headerPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
        
        ViewRadius(_headerPic, 13);
    }
    return _headerPic;
}

- (UILabel *)nameLB {
    if (_nameLB==nil) {
        self.nameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(102, 102, 102, 1)
                                                           withFont:PINGFANG_FONT_SIZE(11)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _nameLB;
}
- (UILabel *)timeLB {
    if (_timeLB==nil) {
        self.timeLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:RGBA(102, 102, 102, 1)
                                                           withFont:PINGFANG_FONT_SIZE(9)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentRight];
        
    }
    return _timeLB;
}

- (UIImageView *)partPic {
    if (_partPic==nil) {
        self.partPic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
//        _partPic.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _partPic.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _partPic;
}

- (UILabel *)contentLB {
    if (_contentLB==nil) {
        self.contentLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(10)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentCenter];
         _contentLB.numberOfLines = 0;
    }
    return _contentLB;
}

- (UIButton *)firstBTN {
    if (_firstBTN==nil) {
        self.firstBTN = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                               withFrame:CGRectZero
                                                               withTitle:@""
                                                          withTitleColor:RGBA(3, 115, 228, 1)
                                                                  withGB:[UIColor whiteColor]
                                                                withFont:PINGFANG_FONT_SIZE(9)];
        
        
    }
    return _firstBTN;
}

- (UIButton *)secondBTN {
    if (_secondBTN==nil) {
        self.secondBTN = [UIButton initButtonWithButtonType:(UIButtonTypeCustom)
                                                 withFrame:CGRectZero
                                                 withTitle:@""
                                            withTitleColor:RGBA(3, 115, 228, 1)
                                                    withGB:[UIColor whiteColor]
                                                  withFont:PINGFANG_FONT_SIZE(9)];
        
        
    }
    return _secondBTN;
}


@end
