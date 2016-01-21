//
//  YLDiscoverTableViewCell.h
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLDiscoverTableViewCellModel;
@interface YLDiscoverTableViewCell : UITableViewCell

/**
 *  是否显示右边的箭头 default = no
 */
@property (nonatomic, assign) BOOL showArrow;

@property (nonatomic, strong) YLDiscoverTableViewCellModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
