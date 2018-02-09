//
//  OrderDetalModel.h
//  JBX
//
//  Created by 证 on 2018/2/2.
//  Copyright © 2018年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderDetalDataModel;
@class OrderDetalArgsMapModel;
@interface OrderDetalModel : MJBaseModel
@property (nonatomic,strong) OrderDetalDataModel *data;
@end

@interface OrderDetalDataModel : MJBaseModel
@property (nonatomic,strong) NSMutableArray *tempGraphicalSepcList;
@property (nonatomic,strong) OrderDetalArgsMapModel *argsMap;
@end

@interface OrderDetalArgsMapModel : MJBaseModel
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *byTypeList_2;
@property (nonatomic,strong) NSString *materialType;
@property (nonatomic,strong) NSNumber *materialNum,*totalGraphicalArea,*consumMaterialArea,*graphical_num,*countcuttingnum,*countbendnum,*countgroovingnum;
@end

@interface OrderDetalTempGraphicalSepcListModel : MJBaseModel
@property (nonatomic,strong) NSString *typeChina,*colorChina,*is_linesChina,*issizeChina,*orientationChina,*craftsChina;
@property (nonatomic,strong)NSNumber *thickness_num;
@property (nonatomic,strong) NSArray *widthAndHeightList;
@property (nonatomic,strong) NSArray *grapNameList;
@property (nonatomic,strong) NSArray *filepathList;
@end

// 查看商家列表的model
@class BusListDataModel;
@interface BusListModel : MJBaseModel
@property (nonatomic,strong) NSArray *data;
@end
@interface BusListDataModel : MJBaseModel
@property (nonatomic,strong) NSString *org_name,*remark;
@property (nonatomic,strong) NSNumber *create_ts,*price;
@end

