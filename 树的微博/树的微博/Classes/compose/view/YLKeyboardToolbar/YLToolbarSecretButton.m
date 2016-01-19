//
//  YLToolbarSecretButton.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLToolbarSecretButton.h"

@implementation YLToolbarSecretButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIImage *bg = [UIImage imageNamed:@"compose_group_button_background"];
        UIImage *bgH = [UIImage imageNamed:@"compose_group_button_background_highlighted"];
        [self setBackgroundImage:[bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5] forState:UIControlStateNormal];
        [self setBackgroundImage:[bgH stretchableImageWithLeftCapWidth:bgH.size.width * 0.5 topCapHeight:bgH.size.height * 0.5] forState:UIControlStateHighlighted];
        [self setTitleColor:RGBA(80, 125, 175, 1) forState:UIControlStateNormal];
        self.titleLabel.font = SystemFont(12);
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.secretType = ToolbarSecretType_public;
    }
    return  self;
}

- (void)setSecretType:(ToolbarSecretType)secretType
{
    _secretType = secretType;
    
    switch (_secretType)
    {
        case ToolbarSecretType_myself:
        {
            [self setTitle:@"仅自己可见" forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"compose_myself"] forState:UIControlStateNormal];
        }
            break;
        case ToolbarSecretType_friendCircel:
        {
            [self setTitle:@"朋友圈" forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"compose_friendcircle"] forState:UIControlStateNormal];
        }
            break;
        case ToolbarSecretType_public:
        {
            [self setTitle:@"公开" forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"compose_publicbutton"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    self.width = [[self titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName : SystemFont(12)}].width + 30;
}

@end
