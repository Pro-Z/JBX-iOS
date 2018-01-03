//
//  UILabel+Lazy.h
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Lazy)

+ (UILabel *) initUILabelWithFrame:(CGRect)frame
                          withText:(NSString *)text
                     withTextColor:(UIColor *)textColor
                          withFont:(UIFont *) font
                       withGbColor:(UIColor *)gbColor
                 withTextAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *) initUILabelWithFrame:(CGRect)frame
                          withText:(NSString *)text
                     withTextColor:(UIColor *)textColor
                       withGbColor:(UIColor *)gbColor
                 withTextAlignment:(NSTextAlignment)textAlignment;

@end
