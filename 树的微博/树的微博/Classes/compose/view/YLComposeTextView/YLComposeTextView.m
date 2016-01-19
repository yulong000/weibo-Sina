//
//  YLComposeTextView.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLComposeTextView.h"

@interface YLComposeTextView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *placeholderLabel;


@end

@implementation YLComposeTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.textView = [[UITextView alloc] init];
        self.textView.font = SystemFont(16);
        self.textView.delegate = self;
        [self addSubview:self.textView];
        
        self.placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel.textColor = GrayColor;
        self.placeholderLabel.font = self.textView.font;
        [self.textView addSubview:self.placeholderLabel];
    }
    return  self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
    self.textView.contentSize = CGSizeMake(self.width, self.height + 0.5);
    self.placeholderLabel.frame = CGRectMake(10, 0, self.textView.width - 10, 40);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = _placeholder;
}

- (NSString *)text
{
    return self.textView.text;
}

- (BOOL)becomeFirstResponder
{
    return [self.textView becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [self.textView resignFirstResponder];
}
#pragma mark 滑动消失
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.textView resignFirstResponder];
}

#pragma mark - UITextView 代理
- (void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden = textView.text.length;
    
    if(self.textDidChangedBlock)
    {
        self.textDidChangedBlock(textView.text);
    }
}
@end
