//
//  UITextField+Lazy.h
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Lazy)

+ (UITextField*)initWithTextFiledWithFrame:(CGRect)rect
                          withName:(NSString*)text
                   withPlaceholder:(NSString*)placeholder
                             withHintColor:(UIColor *)hintColor
                              withHintSize:(UIFont *)hintSize
                 withTextAlignment:(NSTextAlignment) textAlignment
                      withFontSize:(UIFont*)font
                     withTextColor:(UIColor*)textColor
                      withDelegate:(id) delegate;

@end
