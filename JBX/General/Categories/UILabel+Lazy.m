//
//  UILabel+Lazy.m
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import "UILabel+Lazy.h"

@implementation UILabel (Lazy)

+ (UILabel *)initUILabelWithFrame:(CGRect)frame
                         withText:(NSString *)text
                    withTextColor:(UIColor *)textColor
                      withGbColor:(UIColor *)gbColor
                withTextAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel new] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = gbColor;
    return label;
}

+ (UILabel *)initUILabelWithFrame:(CGRect)frame
                         withText:(NSString *)text
                    withTextColor:(UIColor *)textColor
                         withFont:(UIFont *)font
                      withGbColor:(UIColor *)gbColor
                withTextAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel new] initWithFrame:frame];
    label.text = text;
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.font = font;
    label.backgroundColor = gbColor;
    return label;
}

@end
