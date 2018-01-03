//
//  NewsTitleListModel.h
//  JBX
//
//  Created by 证 on 2017/12/27.
//  Copyright © 2017年 证. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsDataArrModel;
@interface NewsTitleListModel : BaseModel
@property (nonatomic,strong) NSArray *data;
@end
@interface NewsDataArrModel : BaseModel
@property (nonatomic,strong) NSString *ids,*key_name;
@end
