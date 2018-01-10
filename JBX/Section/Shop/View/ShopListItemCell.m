//
//  ShopListItemCell.m
//  JBX
//
//  Created by 证 on 2017/12/11.
//  Copyright © 2017年 证. All rights reserved.
//

#import "ShopListItemCell.h"

@implementation ShopListItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.itemPic];
        [self.contentView addSubview:self.itemFirstLabel];
        [self.contentView addSubview:self.itemSecondLabel];
//        self.contentView.backgroundColor = [UIColor greenColor];
        _weekSelf(weakSelf)
        [_itemPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@90);
            make.width.equalTo(@90);
        }];
        [_itemFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.itemPic.mas_bottom).offset(15);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@20);
        }];
        [_itemSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.itemFirstLabel.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@20);
        }];
        
    }
    return self;
}
- (UIImageView *)itemPic {
    if (_itemPic == nil) {
        self.itemPic = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemPic.backgroundColor = [UIColor grayColor];
    }
    return _itemPic;
}
- (UILabel *)itemFirstLabel {
    if (_itemFirstLabel == nil) {
        self.itemFirstLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                   withText:@"测试标题"
                                              withTextColor:RGBA(34, 34, 34, 1)
                                                   withFont:PINGFANG_FONT_SIZE(14)
                                                withGbColor:[UIColor whiteColor]
                                          withTextAlignment:NSTextAlignmentLeft];
    }
    return _itemFirstLabel;
}

- (UILabel *)itemSecondLabel {
    if (_itemSecondLabel == nil) {
        self.itemSecondLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                    withText:@"¥500"
                                               withTextColor:RGBA(222, 48, 80, 1)
                                                    withFont:PINGFANG_FONT_SIZE(14)
                                                 withGbColor:[UIColor whiteColor]
                                           withTextAlignment:NSTextAlignmentLeft];
    }
    return _itemSecondLabel;
}




@end
