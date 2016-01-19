//
//  YLComposeNavTitleView.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLComposeNavTitleView.h"

#define kNameLabelFont SystemFont(14)
#define kTitleLabelFont BoldSystemFont(16)

@interface YLComposeNavTitleView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation YLComposeNavTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = kTitleLabelFont;
        titleLabel.textColor = RGBA(100, 100, 100, 1);
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = kNameLabelFont;
        nameLabel.textColor = RGBA(180, 180, 180, 1);
        nameLabel.text = User.name;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.width, self.height * 0.5);
    self.nameLabel.frame = CGRectMake(0, self.height * 0.5, self.width, self.height * 0.5);
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    CGSize nameSize = [User.name sizeWithAttributes:@{NSFontAttributeName : kNameLabelFont}];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : kTitleLabelFont}];
    self.width = MAX(nameSize.width, titleSize.width);
}
@end
