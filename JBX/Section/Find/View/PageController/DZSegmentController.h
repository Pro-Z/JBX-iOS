//
//  DZSegmentController.h
//  JBX
//
//  Created by 证 on 2017/12/29.
//  Copyright © 2017年 证. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZSegmentView.h"
#import "UIView+DZBadge.h"


NS_ASSUME_NONNULL_BEGIN
@interface DZSegmentController : UIViewController<UIScrollViewDelegate>
/// initial
+ (__nullable instancetype)segmentControllerWithTitles:(NSArray <NSString *>*)titles;
- (__nullable instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@property (nonatomic, strong) NSArray <UIViewController *>*viewControllers;
@property (nonatomic, strong, readonly) DZSegmentView *segmentView;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;
@property (nonatomic, strong, readonly) UIScrollView *containerView;
@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic, getter=isPagingEnabled) BOOL pagingEnabled;
@property (nonatomic, getter=isBounces) BOOL bounces;

/// index
- (void)selectedAtIndex:(void(^)(NSUInteger index, UIButton *button, UIViewController *viewController))indexBlock;
- (void)setSelectedAtIndex:(NSUInteger)index;

/// number badge
- (void)enumerateBadges:(NSArray <NSNumber *>*)badges;
- (void)reduceCurrentBadgeByNumber_1;
- (void)addCurrentBadgeByNumber_1;
- (void)clearCurrentBadge;
- (void)clearAllBadges;

@end

@interface UIViewController (ZWMSegment)
@property (nonatomic, strong, readonly, nullable) DZSegmentController *segmentController;
- (void)addSegmentController:(DZSegmentController *)segment;
@end

NS_ASSUME_NONNULL_END
