//
//  YLHeadViewCell.h
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLHeadViewCell : UITableViewCell

/**
 *  用户数据
 */
@property (nonatomic, strong) YLUser *user;

/**
 *  点击了头像回调
 */
@property (nonatomic, copy) void (^iconClickedBlock)();

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
