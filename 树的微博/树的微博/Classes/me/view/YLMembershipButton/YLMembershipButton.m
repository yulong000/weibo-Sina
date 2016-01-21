//
//  YLMembershipButton.m
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLMembershipButton.h"

@interface YLMembershipButton ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation YLMembershipButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.font = SystemFont(15);
        self.countLabel.textColor = BlackColor;
        [self addSubview:self.countLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.font = SystemFont(14);
        self.contentLabel.textColor = GrayColor;
        [self addSubview:self.contentLabel];
        
        self.count = 0;
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.countLabel.frame = CGRectMake(0, 0, self.width, self.height * 0.6);
    self.contentLabel.frame = CGRectMake(0, self.height * 0.4, self.width, self.height * 0.6);
}

- (void)setContent:(NSString *)content
{
    _content = [content copy];
    
    self.contentLabel.text = _content;
}

- (void)setCount:(NSInteger)count
{
    _count = count;
    
    self.countLabel.text = StringVauleFromInteger(count);
}


@end
