//
//  NewsListCell.m
//  JBX
//
//  Created by 证 on 2017/12/10.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NewsListCell.h"

@implementation NewsListCell

-(void)setValueForCellWithtitle:(NSString *)title withAddTime:(NSString *)add_time withPicUrl:(NSString *)picUrl {
    _titleLabel.text = title;
    _timeMillsLabel.text = add_time;
    [_rightPic sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"placerholder"]];
  
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeMillsLabel];
        [self.contentView addSubview:self.rightPic];
        [self.contentView addSubview:self.bottomLineView];
//        self.contentView.backgroundColor = [UIColor grayColor];
//        _titleLabel.backgroundColor = [UIColor greenColor];
//        _timeMillsLabel.backgroundColor = [UIColor redColor];
//        _bottomLineView.backgroundColor = [UIColor redColor];
        _weekSelf(weakSelf)
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.contentView).offset(20);
            make.leftMargin.equalTo(weakSelf.contentView).offset(10);
            make.rightMargin.equalTo(weakSelf.contentView).offset(-159);
            make.height.equalTo(@42);
        }];
        [_timeMillsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(weakSelf.contentView).offset(10);
            make.bottomMargin.equalTo(weakSelf.contentView).offset(-10);
        }];
        [_rightPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.equalTo(weakSelf.contentView).offset(20);
            make.rightMargin.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@90);
            make.width.equalTo(@90);
        }];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottomMargin.equalTo(weakSelf.contentView).offset(-1);
            make.leftMargin.equalTo(weakSelf.contentView).offset(0);
            make.rightMargin.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
    }
    return self;
}


//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//
//
//    }
//    return self;
//}
- (UILabel *)titleLabel {
    if (_titleLabel==nil) {
        self.titleLabel = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"中国成为印度最大进口来源，但近百种商品遭征反倾销"
                                          withTextColor:RGBA(34, 34, 34, 1)
                                               withFont:PINGFANG_FONT_SIZE(15)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (UILabel *)timeMillsLabel {
    if (_timeMillsLabel==nil) {
        self.timeMillsLabel = [UILabel initUILabelWithFrame:CGRectZero
                                                   withText:@"2017.09.26"
                                              withTextColor:RGBA(130, 130, 130, 1)
                                                   withFont:PINGFANG_FONT_SIZE(13)
                                                withGbColor:[UIColor whiteColor]
                                          withTextAlignment:NSTextAlignmentLeft];
    }
    return _timeMillsLabel;
}
- (UIImageView *)rightPic {
    if (_rightPic==nil) {
        self.rightPic = [[UIImageView alloc] init];
        _rightPic.backgroundColor = [UIColor grayColor];
    }
    return _rightPic;
}
- (UIView *)bottomLineView {
    if (_bottomLineView==nil) {
        self.bottomLineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(216, 216, 216, 1)];
    }
    return _bottomLineView;
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
