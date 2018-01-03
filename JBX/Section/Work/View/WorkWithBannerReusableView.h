//
//  WorkWithBannerReusableView.h
//  JBX
//
//  Created by 证 on 2017/12/8.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkWithBannerReusableView : UICollectionReusableView<SDCycleScrollViewDelegate>
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) SDCycleScrollView *bannerSV;
- (void) setTitle:(NSString*)title;
@end
