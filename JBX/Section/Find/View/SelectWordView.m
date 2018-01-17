//
//  SelectWordView.m
//  JBX
//
//  Created by 证 on 2018/1/12.
//  Copyright © 2018年 证. All rights reserved.
//

#import "SelectWordView.h"

@implementation SelectWordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        self = [[bundle loadNibNamed:@"SelectWordView" owner:self options:nil] lastObject];
        if (self) {
            self.frame = frame;
            self.subtitleLB.text = _text;
            
            
        }
    }
    return self;
}
- (void)setText:(NSString *)text {
    self.subtitleLB.text = text;
}

- (void)setTitleLBName:(NSString *)name withSubTitle:(NSString *)subTitle{
    self.titleLB.text = name;
    self.subtitleLB.text = subTitle;
    self.subtitleLB.textAlignment = NSTextAlignmentRight;
    self.subtitleLB.textColor = RGBA(102, 102, 102, 1);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
