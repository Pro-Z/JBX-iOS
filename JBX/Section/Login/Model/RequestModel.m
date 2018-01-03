//
//  RequestModel.m
//

#import "RequestModel.h"

@implementation RequestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"status":@"code",
             @"msg":@"msg"
             };
}

@end
