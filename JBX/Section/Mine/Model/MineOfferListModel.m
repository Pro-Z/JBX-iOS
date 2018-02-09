//
//  MineOfferListModel.m
//  JBX
//
//  Created by 证 on 2018/1/25.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MineOfferListModel.h"



/**
 我的询价 -- 带询价
 */
@implementation MineOfferListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}

@end

@implementation MineOfferDataModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"enquirylist":@"enquirylist",
             @"total":@"total"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MineOfferEnquirylistModel.class];
}


//+(NSValueTransformer*)enquirylistJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:MineOfferEnquirylistModel.class];
//}

@end

@implementation MineOfferEnquirylistModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"create_ts":@"create_ts",
             @"match_enqu_id":@"match_enqu_id"
             };
}



@end

/**
 我的询价 -- 已询价
 */
@implementation MineRequireAleadListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}

@end

@implementation MineRequireAleadDataModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"enquirylist":@"enquirylist",
             @"total":@"total"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MineRequireAleadEnquiryListModel.class];
}

@end

@implementation MineRequireAleadEnquiryListModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"create_ts":@"create_ts",
             @"match_enqu_id":@"match_enqu_id",
             @"match_resp_id":@"match_resp_id",
             @"org_count":@"org_count"
             };
}



@end



/**
 我的报价 -- 待报价
 */
@implementation MineOfferWaitListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}

@end

@implementation MineOfferWaitDataModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"enquirylist":@"enquirylist",
             @"total":@"total"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MineOfferWaitisEnquirylistListModel.class];
}


//+(NSValueTransformer*)enquirylistJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:MineOfferEnquirylistModel.class];
//}

@end

@implementation MineOfferWaitisEnquirylistListModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"create_ts":@"create_ts",
             @"match_enqu_id":@"match_enqu_id",
             @"creator":@"creator",
             @"user_name":@"user_name",
             @"enqu_code":@"enqu_code"
             };
}
@end

/**
 我的报价 -- 已报价
 */
@implementation MineOfferAleadListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}

@end

@implementation MineOfferAleadDataModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"enquirylist":@"enquirylist",
             @"total":@"total"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MineOfferAleadIsEnquirylistModel.class];
}
@end

@implementation MineOfferAleadIsEnquirylistModel : BaseModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"create_ts":@"create_ts",
             @"creator":@"creator",
             @"remark":@"remark",
             @"match_resp_id":@"match_resp_id",
             @"price":@"price",
             @"modify_ts":@"modify_ts",
             @"resp_code":@"resp_code",
             @"user_name":@"user_name"
             };
}
@end



/**
 询价单详情
 */
@implementation OfferDetailModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}
@end
@implementation OfferDetailDataMapModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"enquiryMap":@"enquiryMap",
             @"itemmap":@"itemmap"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:OfferDetailItemMapModel.class];
}
@end
@implementation OfferDetailEnquiryMapModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"match_enqu_id":@"match_enqu_id",
             @"demands":@"demands",
             @"remark":@"remark",
             @"day_limit":@"day_limit",
             @"pickup_day":@"pickup_day"
             };
}
@end
@implementation OfferDetailItemMapModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"item_id":@"item_id",
             @"name":@"name",
             @"file_path":@"file_path",
             @"count":@"count",
             @"respStatus":@"respStatus"
             };
}

@end



/**
 报价单详情
 */
@implementation OrderDetailListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code":@"code",
             @"msg":@"msg",
             @"data":@"data"
             };
}
@end
@implementation OrderDetailDataModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"argsMap":@"argsMap",
             @"tempGraphicalSepcList":@"tempGraphicalSepcList"
             };
}
+(NSValueTransformer*)dataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:OrderDetailTempGraphicalSepcListModel.class];
}
@end
@implementation OrderDetailArgsMapModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"name",
             @"materialType":@"materialType",
//             @"byTypeList_2":@"byTypeList_2",
             @"materialNum":@"materialNum",
             @"totalGraphicalArea":@"totalGraphicalArea",
             @"consumMaterialArea":@"consumMaterialArea",
             @"graphical_num":@"graphical_num",
             @"countcuttingnum":@"countcuttingnum",
             @"countbendnum":@"countbendnum",
             @"countgroovingnum":@"countgroovingnum"
             };
}

@end
@implementation OrderDetailTempGraphicalSepcListModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"typeChina":@"typeChina",
             @"colorChina":@"colorChina",
             @"is_linesChina":@"is_linesChina",
             @"issizeChina":@"issizeChina",
             @"orientationChina":@"orientationChina",
             @"craftsChina":@"craftsChina",
             @"thickness_num":@"thickness_num"
//             @"widthAndHeightList":@"widthAndHeightList",
//             @"grapNameList":@"grapNameList",
//             @"filepathList":@"filepathList"
             };
}
@end




