//
//  YLHomeTitleView.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLHomeTitleView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void (^titleClickBlock)(BOOL arrowDown);

@end
