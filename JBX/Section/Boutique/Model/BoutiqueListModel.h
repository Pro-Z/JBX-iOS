//
//  BoutiqueListModel.h
//  JBX
//
//  Created by 证 on 2018/2/4.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MJBaseModel.h"



/**
 精品tab
 */
@class BoutiqueDataListModel;
@interface BoutiqueListModel : MJBaseModel
@property (nonatomic,strong) NSArray *data;
@end
@interface BoutiqueDataListModel : MJBaseModel
@property (nonatomic,copy) NSString *name;
@end



/**
 精品列表
 */
@class BoutiqueRealDataListModel;
@class BoutiqueRealFanexListListModel;
@interface BoutiqueRealListModel : MJBaseModel
@property (nonatomic,copy) BoutiqueRealDataListModel *data;
@end
@interface BoutiqueRealDataListModel : MJBaseModel
@property (nonatomic,copy) NSArray *fanexList;
@property (nonatomic,strong) NSNumber *total;
@end
@interface BoutiqueRealFanexListListModel : MJBaseModel
@property (nonatomic,copy) NSString *user_name,*pic_path,*presentation;
@property (nonatomic,strong) NSNumber *apply_ts;
@property (nonatomic,strong) NSArray *fanc_flag;
@end









