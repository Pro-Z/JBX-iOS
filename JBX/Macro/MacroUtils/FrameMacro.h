//
//  FrameMacro.h
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#ifndef FrameMacro_h
#define FrameMacro_h

#pragma mark - Screen Frame Macro

// 应用程序Frame
#define APP_FRAME                           [[UIScreen mainScreen] applicationFrame]
#define APP_FRAME_HIGHT                     [[UIScreen mainScreen] applicationFrame].size.height
#define APP_FRAME_WIDTH                     [[UIScreen mainScreen] applicationFrame].size.width
#define APP_BOUNDS                          CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)
#define KEY_WINDOW                          [[UIApplication sharedApplication] keyWindow]

// 屏幕尺寸
#define SCREEN_WIDTH                        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT                        [UIScreen mainScreen].bounds.size.height
#define WIDTHFACTOR                         (SCREEN_WIDTH/320) // 放大系数

// 状态栏高度
#define STATUS_BAR_HEIGHT                   [[UIApplication sharedApplication] statusBarFrame].size.height
// 标题栏高度
#define NAVIGATION_HEIGHTS                  self.navigationController.navigationBar.frame.size.height

#pragma mark - View Frame Macro
// View 坐标(x,y), 宽高(width,height)
#define VIEWFRAME(x,y,w,h)                  CGRectMake(x,y,w,h)
#define ViewX(view)                         view.frame.origin.x
#define ViewY(view)                         view.frame.origin.y
#define ViewWidth(view)                     view.frame.size.width
#define ViewHeight(view)                    view.frame.size.height

// View 坐标(x,y)的最小值,中间值和最大值
#define GetViewMinX(v)                     CGRectGetMinX((v).frame)
#define GetViewMinY(v)                     CGRectGetMinY((v).frame)

#define GetViewMidX(v)                     CGRectGetMidX((v).frame)
#define GetViewMidY(v)                     CGRectGetMidY((v).frame)

#define GetViewMaxX(v)                     CGRectGetMaxX((v).frame)
#define GetViewMaxY(v)                     CGRectGetMaxY((v).frame)

// View 上下左右(Top,Left,Bottom,Right)
#define View_Left(view)                     view.frame.origin.x
#define View_Top(view)                      view.frame.origin.y
#define View_Bottom(view)                   (view.frame.origin.y + view.frame.size.height)
#define View_Right(view)                    (view.frame.origin.x + view.frame.size.width)

#define EdgeInset(Top,Left,Bottom,Right)    UIEdgeInsetsMake((Top), (Left), (Bottom), (Right))

#endif /* FrameMacro_h */
