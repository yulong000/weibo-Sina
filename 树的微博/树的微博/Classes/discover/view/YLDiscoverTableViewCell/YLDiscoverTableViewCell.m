//
//  YLDiscoverTableViewCell.m
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLDiscoverTableViewCell.h"
#import "YLDiscoverTableViewCellModel.h"

@interface YLDiscoverTableViewCell ()

/**
 *  提醒
 */
@property (nonatomic, strong) YLBadgeView *badgeView;

/**
 *  箭头
 */
@property (nonatomic, strong) UIImageView *arrowView;

/**
 *  大标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  小标题
 */
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation YLDiscoverTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"DiscoverTableViewCell";
    YLDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[YLDiscoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.titleLabel = [[UILabel alloc] init];
        cell.titleLabel.font = SystemFont(16);
        cell.titleLabel.backgroundColor = ClearColor;
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:cell.titleLabel];
        
        cell.badgeView = [[YLBadgeView alloc] init];
        [cell.contentView addSubview:cell.badgeView];
        
        cell.detailLabel = [[UILabel alloc] init];
        cell.detailLabel.font = SystemFont(13);
        cell.detailLabel.textColor = GrayColor;
        cell.detailLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailLabel.backgroundColor = ClearColor;
        [cell.contentView addSubview:cell.detailLabel];
        
        cell.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_small_arrow"]];
        cell.arrowView.contentMode = UIViewContentModeCenter;
        [cell.contentView addSubview:cell.arrowView];
        cell.arrowView.hidden = YES;
        
        cell.backgroundColor = WhiteColor;
        cell.imageView.contentMode = UIViewContentModeCenter;
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.badgeView.bounds = CGRectMake(0, 0, self.badgeView.width, 20);
    self.badgeView.center = CGPointMake(self.contentView.width - self.badgeView.width, self.contentView.height * 0.5);
    
    CGFloat arrowViewW = 20;
    self.arrowView.frame = CGRectMake(self.contentView.width - arrowViewW - 10, 0, arrowViewW, self.contentView.height);
    
    self.imageView.frame = CGRectMake(0, 0, self.contentView.height, self.contentView.height);
    
    CGSize titleLabelSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(self.imageView.width, 0, titleLabelSize.width, self.contentView.height);
    
    CGSize detailLabelSize = [self.detailLabel.text sizeWithAttributes:@{NSFontAttributeName : self.detailLabel.font}];
    self.detailLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, self.titleLabel.y, detailLabelSize.width, self.titleLabel.height);
}

- (void)setModel:(YLDiscoverTableViewCellModel *)model
{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:_model.image];
    self.titleLabel.text = _model.title;
    self.detailLabel.text = _model.detailTitle;
    self.badgeView.badgeValue = StringValueFromInt(_model.unreadCount.intValue);
    if(self.showArrow)
    {
        self.arrowView.hidden = _model.unreadCount.intValue;
    }
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [RGBA(220, 220, 220, 1) set];
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}

- (void)setShowArrow:(BOOL)showArrow
{
    _showArrow = showArrow;
    
    if(self.showArrow)
    {
        self.arrowView.hidden = self.model.unreadCount.intValue;
    }
}

@end
