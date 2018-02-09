//
//  AppMacro.h
//  JBX
//
//  Created by 证 on 2017/12/3.
//  Copyright © 2017年 证. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h



#define COMPANY_NAME                    @"厦门钢鲸科技股份有限公司"

#pragma mark - AppBaseColor
// 基本颜色
// 祖传蓝
#define APP_COLOR_BASE_NAV              [UIColor colorWithRed:48/255.0 green:127/255.0 blue:222/255.0 alpha:1/1.0]
#define APP_COLOR_BASE_HOME_BG       [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.00]
#define APP_COLOR_BASE_TABBAR           [UIColor colorWithRed:78.0f/255.0f green:140.0f/255.0f blue:238.0f/255.0f alpha:1.00]
// 登录输入框Hint字体颜色
#define TEXTFILED_HINT_COLOR            [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1/1.0]

// cell分割线的颜色 #d8d8d8
#define CELL_LINE_GRAY_COLOR            [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1/1.0]

// 平方字体 15号
#define PINGFANG_FONT_SIZE(fontsize)          [UIFont fontWithName:@"PingFangSC-Regular" size:(fontsize)]
#define PINGFANG_FONT_SIZE_BOLD(fontsize)     [UIFont fontWithName:@"PingFangSC-Semibold" size:(fontsize)]

#define WHITE_BG            self.view.backgroundColor = [UIColor whiteColor];

// 祖传浅灰色背景
#define APP_COLOR_BASE_LINE_RED         [UIColor colorWithRed:0.70 green:0.21 blue:0.18 alpha:1.00]

#define APP_COLOR_BASE_LINE_BLUE        [UIColor colorWithRed:0.16 green:0.64 blue:0.99 alpha:1.00]

// 浅灰色
#define APP_COLOR_BASE_LINE_GRAY        [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00]


// 按钮颜色
#define APP_COLOR_BASE_BUTTON_RED       [UIColor colorWithRed:0.70 green:0.21 blue:0.18 alpha:1.00]
#define APP_COLOR_BASE_BUTTON_BULE      [UIColor colorWithRed:0.00 green:0.47 blue:1.00 alpha:1.00]
#define APP_COLOR_BASE_Cell_LIGHTGRAY   [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]
#define APP_COLOR_BASE_Section_GRAY     [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00]


// 副标题文本颜色(深灰色)
#define APP_COLOR_BASE_SUBHEADING_GREY  [UIColor colorWithRed:0.55 green:0.55 blue:0.56 alpha:1.00]
#define APP_COLOR_BASE_LIGHT_GREY       [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00]
// 灰色分类
#define APP_COLOR_BASE_Cell_DARK_GREY   HEXCOLOR(0x666666)
#define APP_COLOR_BASE_Cell_BACK_GREY   HEXCOLOR(0xefefef)
#define APP_COLOR_BASE_Cell_LIGHT_GREY  HEXCOLOR(0x999999)
#define APP_COLOR_BASE_Cell_LINE_GREY   HEXCOLOR(0xb2b2b2)

// 文字颜色
#define APP_COLOR_BASE_TEXT_RED         [UIColor colorWithRed:0.70 green:0.21 blue:0.18 alpha:1.00]
#define APP_COLOR_BASE_TEXT_GREY        HEXCOLOR(0x666666)

#pragma mark - 文字相关



#pragma mark - 接口相关

#define APP_IMAGE_URL  @"http://oot34wnx6.bkt.clouddn.com/"

//#define APP_BASE_URL   @"http://172.16.18.244:8089"

//#define APP_BASE_URL   @"http://172.16.18.244:8089"

#define APP_BASE_URL   @"http://apitest.jubuxiu.com"

#define APP_BASE_SSO_URL   @"http://ssotest.jubuxiu.com"


#define APP_WHOLE_URL  @"http://172.16.3.5:8085/rest-api/api/sms/getSmsCode"

#define APP_LOGIN_URL   @"/api/api/token/getToken"

#define APP_REGISTER_URL @"/SSO/sso/user/register"

#define APP_FORGETPAW_URL @"/SSO/sso/user/forgetPassword"

#define APP_GET_SMS_URL  @"/api/api/sms/getSmsCode"

#define APP_SET_ORGAN_URL @"/api/api/token/setOrg"

#define APP_GET_PARTMENT_LIST_URL @"/api/api/dept/query"

#define APP_ADD_PARTMENT_URL @"/api/api/dept/add"


/**
 测试环境 钣金大师  http://172.16.3.8:8081
 @return return 测试服务
 */
#define APP_IRON_MASETER_URL @"http://bjdstest.jubuxiu.com/GCGL/html/wap/gc/html/index.html?token="

#define APP_GET_PARTMENT_BY_PARENTID_URL  @"/api/api/dept/queryByParentId"

#define APP_GET_PARTMENT_AND_MEMBER_URL  @"/api/admin/dept/queryDeptAndMember"

#define APP_GET_NEWS_TITLE_LIST_URL    @"/api/api/information/query"

#define APP_GET_NEWS_LIST_URL   @"/api/api/information/queryNewsList"

#define APP_NEWS_BASE_URL  @"http://jubuxiu.com:8080/web/information/informationDetail?id="


/**
 我的报价和我的询价
 @return
 */
#define APP_MINE_OFFER_LIST_URL @"/api/api/enquiry/queryMyIsToEnquiry"

#define APP_MINE_REQUIRE_LIST_URL @"/api/api/enquiry/queryMyEnquiry"

#define APP_REQUIRE_DETAIL_LIST_URL  @"/api/api/enquiry/queryEnquItemInfo"

#define APP_OFFER_SPEAK_PRICE_URL @"/api/api/enquiry/addEquiryResponse"

#define APP_ORDER_DETAIL_LIST_URL  @"/api/api/enquiry/queryItemInfo"

#define APP_BUS_LIST_URL  @"/api/api/enquiry/mathOrg"


/**
 精品相关接口

 @return
 */
#define APP_BOUTIQUE_TAB_URL @"/api/api/delicate/quiryFanType"

#define APP_BOUTIQUE_LIST_URL  @"/api/api/delicate/enquiryFancyEx"

// 首页广告
#define APP_ADVERTISE_LIST_URL  @"/api/api/statistics/statisticsTotal"

#endif /* AppMacro_h */
