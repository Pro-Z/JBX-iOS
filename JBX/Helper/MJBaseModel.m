//
//  MJBaseModel.m
//  GameManager
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 HGH. All rights reserved.
//

#import "MJBaseModel.h"

@implementation MJBaseModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"mID": @"id"};
}
+(void)getModel:(id)sender{
    if ([sender isKindOfClass:[NSDictionary class]] || [sender isKindOfClass:[NSArray class]]) {
        return;
    }
    NSDictionary *dict = [NSDictionary dictionary];
    if ([sender isKindOfClass:[NSDictionary class]]) {
        dict = (NSDictionary *)sender;
    }
    if ([sender isKindOfClass:[NSArray class]]) {
        NSArray *mArray = (NSArray *)sender;
        if (mArray.count == 0) {
            return;
        }
        if (![mArray[0] isKindOfClass:[NSDictionary class]]) {
            return;
        }
        dict = mArray[0];
    }
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
