//
//  NewsListCell.h
//  JBX
//
//  Created by 证 on 2017/12/10.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeMillsLabel;
@property (nonatomic,strong) UIImageView *rightPic;
@property (nonatomic,strong) UIView *bottomLineView;
-(void)setValueForCellWithtitle:(NSString*)title withAddTime:(NSString*)add_time withPicUrl:(NSString*)picUrl;
@end
