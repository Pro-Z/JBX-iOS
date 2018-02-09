//
//  BoutiqueCell.h
//  JBX
//
//  Created by 证 on 2018/1/18.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoutiqueCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *headerPic,*partPic;
@property (nonatomic,strong) UILabel *nameLB,*timeLB,*contentLB;
@property (nonatomic,strong) UILabel *firstBTN,*secondBTN;
- (CGFloat)heightForCellWithContent:(NSString*)text;
@end
