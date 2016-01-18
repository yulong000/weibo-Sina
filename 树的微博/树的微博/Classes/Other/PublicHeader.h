//
//  PublicHeader.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#pragma mark - API

#define AppKey      @"4216503575"
#define AppSecret   @"7a3cea23d82f1eacec8b532e356d691c"


// 应用的回调地址
#define AppCallbackUrl @"http://www.baidu.com"

// oauth2.0授权
#define AuthorizeAPI [@"https://open.weibo.cn/oauth2/authorize" stringByAppendingString:[NSString stringWithFormat:@"?client_id=%@&redirect_uri=%@", AppKey, AppCallbackUrl]]

// 获取 token
#define GetUserAccessTokenAPI @"https://api.weibo.com/oauth2/access_token?"

// 获取个人信息
#define GetUserInfoAPI @"https://api.weibo.com/2/users/show.json"

// 获取微博
#define GetUserStatusesAPI @"https://api.weibo.com/2/statuses/home_timeline.json"



#pragma mark - status

#define kStatusTimeFont             SystemFont(12)    // 时间的字体
#define kStatusSourceFont           SystemFont(12)    // 微博来源的字体
#define kStatusContentFont          SystemFont(16)    // 微博正文的字体
#define kStatusNameFont             SystemFont(15)    // 昵称的字体
#define kRetweetStatusNameFont      SystemFont(14)    // 被转发微博作者的昵称字体
#define kRetweetStatusContentFont   SystemFont(13)    // 被转发微博正文的字体
#define kStatusTableBorder          0                 // 表格的边框宽度
#define kStatusCellSubViewsGap      10                 // cell子控件间的间距

#endif /* PublicHeader_h */
