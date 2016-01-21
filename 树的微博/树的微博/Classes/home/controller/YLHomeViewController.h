//
//  YLHomeViewController.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLHomeViewController : UITableViewController

/**
 *  获取新微博
 */
- (void)beginRefresh;

@end

/**
 *  当前用户
 */
extern YLUser *User;