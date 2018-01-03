//
//  FastModel.m
//  JBX
//
//  Created by 证 on 2017/12/27.
//  Copyright © 2017年 证. All rights reserved.
//

#import "FastModel.h"

@implementation FastModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID": @"id",@"mID": @"id"};
}
+(void)getModel:(NSDictionary *)dict{
    __block NSString *str = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"id"]) {
            return;
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            str = [NSString stringWithFormat:@"%@\n@property (nonatomic,strong)NSArray *%@;",str,key];
        }
        else if([obj isKindOfClass:[NSNumber class]]){
            str = [NSString stringWithFormat:@"%@\n@property (nonatomic,strong)NSNumber *%@;",str,key];
        }
        else if([obj isKindOfClass:[NSDictionary class]]){
            str = [NSString stringWithFormat:@"%@\n@property (nonatomic,strong)NSDictionary *%@;",str,key];
        }
        
        else{
            str = [NSString stringWithFormat:@"%@\n@property (nonatomic,copy)NSString *%@;",str,key];
        }
    }];
    NSLog(@"%@",str);
}
@end
