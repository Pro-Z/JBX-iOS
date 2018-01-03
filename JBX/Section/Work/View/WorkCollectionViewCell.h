//
//  WorkCollectionViewCell.h
//  JBX
//
//  Created by 证 on 2017/12/8.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *workIcon;
@property (nonatomic,strong) UILabel *subTitleLabel;
- (void) setWorkIcon:(NSString *)workIcon withSubTitle:(NSString*)title;
@property (nonatomic,strong) UIView *bottomView;
@end
