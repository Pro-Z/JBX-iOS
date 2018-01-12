//
//  LabelWithTFView.m
//  JBX
//
//  Created by 证 on 2018/1/12.
//  Copyright © 2018年 证. All rights reserved.
//

#import "LabelWithTFView.h"

@implementation LabelWithTFView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self = [[bundle loadNibNamed:@"LabelWithTFView" owner:self options:nil] lastObject];
        if (self) {
            self.frame = frame;
            
            
            
        }
    }
    return self;
}
- (void)setTitleLBName:(NSString *)name withSubPlacerholder:(NSString *)placerholder {
    self.titleLB.text = name;
    self.titleTF.placeholder = placerholder;
    self.titleTF.textColor = RGBA(102, 102, 102, 102);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
