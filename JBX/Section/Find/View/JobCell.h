//
//  JobCell.h
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLab,*priceLab,*expericeLab,*commitLab,*timeLab,*companyLab;
@property (nonatomic,strong) UIButton *applyBtn;
@end
