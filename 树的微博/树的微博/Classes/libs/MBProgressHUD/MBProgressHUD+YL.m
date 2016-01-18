//
//  MBProgressHUD+YL.m
//  view
//
//  Created by DreamHand on 15/9/9.
//  Copyright (c) 2015年 WYL. All rights reserved.
//

#import "MBProgressHUD+YL.h"

@implementation MBProgressHUD (YL)

#pragma mark - 显示自定义view
+ (MBProgressHUD *)showWithCustomView:(UIView *)customView  message:(NSString *)message toView:(UIView *)view
{
    if(view == nil)     view = [[UIApplication sharedApplication].windows lastObject];
    
    /*
     // 快速显示到view上
     [MBProgressHUD showHUDAddedTo:view animated:YES];
     
     等同于
     
     MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
     [view addSubview:hud];
     [hud show:YES];
     */
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
    return hud;
}

#pragma mark - 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    MBProgressHUD *hud = [self showWithCustomView:customView message:text toView:view];
    [hud hide:YES afterDelay:kHUDHiddenAfterSecond];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

#pragma mark - 显示一些提示信息, 带菊花, 可设置动画效果
+ (MBProgressHUD *)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage toView:(UIView *)view animated:(BOOL)animated dimBackground:(BOOL)dimBackground
{
    if (view == nil)    view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.labelText = message;
    hud.detailsLabelText = detailMessage;
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = dimBackground;
    return hud;
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view animated:(BOOL)animated dimBackground:(BOOL)dimBackground
{
    return [self showMessage:message detailMessage:nil toView:view animated:animated dimBackground:dimBackground];
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view animated:(BOOL)animated
{
    return [self showMessage:message toView:view animated:animated dimBackground:NO];
}

+ (MBProgressHUD *)showMessage:(NSString *)message animated:(BOOL)animated
{
    return [self showMessage:message toView:nil animated:animated];
}


#pragma mark - 显示一些提示信息, 带菊花 ,有动画效果
+ (MBProgressHUD *)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage toView:(UIView *)view dimBackground:(BOOL)dimBackground
{
    return [self showMessage:message detailMessage:detailMessage toView:view animated:YES dimBackground:dimBackground];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view dimBackground:(BOOL)dimBackground
{
    return [self showMessage:message detailMessage:nil toView:view dimBackground:dimBackground];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view
{
    return [self showMessage:message toView:view dimBackground:NO];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

#pragma mark - 隐藏HUD
+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

#pragma mark - 显示文本提示信息, 带详细信息
+ (MBProgressHUD *)showText:(NSString *)text detailText:(NSString *)detailText toView:(UIView *)view square:(BOOL)square hiddenAfterDelay:(CGFloat)delay
{
    if(view == nil)     view = [[UIApplication sharedApplication].windows lastObject];
    if(delay <= 0)      delay = kHUDHiddenAfterSecond;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.detailsLabelText = detailText;
    hud.square = square;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
    return hud;
}

#pragma mark - 显示文本提示信息
+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view square:(BOOL)square hiddenAfterDelay:(CGFloat)delay
{
    if(view == nil)     view = [[UIApplication sharedApplication].windows lastObject];
    if(delay <= 0)      delay = kHUDHiddenAfterSecond;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.square = square;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
    return hud;
}

+ (void)showText:(NSString *)text toView:(UIView *)view hiddenAfterDelay:(CGFloat)delay
{
    [self showText:text toView:view square:NO hiddenAfterDelay:delay];
}

+ (void)showText:(NSString *)text hiddenAfterDelay:(CGFloat)delay
{
    [self showText:text toView:nil hiddenAfterDelay:delay];
}

+ (void)showText:(NSString *)text
{
    [self showText:text toView:nil hiddenAfterDelay:0];
}

#pragma mark - 环形的进度条
+ (MBProgressHUD *)showAnnularProgressWithText:(NSString *)text target:(id)target method:(SEL)method toView:(UIView *)view
{
    if(view == nil)
    {
        if([target isKindOfClass:[UIViewController class]])
        {
            UIViewController *vc = (UIViewController *)target;
            view = vc.view;
        }
        else if([target isKindOfClass:[UIView class]])
        {
            view = target;
        }
        else
        {
             view = [[UIApplication sharedApplication].windows lastObject];
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = text;
    [hud showWhileExecuting:method onTarget:target withObject:nil animated:YES];
    [view addSubview:hud];
    return hud;
}

#pragma mark - 圆形的进度条
+ (MBProgressHUD *)showRoundProgressWithText:(NSString *)text target:(id)target method:(SEL)method toView:(UIView *)view
{
    if(view == nil)
    {
        if([target isKindOfClass:[UIViewController class]])
        {
            UIViewController *vc = (UIViewController *)target;
            view = vc.view;
        }
        else if([target isKindOfClass:[UIView class]])
        {
            view = target;
        }
        else
        {
            view = [[UIApplication sharedApplication].windows lastObject];
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = text;
    [hud showWhileExecuting:method onTarget:target withObject:nil animated:YES];
    [view addSubview:hud];
    return hud;
}

@end
