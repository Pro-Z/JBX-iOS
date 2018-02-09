//
//  MineOfferListModel.h
//  JBX
//
//  Created by 证 on 2018/1/25.
//  Copyright © 2018年 证. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 我的询价 -- 待询价
 */
@class MineOfferDataModel;
@class MineOfferEnquirylistModel;
@interface MineOfferListModel : BaseModel
@property (nonatomic,strong) MineOfferDataModel *data;
@end

@interface MineOfferDataModel : BaseModel
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSArray *enquirylist;
@end

@interface MineOfferEnquirylistModel : BaseModel
@property (nonatomic,copy) NSString *match_enqu_id;
@property (nonatomic,assign) NSInteger create_ts;
@end

/**
 我的询价 -- 已询价
 */
@class MineRequireAleadDataModel;
@class MineRequireAleadEnquiryListModel;
@interface MineRequireAleadListModel : BaseModel
@property (nonatomic,strong) MineOfferDataModel *data;
@end

@interface MineRequireAleadDataModel : BaseModel
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSArray *enquirylist;
@end

@interface MineRequireAleadEnquiryListModel : BaseModel
@property (nonatomic,copy) NSString *match_enqu_id,*match_resp_id;
@property (nonatomic,assign) NSInteger create_ts,org_count;
@end


/**
 我的报价 -- 待报价
 */
@class MineOfferWaitDataModel;
@class MineOfferWaitisEnquirylistListModel;
@interface MineOfferWaitListModel : BaseModel
@property (nonatomic,strong) MineOfferWaitDataModel *data;
@end
@interface MineOfferWaitDataModel : BaseModel
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSArray *enquirylist;
@end
@interface MineOfferWaitisEnquirylistListModel : BaseModel
@property (nonatomic,copy) NSString *match_enqu_id,*enqu_code,*user_name;
@property (nonatomic,assign) NSInteger create_ts;
@property (nonatomic,copy) NSString *creator;
@end


/**
 * 我的报价 -- 已报价
 */

@class MineOfferAleadDataModel;
@interface MineOfferAleadListModel : BaseModel
@property (nonatomic,strong) MineOfferAleadDataModel *data;
@end
@interface MineOfferAleadDataModel : BaseModel
@property (nonatomic,strong) NSArray *enquirylist;
@property (nonatomic,assign) NSInteger total;
@end
@interface MineOfferAleadIsEnquirylistModel : BaseModel
@property (nonatomic,strong) NSString *creator,*remark,*match_resp_id,*resp_code,*user_name;
@property (nonatomic,assign) NSNumber *price,*create_ts,*modify_ts;
@end

/**
 询价单详情
 */
@class OfferDetailDataMapModel;
@class OfferDetailEnquiryMapModel;
@class OfferDetailItemMapModel;
@interface OfferDetailModel : BaseModel
@property (nonatomic,strong) OfferDetailDataMapModel *data;
@end
@interface OfferDetailDataMapModel : BaseModel
@property (nonatomic,strong) OfferDetailEnquiryMapModel *enquiryMap;
@property (nonatomic,strong) NSArray *itemmap;
@end
@interface OfferDetailEnquiryMapModel : BaseModel
@property (nonatomic,strong) NSString *match_enqu_id,*demands,*remark;
@property (nonatomic,assign) NSInteger day_limit,pickup_day;
@end
@interface OfferDetailItemMapModel : BaseModel
@property (nonatomic,copy) NSString *item_id,*name,*file_path,*respStatus;
@property (nonatomic,assign) NSInteger count;
@end


/**
 订货单详情
 */
@class OrderDetailDataModel;
@class OrderDetailArgsMapModel;
@class OrderDetailTempGraphicalSepcListModel;
@interface OrderDetailListModel : BaseModel
@property (nonatomic,strong) OrderDetailDataModel *data;
@end
@interface OrderDetailDataModel : BaseModel
@property (nonatomic,strong) OrderDetailArgsMapModel *argsMap;
@property (nonatomic,strong) NSArray *tempGraphicalSepcList;
@end
@interface OrderDetailArgsMapModel : BaseModel
@property (nonatomic,strong) NSString *name,*materialType;
//@property (nonatomic,strong) NSArray *byTypeList_2;
@property (nonatomic,strong) NSNumber *materialNum,*totalGraphicalArea,*consumMaterialArea,*graphical_num,*countcuttingnum,*countbendnum,*countgroovingnum;
@end
@interface OrderDetailTempGraphicalSepcListModel : BaseModel
@property (nonatomic,strong) NSString *typeChina,*colorChina,*is_linesChina,*issizeChina,*orientationChina,*craftsChina;
@property (nonatomic,strong)NSNumber *thickness_num;
//@property (nonatomic,strong) NSArray *widthAndHeightList;
//@property (nonatomic,strong) NSArray *grapNameList;
//@property (nonatomic,strong) NSArray *filepathList;
@end

