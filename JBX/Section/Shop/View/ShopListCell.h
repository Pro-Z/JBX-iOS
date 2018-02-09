//
//  ShopListCell.h
//  JBX
//
//  Created by 证 on 2017/12/11.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIImageView *firstIconPic;
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UIImageView *goPic;
@property (nonatomic,strong) UICollectionView *horiztalCollectionView;
//- (void)setFirstTxt:(NSString*)firstTxt withFirstPic:(NSString*)firstPicName;
- (void)setFirstTxt:(NSString *)firstTxt withFirstPic:(NSString *)firstPicName withFirstPic:(NSArray*)picArr withFirstTxt:(NSArray*)firstsTxt withFirstPrice:(NSArray*)priceArr;

@property (nonatomic,strong) NSMutableArray *firstPicArr,*firstTxtArr,*firstPriceArr;
@end
