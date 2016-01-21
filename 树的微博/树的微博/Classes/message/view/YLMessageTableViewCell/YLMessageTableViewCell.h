//
//  YLMessageTableViewCell.h
//  树的微博
//
//  Created by WYL on 16/1/20.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YLMessageTableViewCellModel;
@interface YLMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) YLMessageTableViewCellModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
