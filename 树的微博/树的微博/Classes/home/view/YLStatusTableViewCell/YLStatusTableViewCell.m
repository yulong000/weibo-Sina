//
//  YLStatusTableViewCell.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLStatusTableViewCell.h"
#import "YLPhotosView.h"
#import "YLStatusToolbar.h"
#import "YLStatusUserInfoView.h"

@interface YLStatusTableViewCell () < YLStatusUserInfoViewDelegate, YLStatusToolbarDelegate >

/**
 *  父控件
 */
@property (nonatomic, weak) UIImageView *topView;

/**
 *  作者信息
 */
@property (nonatomic, weak) YLStatusUserInfoView *userInfoView;
/**
 *  配图
 */
@property (nonatomic, weak) YLPhotosView *photosView;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *contentLabel;

/**
 *  被转发微博的view(父控件)
 */
@property (nonatomic, weak) UIImageView *retweetView;
/**
 *  被转发微博作者的昵称
 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/**
 *  被转发微博的正文\内容
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/**
 *  被转发微博的配图
 */
@property (nonatomic, weak) YLPhotosView *retweetPhotosView;
/**
 *  微博的工具条
 */
@property (nonatomic, weak) YLStatusToolbar *statusToolbar;

@end

@implementation YLStatusTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *statusTableViewCell = @"HomeTableViewCell";
    YLStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:statusTableViewCell];
    if(cell == nil)
    {
        cell = [[YLStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:statusTableViewCell];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.backgroundColor = RGBA(240, 240, 240, 1);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolbar];
    }
    return self;
}

#pragma mark - 添加控件
#pragma mark 添加原创微博内部的子控件
- (void)setupOriginalSubviews
{
    // 大背景
    UIImageView *topView = [[UIImageView alloc]init];
    topView.userInteractionEnabled = YES;
    UIImage *topImage = [UIImage imageNamed:@"timeline_card_top_background"];
    UIImage *topHighlightImage = [UIImage imageNamed:@"timeline_card_top_background_highlighted"];
    topView.image = [topImage stretchableImageWithLeftCapWidth:topImage.size.width * 0.5 topCapHeight:topImage.size.height * 0.5];
    topView.highlightedImage = [topHighlightImage stretchableImageWithLeftCapWidth:topHighlightImage.size.width * 0.5 topCapHeight:topHighlightImage.size.height * 0.5];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    // 个人信息
    YLStatusUserInfoView *userInfoView = [[YLStatusUserInfoView alloc] init];
    userInfoView.delegate = self;
    [self.topView addSubview:userInfoView];
    self.userInfoView = userInfoView;
    
    // 正文
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = RGBA(39, 39, 39, 1);
    contentLabel.font = kStatusContentFont;
    contentLabel.backgroundColor = ClearColor;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 配图
    YLPhotosView *photosView = [[YLPhotosView alloc]init];
    //    photoView.contentMode = UIViewContentModeLeft;
    [self.topView addSubview:photosView];
    self.photosView = photosView;
}

#pragma mark 添加转发微博内部的子控件
- (void)setupRetweetSubviews
{
    // 1.被转发微博的父控件
    UIImageView *retweetView = [[UIImageView alloc]init];
    UIImage *image = [[UIImage imageNamed:@"timeline_retweet_background_highlighted"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    retweetView.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.9 topCapHeight:image.size.height * 0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    self.retweetView.userInteractionEnabled = YES;
    
    // 2.被转发微博作者的昵称
    UILabel *retweetNameLabel = [[UILabel alloc]init];
    retweetNameLabel.font = kRetweetStatusNameFont;
    retweetNameLabel.textColor = RGBA(67, 107, 163, 1);
    retweetNameLabel.backgroundColor = ClearColor;
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    // 3.被转发微博的正文
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.font = kRetweetStatusContentFont;
    retweetContentLabel.backgroundColor = ClearColor;
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    // 4.被转发微博的配图
    YLPhotosView *retweetPhotosView = [[YLPhotosView alloc]init];
    [self.retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

#pragma mark 添加微博的工具条
- (void)setupStatusToolbar
{
    YLStatusToolbar *statusToolbar = [[YLStatusToolbar alloc]init];
    statusToolbar.delegate = self;
    [self.topView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

#pragma mark - 设置 frame 和 数据
#pragma mark 设置 frame
- (void)setStatusFrame:(YLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.传递原创微博的数据
    [self setupOriginalData];
    
    // 2.传递转发微博的数据
    [self setupRetweeData];
    
    // 3.微博工具条
    [self setupStatusToolbarData];
}

#pragma mark 传递原创微博的数据
- (void)setupOriginalData
{
    YLStatus *status = self.statusFrame.status;
    
    // topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 个人信息
    self.userInfoView.status = status;
    self.userInfoView.frame = self.statusFrame.userInfoViewF;
    
    // 正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 配图
    if(status.pic_urls.count)
    {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.pic_urls = status.pic_urls;
    }
    else
    {
        self.photosView.hidden = YES;
    }
}

#pragma mark 传递转发微博的数据
- (void)setupRetweeData
{
    YLStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    YLUser *user = retweetStatus.user;
    
    if(retweetStatus)
    {
        // 1.父控件
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if(retweetStatus.pic_urls.count)
        {
            self.retweetPhotosView.hidden = NO;
            self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.pic_urls = retweetStatus.pic_urls;
        }
        else
        {
            self.retweetPhotosView.hidden = YES;
        }
    }
    else
    {
        self.retweetView.hidden = YES;
    }
}

#pragma mark 微博工具条
- (void)setupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolBarF;
    self.statusToolbar.status = self.statusFrame.status;
}

#pragma mark - YLStatusUserInfoView 代理
#pragma mark 点击头像
- (void)statusUserInfoViewClickedIconView:(YLStatusUserInfoView *)userInfoView
{
    YLLog(@"头像");
}
#pragma mark 点击了更多
- (void)statusUserInfoViewClickedMoreButton:(YLStatusUserInfoView *)userInfoView
{
    YLLog(@"更多");
}

#pragma mark - YLStatusToolbar 代理
#pragma mark 转发
- (void)statusToolbarRetweetBtnClicked:(YLStatusToolbar *)toolbar
{
    YLLog(@"转发");
}
#pragma mark 评论
- (void)statusToolbarCommentBtnClicked:(YLStatusToolbar *)toolbar
{
    YLLog(@"评论");
}
#pragma mark 点赞
- (void)statusToolbarAttitudeBtnClicked:(YLStatusToolbar *)toolbar
{
    YLLog(@"点赞");
}

@end
