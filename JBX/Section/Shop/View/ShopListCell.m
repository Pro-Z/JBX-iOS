//
//  ShopListCell.m
//  JBX
//
//  Created by 证 on 2017/12/11.
//  Copyright © 2017年 证. All rights reserved.
//

#import "ShopListCell.h"
#import "ShopListItemCell.h"
@implementation ShopListCell

- (void)setFirstTxt:(NSString *)firstTxt withFirstPic:(NSString *)firstPicName {
    self.firstIconPic.image = [UIImage imageNamed:firstPicName];
    self.firstLabel.text = firstTxt;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化界面
        [self.contentView addSubview:self.firstIconPic];
        [self.contentView addSubview:self.firstLabel];
        [self.contentView addSubview:self.goPic];
//        self.backgroundColor = [UIColor grayColor];
//        _firstIconPic.backgroundColor = [UIColor redColor];
//        _firstLabel.backgroundColor = [UIColor greenColor];
//        _goPic.backgroundColor = [UIColor blueColor];
        _weekSelf(weakSelf)
        [_firstIconPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(17);
            make.left.equalTo(weakSelf.contentView).offset(5);
//            make.rightMargin.equalTo(weakSelf.firstLabel.mas_left).offset(-10);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(17);
            make.left.equalTo(weakSelf.firstIconPic.mas_right).offset(10);
            make.right.equalTo(weakSelf.contentView).offset(-30);
            make.height.equalTo(@22);
        }];
        [_goPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView).offset(21);
            make.right.equalTo(weakSelf.contentView).offset(-10);
            make.height.equalTo(@14);
            make.width.equalTo(@10);
        }];
        
        UIView *lineView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(243, 243, 243, 1)];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.firstLabel.mas_bottom).offset(15);
            make.left.equalTo(weakSelf.contentView).offset(5);
            make.right.equalTo(weakSelf.contentView).offset(0);
            make.height.equalTo(@2);
        }];
        
        [self.contentView addSubview:self.horiztalCollectionView];
        _horiztalCollectionView.backgroundColor = [UIColor whiteColor];
        [_horiztalCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(0);
            make.left.equalTo(weakSelf.contentView).offset(5);
            make.right.equalTo(weakSelf.contentView).offset(12);
//            make.height.equalTo(@170);
            make.bottom.equalTo(weakSelf.contentView).offset(-20);
        }];
        UIView *bottomView = [UIView initWithUIViewWithFrame:CGRectZero withBackground:RGBA(243, 243, 243, 1)];
        [self.contentView addSubview:bottomView];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(weakSelf.horiztalCollectionView.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.contentView).offset(0);
            make.right.equalTo(weakSelf.contentView).offset(0);
//            make.height.equalTo(@10);
            make.bottom.equalTo(weakSelf.contentView).offset(0);
        }];
        
    
        
        
    }
    return self;
}

- (UIImageView *)firstIconPic {
    if (_firstIconPic == nil) {
        self.firstIconPic = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _firstIconPic;
}

- (UILabel *)firstLabel {
    if (_firstLabel == nil) {
        self.firstLabel = [UILabel initUILabelWithFrame:CGRectZero
                                               withText:@"测试标题"
                                          withTextColor:RGBA(34, 34, 34, 1)
                                               withFont:PINGFANG_FONT_SIZE(15)
                                            withGbColor:[UIColor whiteColor]
                                      withTextAlignment:NSTextAlignmentLeft];
    }
    return _firstLabel;
}
- (UIImageView *)goPic {
    if (_goPic == nil) {
        self.goPic = [UIImageView initWithImageViewWithFrame:CGRectZero withImageName:@"shop_tit_more"];
    }
    return _goPic;
}

- (UICollectionView *)horiztalCollectionView {
    if (_horiztalCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:(UICollectionViewScrollDirectionHorizontal)];
        self.horiztalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _horiztalCollectionView.delegate = self;
        _horiztalCollectionView.dataSource = self;
        _horiztalCollectionView.bounces = NO;
        
        _horiztalCollectionView.showsHorizontalScrollIndicator = NO;
        [_horiztalCollectionView registerClass:[ShopListItemCell class] forCellWithReuseIdentifier:@"ShopListItemCell"];
    }
    return _horiztalCollectionView;
}

#pragma mark -- collectionView dataSource

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopListItemCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    //        // 头部
    //        WWCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
    //        view.headerLabel.text = [NSString stringWithFormat:@"头部 - %zd",indexPath.section];
    //        return view;
    //
    //    }else {
    //        // 底部
    //        WWCollectionFooterReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
    //        view.footerLabel.text = [NSString stringWithFormat:@"底部 - %zd",indexPath.section];
    //        return view;
    //    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 150);
}

///** 头部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 40);
//}
//
///** 顶部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 40);
//}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
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
