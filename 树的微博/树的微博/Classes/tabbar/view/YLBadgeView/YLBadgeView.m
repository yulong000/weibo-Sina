//
//  YLBadgeView.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLBadgeView.h"

@implementation YLBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        UIImage *bgImage = [UIImage imageNamed:@"main_badge"];
        [self setBackgroundImage:[bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5] forState:UIControlStateNormal];
        self.titleLabel.font = SystemFont(10);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if(_badgeValue.intValue)
    {
        self.hidden = NO;
        if(_badgeValue.intValue > 99)
        {
            _badgeValue = @"99+";
        }
        [self setTitle:_badgeValue forState:UIControlStateNormal];
        if(_badgeValue.intValue > 9)
        {
            self.width = [_badgeValue sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width + 10;
        }
        else
        {
            self.width = self.height;
        }
    }
    else
    {
        self.hidden = YES;
    }
}

@end
