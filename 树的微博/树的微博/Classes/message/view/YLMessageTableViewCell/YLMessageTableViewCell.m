//
//  YLMessageTableViewCell.m
//  树的微博
//
//  Created by WYL on 16/1/20.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLMessageTableViewCell.h"
#import "YLMessageTableViewCellModel.h"

@interface YLMessageTableViewCell ()

/**
 *  提醒
 */
@property (nonatomic, strong) YLBadgeView *badgeView;

/**
 *  时间
 */
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation YLMessageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"MessageTableViewCell";
    YLMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[YLMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.textLabel.font = SystemFont(17);
        cell.detailTextLabel.font = SystemFont(14);
        cell.detailTextLabel.textColor = GrayColor;
        cell.badgeView = [[YLBadgeView alloc] init];
        cell.timeLabel = [[UILabel alloc] init];
        cell.timeLabel.textAlignment = NSTextAlignmentRight;
        cell.timeLabel.textColor = GrayColor;
        cell.timeLabel.font = SystemFont(11);
        [cell addSubview:cell.timeLabel];
        [cell addSubview:cell.badgeView];
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.badgeView.bounds = CGRectMake(0, 0, 20, 20);
    self.badgeView.center = CGPointMake(self.contentView.width - self.badgeView.width, self.contentView.height * 0.5);
    
    CGFloat timeLabelW = 100;
    self.timeLabel.frame = CGRectMake(self.contentView.width - timeLabelW - 10, self.textLabel.y, timeLabelW, self.textLabel.height);
}

- (void)setModel:(YLMessageTableViewCellModel *)model
{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:_model.image];
    self.textLabel.text = _model.title;
    self.detailTextLabel.text = _model.detailTitle;
    self.badgeView.badgeValue = StringValueFromInt(_model.unreadCount.intValue);
    self.timeLabel.text = _model.created_at;
    
}
@end
