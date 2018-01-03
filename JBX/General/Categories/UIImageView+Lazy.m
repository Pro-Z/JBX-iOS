//
//  UIImageView+Lazy.m
//  JBX
//
//  Created by 证 on 2017/12/7.
//  Copyright © 2017年 证. All rights reserved.
//

#import "UIImageView+Lazy.h"

@implementation UIImageView (Lazy)

+ (UIImageView *)initWithImageViewWithFrame:(CGRect)rect withImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

@end
