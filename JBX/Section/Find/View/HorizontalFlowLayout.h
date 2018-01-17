//
//  HorizontalFlowLayout.h
//  JBX
//
//  Created by 证 on 2018/1/16.
//  Copyright © 2018年 证. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalFlowLayout : UICollectionViewFlowLayout
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;
@property (strong, nonatomic) NSMutableArray *allAttributes;
@end
