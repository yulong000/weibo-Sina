//
//  YLComposeTextView.h
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ComposeTextViewDidChangedBlock)(NSString *text);

@interface YLComposeTextView : UIView

/**
 *  文本内容
 */
@property (nonatomic, copy, readonly) NSString *text;

/**
 *  提示文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  文字内容发生改变回调
 */
@property (nonatomic, copy) ComposeTextViewDidChangedBlock textDidChangedBlock;
@end
