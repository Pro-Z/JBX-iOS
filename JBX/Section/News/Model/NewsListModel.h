//
//  NewsListModel.h
//  JBX
//
//  Created by 证 on 2017/12/29.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsDataListModel;
@class NewsEcInformationArrModel;
@interface NewsListModel : BaseModel
@property (nonatomic,strong) NewsDataListModel *data;
@end

@interface NewsDataListModel : BaseModel
@property (nonatomic,assign) NSNumber *total;
@property (nonatomic,strong) NSArray *EcInformation;
@end

@interface NewsEcInformationArrModel : BaseModel
@property (nonatomic,strong) NSString *add_time,*content,*imgUrl,*title,*ids;
@end
