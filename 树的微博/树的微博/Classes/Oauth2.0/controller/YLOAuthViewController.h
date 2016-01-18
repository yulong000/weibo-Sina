//
//  YLOAuthViewController.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

// 获取账户成功回调
typedef void(^GetAccountInfoSuccessBlock)(YLAccount *account);

@interface YLOAuthViewController : UIViewController

@property (nonatomic, copy) GetAccountInfoSuccessBlock getAccountSuccess;

@end
