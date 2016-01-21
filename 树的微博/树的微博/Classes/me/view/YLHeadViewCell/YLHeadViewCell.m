//
//  YLHeadViewCell.m
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLHeadViewCell.h"
#import "YLMembershipView.h"

@interface YLHeadViewCell ()

/**
 *  头像按钮
 */
@property (nonatomic, weak) UIButton *iconButton;

/**
 *  会员
 */
@property (nonatomic, weak) YLMembershipView *msView;

@end


@implementation YLHeadViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"HeadViewCell";
    YLHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[YLHeadViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.imageView.image = [UIImage imageNamed:@"avatar_default_big"];
        
        YLMembershipView *msView = [[YLMembershipView alloc] init];
        [cell.contentView addSubview:msView];
        cell.msView = msView;
        
        cell.textLabel.font = BoldSystemFont(15);
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.font = SystemFont(13);
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textColor = GrayColor;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(tap:)];
        [cell addGestureRecognizer:tap];
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat msViewW = 100;
    self.msView.frame = CGRectMake(self.contentView.width - msViewW - 10, 0, msViewW, self.contentView.height);
    
    CGFloat margin = 10;
    CGFloat imageViewWH = self.height - 2 * margin;
    self.imageView.frame = CGRectMake(margin * 2, margin, imageViewWH, imageViewWH);
    self.imageView.layer.cornerRadius = self.imageView.width * 0.5;
    self.imageView.clipsToBounds = YES;
    
    CGFloat textLabelX = CGRectGetMaxX(self.imageView.frame) + margin;
    CGFloat textLabelH = self.imageView.height * 0.5;
    self.textLabel.frame = CGRectMake(textLabelX, self.imageView.y, CGRectGetMinX(self.msView.frame) - textLabelX, textLabelH);
    self.detailTextLabel.frame = CGRectMake(textLabelX, CGRectGetMaxY(self.textLabel.frame), self.textLabel.width, textLabelH);
}

- (void)tap:(UITapGestureRecognizer *)tapG
{
    CGPoint location = [tapG locationInView:self];
    if(CGRectContainsPoint(self.imageView.frame, location))
    {
        if(self.iconClickedBlock)
        {
            self.iconClickedBlock();
        }
    }
}
#pragma mark 设置数据
- (void)setUser:(YLUser *)user
{
    _user = user;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    self.textLabel.text = user.name;
    if(user.descriptionStr.length)
    {
        self.detailTextLabel.text = [NSString stringWithFormat:@"简介:%@", user.descriptionStr];
    }
    else
    {
        self.detailTextLabel.text = [NSString stringWithFormat:@"简介: 暂无介绍"];
    }
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



@end
