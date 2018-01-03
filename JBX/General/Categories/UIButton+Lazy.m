//
//  UIButton+Lazy.m
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import "UIButton+Lazy.h"

@implementation UIButton (Lazy)

+ (UIButton *)initButtonWithButtonType:(UIButtonType)buttonType
                             withFrame:(CGRect)frame
                             withTitle:(NSString *)title
                        withTitleColor:(UIColor *)titleColor {
    UIButton *button = [UIButton initButtonWithButtonType:buttonType withFrame:frame withTitle:title withTitleColor:titleColor];
    return button;
}

+ (UIButton *)initButtonWithButtonType:(UIButtonType)buttonType
                             withFrame:(CGRect)frame
                             withTitle:(NSString *)title
                        withTitleColor:(UIColor *)titleColor
                                withGB:(UIColor *)GBColor{
    UIButton *button = [UIButton initButtonWithButtonType:buttonType withFrame:frame withTitle:title withTitleColor:titleColor withGB:GBColor];
    return button;
}

+ (UIButton *)initButtonWithButtonType:(UIButtonType)buttonType
                             withFrame:(CGRect)frame
                             withTitle:(NSString *)title
                        withTitleColor:(UIColor *)titleColor
                                withGB:(UIColor *)GBColor
                              withFont:(UIFont *)font{
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.frame = frame;
    button.backgroundColor = GBColor;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}
- (void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-titleSize.height,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor] ];
    [self.titleLabel setFont:[UIFont systemFontOfSize:11.0] ];
    [self.titleLabel setTextColor:[UIColor blackColor] ];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height - titleSize.height ,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
    
    float sw = 20 / image.size.width;
    float sh = 20 / image.size.height;
    self.imageView.transform = CGAffineTransformMakeScale(sw,sh);
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setItemImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-titleSize.height,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor] ];
    [self.titleLabel setFont:[UIFont systemFontOfSize:11.0] ];
    [self.titleLabel setTextColor:[UIColor whiteColor] ];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height + 5,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
    
    float sw = 20 / image.size.width;
    float sh = 20 / image.size.height;
    self.imageView.transform = CGAffineTransformMakeScale(sw,sh);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



@end
