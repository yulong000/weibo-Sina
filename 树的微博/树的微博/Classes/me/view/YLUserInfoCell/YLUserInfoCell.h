//
//  YLUserInfoCell.h
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLUserInfoCell : UITableViewCell

/**
 *  设置用户数据
 */
@property (nonatomic, strong) YLUser *user;

/**
 *  点击了某个按钮, 返回序号和数量
 */
@property (nonatomic, copy) void (^buttonClickedBlock)(NSInteger index, NSUInteger count);

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
