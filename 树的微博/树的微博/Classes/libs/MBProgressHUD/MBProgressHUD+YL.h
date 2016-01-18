//
//  MBProgressHUD+YL.h
//  view
//
//  Created by DreamHand on 15/9/9.
//  Copyright (c) 2015年 WYL. All rights reserved.
//

#import "MBProgressHUD.h"

#define kHUDHiddenAfterSecond 0.7

// 通过设置 属性值 square = YES 可以让hud对象保持正方形

@interface MBProgressHUD (YL)

/**
 *  显示成功信息
 *
 *  @param success 文本信息
 *  @param view    要显示到的view
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 *  显示错误信息
 *
 *  @param error 文本信息
 *  @param view  要显示到的view
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 *  显示成功信息到 最后一个UIWindow 窗口上
 *
 *  @param success 文本信息
 */
+ (void)showSuccess:(NSString *)success;

/**
 *  显示错误信息到 最后一个UIWindow 窗口上
 *
 *  @param error 文本信息
 */
+ (void)showError:(NSString *)error;

/**
 *  显示提示信息,带菊花状态,需手动隐藏
 *
 *  @param message 提示信息
 *  @param detailMessage 详情信息
 *  @param view    要显示到的view
 *  @param dimBackground 是否显示蒙板
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage toView:(UIView *)view dimBackground:(BOOL)dimBackground;

/**
 *  显示提示信息,带菊花状态,需手动隐藏
 *
 *  @param message 提示信息
 *  @param view    要显示到的view
 *  @param dimBackground 是否显示蒙版
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view dimBackground:(BOOL)dimBackground;
/**
 *  显示提示信息,带菊花状态,需手动隐藏, 默认关闭蒙板
 *
 *  @param message 提示信息
 *  @param view    要显示到的view
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  显示提示信息到 最后一个UIWindow 窗口上,带菊花状态,需手动隐藏
 *
 *  @param message 提示信息
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;

/**
 *  隐藏HUD
 *
 *  @param view 需要隐藏HUD的view
 */
+ (void)hideHUDForView:(UIView *)view;
/**
 *  隐藏 最后一个UIWindow 窗口上的HUD
 */
+ (void)hideHUD;

/**
 *  显示文本提示信息, 带详细信息
 *
 *  @param text       文本提示
 *  @param detailText 详细信息
 *  @param view       要显示到的vie
 *  @param square     是否显示正方形的样式
 *  @param delay      delay秒后自动隐藏
 */
+ (MBProgressHUD *)showText:(NSString *)text detailText:(NSString *)detailText toView:(UIView *)view square:(BOOL)square hiddenAfterDelay:(CGFloat)delay;

/**
 *  显示文本提示信息
 *
 *  @param text   文本信息
 *  @param view   要显示到的view
 *  @param square 是否显示正方形的样式
 *  @param delay  delay秒后自动隐藏
 */
+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view square:(BOOL)square hiddenAfterDelay:(CGFloat)delay;

/**
 *  显示文本提示信息
 *
 *  @param text  文本信息
 *  @param view  要显示到的view
 *  @param delay delay秒后自动隐藏
 */
+ (void)showText:(NSString *)text toView:(UIView *)view hiddenAfterDelay:(CGFloat)delay;

/**
 *  显示文本提示信息到 最后一个UIWindow 窗口上
 *
 *  @param text  文本信息
 *  @param delay delay秒后自动隐藏
 */
+ (void)showText:(NSString *)text hiddenAfterDelay:(CGFloat)delay;

/**
 *  显示文本提示信息到 最后一个UIWindow 窗口上,延时默认时间后隐藏
 *
 *  @param text 文本信息
 */
+ (void)showText:(NSString *)text;

/**
 *  环形的进度条, 可在method里改变 progress 的值 更改进度, progress 取值范围 0 ~ 1
 *
 *  @param text   文本信息
 *  @param target 监听者
 *  @param method 监听者调用的方法
 *  @param view   要显示到的view
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showAnnularProgressWithText:(NSString *)text target:(id)target method:(SEL)method toView:(UIView *)view;

/**
 *  圆形的进度条, 可在method里改变 progress 的值 更改进度, progress 取值范围 0 ~ 1
 *
 *  @param text   文本信息
 *  @param target 监听者
 *  @param method 监听者调用的方法
 *  @param view   要显示到的view
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showRoundProgressWithText:(NSString *)text target:(id)target method:(SEL)method toView:(UIView *)view;


/**
 *  显示自定义view
 *
 *  @param customView 自定义的view
 *  @param message    文本信息
 *  @param view       要显示到的view
 *
 *  @return MBProgressHUD实例
 */
+ (MBProgressHUD *)showWithCustomView:(UIView *)customView  message:(NSString *)message toView:(UIView *)view;

@end
