//
//  YLComposeTextViewController.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLComposeTextViewController.h"
#import "YLComposeNavTitleView.h"
#import "YLComposeTextView.h"
#import "YLKeyboardToolbar.h"

#define kKeyboardToobarShowHight 70     // 工具栏高于键盘的高度
#define kKeyboardToolbarHight    280    // 工具栏的总高度

@interface YLComposeTextViewController () <YLKeyboardToolbarDelegate>

/**
 *  文字输入区域
 */
@property (nonatomic, weak) YLComposeTextView *textView;

/**
 *  快捷工具栏
 */
@property (nonatomic, strong) YLKeyboardToolbar *toolbar;

@end

@implementation YLComposeTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setNavBar];
    [self setContentView];
    
    // 键盘 toolbar
    self.toolbar = [[YLKeyboardToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - kKeyboardToobarShowHight, kScreenWidth, kKeyboardToolbarHight)];
    self.toolbar.delegate = self;
    [self.view addSubview:self.toolbar];
    
    // 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 设置导航栏
- (void)setNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem.tintColor = GrayColor;
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    sendBtn.titleLabel.font = SystemFont(12);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:GrayColor forState:UIControlStateDisabled];
    [sendBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[[UIImage imageNamed:@"timeline_card_small_button"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];
    
    CGSize size = CGSizeMake(40, 25);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [OrangeColor set];
    CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:(CGRect){CGPointZero, size} cornerRadius:5].CGPath);
    CGContextFillPath(ctx);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [sendBtn setBackgroundImage:image forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendStatus) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    YLComposeNavTitleView *titleView = [[YLComposeNavTitleView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [titleView setTitle:@"发微博"];
    self.navigationItem.titleView = titleView;
}

#pragma mark 取消
- (void)cancel
{
    [self.textView resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 发送微博
- (void)sendStatus
{
    /*
     source         false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     status         true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     visible        false	int     微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
     list_id        false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
     lat            false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
     long           false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
     annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
     rip            false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。
     */
    
    NSString *status = self.textView.text;
    if(status.length > 140)
    {
        [MBProgressHUD showError:@"不能超过140个汉字"];
        return;
    }
    
    [MBProgressHUD showMessage:@"发送中..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = Account.access_token;
    params[@"status"] = [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    params[@"visible"] = @(self.toolbar.secretType);
    
    [[YLNetworkTool shareNetworkTool] postWithURL:ComposeStatusOnlyTextAPI params:params success:^(id json) {
        
        [MBProgressHUD hideHUD];
        if(json[@"idstr"])
        {
            [MBProgressHUD showSuccess:@"发送成功！"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [MBProgressHUD showError:@"发送失败!"];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络错误!"];
    }];
}
#pragma mark 设置内容区域
- (void)setContentView
{
    YLComposeTextView *textView = [[YLComposeTextView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
    textView.placeholder = @"分享新鲜事...";
    __weak typeof(self) weakSelf = self;
    textView.textDidChangedBlock = ^(NSString *text){
    
        weakSelf.navigationItem.rightBarButtonItem.enabled = text.length;
    };
    [self.view addSubview:textView];
    self.textView = textView;
    [textView becomeFirstResponder];
}

#pragma mark - 键盘通知
- (void)keyboardNotification:(NSNotification *)noti
{
    if(self.toolbar.currentSelectedButton != nil && [noti.name isEqualToString:UIKeyboardWillHideNotification]) return;
    
    NSDictionary *userInfo = noti.userInfo;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    self.toolbar.frame = CGRectMake(0, keyboardBeginFrame.origin.y - kKeyboardToobarShowHight, keyboardBeginFrame.size.width, kKeyboardToolbarHight);
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbar.y -= (keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y);
    }];
}

#pragma mark - YLKeyboardToolbar 代理
#pragma mark 点击了功能区域按钮
- (void)keyboardToolbar:(YLKeyboardToolbar *)keyboardToolbar didClickButton:(KeyboardToolbarButtonType)buttonType
{
    switch (buttonType)
    {
        case KeyboardToolbarButtonTypePicture:
        {
            
        }
            break;
        case KeyboardToolbarButtonTypeMention:
        {
            
        }
            break;
        case KeyboardToolbarButtonTypeTrend:
        {
            
        }
            break;
        case KeyboardToolbarButtonTypeEmotion:
        {
            if(self.toolbar.currentSelectedButton.tag == KeyboardToolbarButtonTypeEmotion)
            {
                [self.textView resignFirstResponder];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.toolbar.frame = CGRectMake(0, kScreenHeight - kKeyboardToolbarHight, kScreenWidth, kKeyboardToolbarHight);
                }];
            }
            else if (self.toolbar.currentSelectedButton.tag != KeyboardToolbarButtonTypeMore)
            {
                [self.textView becomeFirstResponder];
            }
        }
            break;
        case KeyboardToolbarButtonTypeMore:
        {
            if(self.toolbar.currentSelectedButton.tag == KeyboardToolbarButtonTypeMore)
            {
                [self.textView resignFirstResponder];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.toolbar.frame = CGRectMake(0, kScreenHeight - kKeyboardToolbarHight, kScreenWidth, kKeyboardToolbarHight);
                }];
            }
            else if(self.toolbar.currentSelectedButton.tag != KeyboardToolbarButtonTypeEmotion)
            {
                [self.textView becomeFirstResponder];
            }
        }
            break;
        case KeyboardToolbarButtonTypeHeadline:
        {
            
        }
            break;
        case KeyboardToolbarButtonTypeStock:
        {
            
        }
            break;
        case KeyboardToolbarButtonTypeProduct:
        {
            
        }
            break;
        default:
            break;
    }
}
#pragma mark 点击了获取位置
- (void)keyboardToolbarDidClickLocationButton:(YLKeyboardToolbar *)keyboardToolbar
{
    
}
#pragma mark 点击了隐私策略
- (void)keyboardToolbarDidClickSecrectButton:(YLKeyboardToolbar *)keyboardToolbar
{
    
}
@end
