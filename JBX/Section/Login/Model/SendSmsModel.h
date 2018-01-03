//
//  SendSmsModel.h
//  JBX
//
//  Created by 证 on 2017/12/13.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SendSmsModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *toPhone;
- (NSString *)checkIsEmpty;
@end
