//
//  UIView+Lazy.m
//  JBX
//
//  Created by 证 on 2017/12/7.
//  Copyright © 2017年 证. All rights reserved.
//

#import "UIView+Lazy.h"

@implementation UIView (Lazy)
+(UIView *)initWithUIViewWithFrame:(CGRect)rect withBackground:(UIColor *)bgColor {
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = bgColor;
    return view;
}

@end
