//
//  UIButton+Lazy.h
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Lazy)

+ (UIButton*)initButtonWithButtonType:(UIButtonType)buttonType
                            withFrame:(CGRect)frame
                            withTitle:(NSString*)title
                       withTitleColor:(UIColor*)titleColor;
+ (UIButton*)initButtonWithButtonType:(UIButtonType)buttonType
                           withFrame:(CGRect)frame
                           withTitle:(NSString *)title
                      withTitleColor:(UIColor *)titleColor
                              withGB:(UIColor*)GBColor;
+ (UIButton*)initButtonWithButtonType:(UIButtonType)buttonType
                           withFrame:(CGRect)frame
                           withTitle:(NSString *)title
                      withTitleColor:(UIColor *)titleColor
                               withGB:(UIColor*)GBColor
                             withFont:(UIFont*) font;

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
- (void)setItemImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

@end
