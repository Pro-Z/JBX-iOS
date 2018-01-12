//
//  SelectWordView.h
//  JBX
//
//  Created by 证 on 2018/1/12.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectWordView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLB;
- (void) setTitleLBName:(NSString*)name withSubTitle:(NSString*)subTitle;
@end
