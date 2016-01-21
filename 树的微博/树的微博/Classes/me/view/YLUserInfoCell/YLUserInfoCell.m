//
//  YLUserInfoCell.m
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLUserInfoCell.h"
#import "YLMembershipButton.h"

@interface YLUserInfoCell ()

@property (nonatomic, strong) NSMutableArray <YLMembershipButton *> *buttonsArr;

@end

@implementation YLUserInfoCell

- (NSMutableArray <YLMembershipButton *> *)buttonsArr
{
    if(_buttonsArr == nil)
    {
        _buttonsArr = [NSMutableArray array];
    }
    return _buttonsArr;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"UserInfoCell";
    YLUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[YLUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addButtons];
    }
    return cell;
}
#pragma mark 添加子控件
- (void)addButtons
{
    NSArray *contents = @[@"微博", @"关注", @"粉丝"];
    for(int i = 0; i < 3; i++)
    {
        YLMembershipButton *btn = [[YLMembershipButton alloc] init];
        btn.tag = i;
        btn.content = contents[i];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttonsArr addObject:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width / 3;
    [self.buttonsArr enumerateObjectsUsingBlock:^(__kindof YLMembershipButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        btn.frame = CGRectMake(btnW * idx, 0, btnW, self.height);
        
    }];
}
#pragma mark 点击了某个 button
- (void)buttonClicked:(YLMembershipButton *)btn
{
    if(self.buttonClickedBlock)
    {
        self.buttonClickedBlock(btn.tag, btn.count);
    }
}
#pragma mark 设置属性
- (void)setUser:(YLUser *)user
{
    _user = user;
    
    if(self.buttonsArr.count == 0)  return;
    
    self.buttonsArr.firstObject.count = user.statuses_count;
    self.buttonsArr[1].count = user.friends_count;
    self.buttonsArr.lastObject.count = user.followers_count;
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
