//
//  AdverFootCell.m
//  JBX
//
//  Created by 证 on 2018/2/9.
//  Copyright © 2018年 证. All rights reserved.
//

#import "AdverFootCell.h"

@implementation AdverFootCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.pic];
        _weekSelf(weakSelf);
        [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(15);
            make.left.equalTo(weakSelf.contentView).offset(15);
            make.width.equalTo(@90);
            make.height.equalTo(@90);
        }];
        [self.contentView addSubview:self.nameLB];
        [self.contentView addSubview:self.addressLB];
        [self.contentView addSubview:self.contactLB];
        
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(15);
            make.left.equalTo(weakSelf.pic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-10);
        }];
        [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.pic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-10);
        }];
        [_contactLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.addressLB.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.pic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-10);
        }];
        
    }
    return self;
}
- (UIImageView *)pic {
    if (_pic==nil) {
        self.pic = [UIImageView initWithImageViewWithFrame:CGRectZero
                                                                withImageName:@"placerholder"];
        
    }
    return _pic;
}

- (UILabel *)nameLB {
    if (_nameLB==nil) {
        self.nameLB = [UILabel initUILabelWithFrame:CGRectZero
                                                           withText:@""
                                                      withTextColor:[UIColor blackColor]
                                                           withFont:PINGFANG_FONT_SIZE(14)
                                                        withGbColor:[UIColor whiteColor]
                                                  withTextAlignment:NSTextAlignmentLeft];
        _nameLB.numberOfLines = 0;
    }
    return _nameLB;
}

- (UILabel *)addressLB {
    if (_addressLB==nil) {
        self.addressLB = [UILabel initUILabelWithFrame:CGRectZero
                                           withText:@""
                                      withTextColor:[UIColor grayColor]
                                           withFont:PINGFANG_FONT_SIZE(12)
                                        withGbColor:[UIColor whiteColor]
                                  withTextAlignment:NSTextAlignmentLeft];
        _addressLB.numberOfLines = 0;
    }
    return _addressLB;
}

- (UILabel *)contactLB {
    if (_contactLB==nil) {
        self.contactLB = [UILabel initUILabelWithFrame:CGRectZero
                                              withText:@""
                                         withTextColor:[UIColor grayColor]
                                              withFont:PINGFANG_FONT_SIZE(12)
                                           withGbColor:[UIColor whiteColor]
                                     withTextAlignment:NSTextAlignmentLeft];
        _contactLB.numberOfLines = 0;
    }
    return _contactLB;
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
