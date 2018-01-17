//
//  NewsTitleListModel.h
//  JBX
//
//  Created by 证 on 2017/12/27.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsDataArrModel;
@class NewsTitleListDicModel;
@interface NewsTitleListModel : BaseModel
@property (nonatomic,strong) NewsTitleListDicModel *data;
@end

@interface NewsTitleListDicModel : BaseModel
@property (nonatomic,strong) NSArray *EcInformationCat;
@end

@interface NewsDataArrModel : BaseModel
@property (nonatomic,strong) NSString *ids,*key_name;
@end
