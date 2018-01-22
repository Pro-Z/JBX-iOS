//
//  OfferListCell.h
//  JBX
//
//  Created by 证 on 2018/1/22.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferListCell : UITableViewCell
-(void)setCellTypeWithNumber:(NSInteger)type;

@property (nonatomic,strong) UILabel *orderNumberLB,*nameLB,*publishTimeLB,*orderTimeLB,*totalMonryLB,*priceLB,*remarkLB,*totalBussnessLB;
@end
