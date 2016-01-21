//
//  YLComposeTextView.h
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ComposeTextViewDidChangedBlock)(NSString *text);

typedef void(^ComposeTextViewDidEndDragBlock)();

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
 *  输入键盘
 */
@property (nonatomic, readwrite, strong) UIView *inputView;

/**
 *  文字内容发生改变回调
 */
@property (nonatomic, copy) ComposeTextViewDidChangedBlock textDidChangedBlock;

/**
 *  停止拖拽回调
 */
@property (nonatomic, copy) ComposeTextViewDidEndDragBlock endDragBlock;
@end
