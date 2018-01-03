//
//  DZSearchBarWithIcon.m
//  JBX
//
//  Created by 证 on 2017/12/11.
//  Copyright © 2017年 证. All rights reserved.
//

#import "DZSearchBarWithIcon.h"

@implementation DZSearchBarWithIcon


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.frame = CGRectMake(10, 29, SCREEN_WIDTH - 61, 30);
        self.backgroundColor = [UIColor whiteColor];
        self.size = CGSizeMake(SCREEN_WIDTH - 61, 30);
        self.placeholder = @"搜索现货、加工商、供应商";
        self.font = PINGFANG_FONT_SIZE(14);
        self.textColor = RGBA(130, 130, 130, 1);
        // 提前在Xcode上设置图片中间拉伸
        //        self.background = [UIImage imageNamed:@"new_nav_search"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"new_nav_search"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.size = CGSizeMake(30, 30);
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        ViewBorderRadius(self,13,1,APP_COLOR_BASE_NAV);
    }
    return self;
}

+ (instancetype)searchBar {
    return [[self alloc] init];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
