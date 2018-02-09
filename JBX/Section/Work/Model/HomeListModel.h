//
//  HomeListModel.h
//  JBX
//
//  Created by 证 on 2018/2/8.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MJBaseModel.h"

@interface HomeListModel : MJBaseModel

@end

// 首页登录解析
@class HomeLoginDataModel;
@class HomeLoginOtherModel;
@interface HomeLoginModel : MJBaseModel
@property (nonatomic,strong) HomeLoginDataModel *data;
@property (nonatomic,strong) NSArray *otherData;
@end

@interface HomeLoginDataModel : MJBaseModel
@property (nonatomic,strong) NSString *token,*userId,*userName;
@end
@interface HomeLoginOtherModel : MJBaseModel
@property (nonatomic,strong) NSString *name,*org_id;
@end

// 首页数据统计
@class HomeAdvertiseDataModel;
@class HomeAdvertiseBannerListModel;
@class HomeAdvertiseOrgListModel;
@class HomeAdvertiseRealListModel;
@interface HomeAdvertiseModel : MJBaseModel
@property (nonatomic,strong) HomeAdvertiseDataModel *data;
@end

@interface HomeAdvertiseDataModel : MJBaseModel
@property (nonatomic,strong) NSNumber *itemTotal,*userTotal,*matchinfoTotal,*informationTotal;
@property (nonatomic,strong) NSArray *top_pic_list,*orgList,*realtimeList;
@end

@interface HomeAdvertiseBannerListModel : MJBaseModel
@property (nonatomic,strong) NSString *picUrl;
@end

@interface HomeAdvertiseOrgListModel : MJBaseModel
@property (nonatomic,strong) NSString *name,*logo,*address,*contact_person,*shop_phone;
@end

@interface HomeAdvertiseRealListModel : MJBaseModel
@property (nonatomic,strong) NSNumber *count,*create_ts;
@property (nonatomic,strong) NSString *org_name;
@end










