//
//  NSString+Lazy.m
//  JBX
//
//  Created by 证 on 2017/12/4.
//  Copyright © 2017年 证. All rights reserved.
//

#import "NSString+Lazy.h"

@implementation NSString (Lazy)


/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(UILabel *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

// measure Width
+ (CGFloat)measureTextWidth:(NSString *)text withFontSize:(CGFloat)fontsize {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]}
                                     context:nil];
    return rect.size.width;
}
// measure Height
+ (CGFloat)measureTextHeight:(NSString *)text withFontSize:(CGFloat)fontSize {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}

+ (CGFloat)measureTextHeight:(NSString *)text withFontSize:(CGFloat)fontSize withWidth:(CGFloat)width{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}


+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *tempString = [NSMutableString stringWithString:jsonStr];
    NSString *attachString = [tempString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return attachString;
}

+ (NSString *)arrayToJsonString:(NSArray *)array {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *tempString = [NSMutableString stringWithString:jsonStr];
    NSString *attachString = [tempString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return attachString;
}

// 判断字符串是否为纯浮点数
+ (BOOL)isPureFloat:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

// 纯整数
+ (BOOL)isPureInteger:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    NSInteger val;
    return[scan scanInteger:&val] && [scan isAtEnd];
}

@end
