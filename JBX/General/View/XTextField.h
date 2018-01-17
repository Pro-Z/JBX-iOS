//
//  XTextField.h
//  JBX
//
//  Created by 证 on 2018/1/15.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTextField : UITextView
@property (nonatomic,copy)NSString *placehoder;
@property (nonatomic,strong)UIColor *placehoderColor;
@property (nonatomic,assign)BOOL isAutoHeight;
@end
