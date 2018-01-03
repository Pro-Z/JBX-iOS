//
//  MineListCell.h
//  JBX
//
//  Created by 证 on 2017/12/12.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineListCell : UITableViewCell
@property (nonatomic,strong) UIImageView *itemPic;
@property (nonatomic,strong) UILabel *itemTxt;
@property (nonatomic,strong) UIImageView *goPic;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,assign) NSInteger otherIndexs;
- (void)setOtherIndexForCell:(NSInteger)otherIndex withItemPic:(NSString *)picName withItemTxt:(NSString *)text;
@end
