//
//  SendSmsModel.m
//  JBX
//
//  Created by 证 on 2017/12/13.
//  Copyright © 2017年 证. All rights reserved.
//

#import "SendSmsModel.h"

@implementation SendSmsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"toPhone":@"toPhone"
             };
}
- (NSString *)checkIsEmpty {
    if (!_toPhone || _toPhone.length<=0) {
        return @"手机号不能为空!";
    }
    return nil;
}

@end
