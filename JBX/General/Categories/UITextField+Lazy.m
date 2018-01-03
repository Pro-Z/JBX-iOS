//
//  UITextField+Lazy.m
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import "UITextField+Lazy.h"

@implementation UITextField (Lazy)
+ (UITextField*)initWithTextFiledWithFrame:(CGRect)rect
                                  withName:(NSString *)text
                           withPlaceholder:(NSString *)placeholder
                             withHintColor:(UIColor *)hintColor
                              withHintSize:(UIFont *)hintSize
                         withTextAlignment:(NSTextAlignment)textAlignment
                              withFontSize:(UIFont *)font
                             withTextColor:(UIColor *)textColor
                              withDelegate:(id)delegate {
    UITextField* textField = [[UITextField alloc] initWithFrame:rect];
    
    
    textField.borderStyle              = UITextBorderStyleNone;
    textField.returnKeyType            = UIReturnKeyDefault;
    textField.text                     = text;
    textField.placeholder              = placeholder;
    
    // 设置placeholder的颜色和大小
    NSMutableAttributedString *placeholders = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [placeholders addAttribute:NSForegroundColorAttributeName
                         value:hintColor
                         range:NSMakeRange(0, placeholder.length)];
    [placeholders addAttribute:NSFontAttributeName
                         value:hintSize
                         range:NSMakeRange(0, placeholder.length)];
    textField.attributedPlaceholder    = placeholders;
    
    textField.clearButtonMode          = UITextFieldViewModeWhileEditing;
    textField.textAlignment            = textAlignment;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate                 = delegate;
    textField.keyboardType             = UIKeyboardTypeDefault;
    textField.keyboardAppearance       = UIKeyboardAppearanceDefault;
    textField.autocapitalizationType   = UITextAutocapitalizationTypeAllCharacters;
    textField.autocorrectionType       = UITextAutocorrectionTypeNo;
    textField.font                     = font;
    textField.textColor                = textColor;
    
//    UIView *paddingView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
//    paddingView.backgroundColor = [UIColor clearColor];
//    textField.leftView                 = paddingView;
//    textField.leftViewMode             = UITextFieldViewModeAlways;
    
    return textField;}
@end
