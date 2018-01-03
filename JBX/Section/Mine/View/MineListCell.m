//
//  MineListCell.m
//  JBX
//
//  Created by 证 on 2017/12/12.
//  Copyright © 2017年 证. All rights reserved.
//

#import "MineListCell.h"

@implementation MineListCell

- (void)setOtherIndexForCell:(NSInteger)otherIndex withItemPic:(NSString *)picName withItemTxt:(NSString *)text{
    _itemTxt.text = text;
    _itemPic.image = [UIImage imageNamed:picName];
    self.otherIndexs = otherIndex;
//    DebugLog(@"输出的坐标%ld",_otherIndexs);
    _weekSelf(weakSelf)
    if (_otherIndexs == 3||_otherIndexs == 7) {
        _lineView.backgroundColor = RGBA(243, 243, 243, 1);
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-2);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@10);
        }];
    }else{
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.itemTxt.mas_left).offset(0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-2);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@1);
        }];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.itemPic];
        [self.contentView addSubview:self.itemTxt];
        [self.contentView addSubview:self.goPic];
        [self.contentView addSubview:self.lineView];
//        _itemPic.backgroundColor = [UIColor redColor];
//        _itemTxt.backgroundColor = [UIColor greenColor];
//        _goPic.backgroundColor = [UIColor blueColor];

        _weekSelf(weakSelf)
        [_itemPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(10);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        [_goPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(15);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@16);
            make.width.equalTo(@12);
        }];
        [_itemTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(10);
            make.left.equalTo(weakSelf.itemPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.goPic.mas_left).offset(-10);
            make.height.equalTo(@25);
        }];
        
        
        
        
    }
    return self;
}

- (UIImageView *)itemPic {
    if (_itemPic == nil) {
        self.itemPic = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _itemPic;
}
- (UILabel *)itemTxt {
    if (_itemTxt == nil) {
        self.itemTxt = [UILabel initUILabelWithFrame:CGRectZero
                                            withText:@"测试标题"
                                       withTextColor:RGBA(34, 34, 34, 34)
                                            withFont:PINGFANG_FONT_SIZE(15)
                                         withGbColor:[UIColor whiteColor]
                                   withTextAlignment:NSTextAlignmentLeft];
    }
    return _itemTxt;
}
- (UIImageView *)goPic {
    if (_goPic == nil) {
        self.goPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"my_list_back"];
    }
    return _goPic;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        self.lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(216, 216, 216, 1)];
    }
    return _lineView;
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
