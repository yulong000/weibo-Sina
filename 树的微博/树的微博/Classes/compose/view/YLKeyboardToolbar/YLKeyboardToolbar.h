//
//  YLKeyboardToolbar.h
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLKeyboardToolbar;
@protocol YLKeyboardToolbarDelegate <NSObject>
@optional

/**
 *  点击了功能按钮
 */
- (void)keyboardToolbar:(YLKeyboardToolbar *)keyboardToolbar didClickButton:(KeyboardToolbarButtonType)buttonType;

/**
 *  点击了位置按钮
 */
- (void)keyboardToolbarDidClickLocationButton:(YLKeyboardToolbar *)keyboardToolbar;

/**
 *  点击了隐私策略按钮
 */
- (void)keyboardToolbarDidClickSecrectButton:(YLKeyboardToolbar *)keyboardToolbar;

@end

@interface YLKeyboardToolbar : UIView

@property (nonatomic, weak) id <YLKeyboardToolbarDelegate> delegate;

/**
 *  位置信息
 */
@property (nonatomic, copy) NSString *location;

/**
 *  隐私策略
 */
@property (nonatomic, assign) ToolbarSecretType secretType;

/**
 *  表情和更多 当前选中的那个， 都未选中时为 nil
 */
@property (nonatomic, weak) UIButton *selectedButton;

/**
 *  点击当前选中的按钮（表情/更多）
 */
- (void)clickSelectedButton;


@end
