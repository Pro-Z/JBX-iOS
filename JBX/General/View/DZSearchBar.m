//
//  DZSearchBar.m
//  JBX
//
//  Created by 证 on 2017/12/8.
//  Copyright © 2017年 证. All rights reserved.
//

#import "DZSearchBar.h"

//@interface DZSearchBar ()<UITextFieldDelegate>
//
//@end

@implementation DZSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.size = CGSizeMake(SCREEN_WIDTH - 20, 30);
        self.placeholder = @"资讯搜索";
        self.font = PINGFANG_FONT_SIZE(14);
        self.textColor = RGBA(130, 130, 130, 1);
        self.returnKeyType = UIReturnKeySearch;
//        self.delegate = self;
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

@end
