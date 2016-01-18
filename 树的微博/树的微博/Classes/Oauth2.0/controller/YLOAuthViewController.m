//
//  YLOAuthViewController.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLOAuthViewController.h"
#import "YLAccount.h"

@interface YLOAuthViewController () <UIWebViewDelegate>

@end

@implementation YLOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:AuthorizeAPI];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showMessage:@"授权登录中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    if([urlStr containsString:@"code="])
    {
        // 授权成功， 保存 code
        NSRange range = [urlStr rangeOfString:@"code="];
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        // 获取 access_token
        [self getAccess_tokenWithCode:code];
        
        return NO;
    }
    return YES;
}

#pragma mark 根据 code 获取 token
- (void)getAccess_tokenWithCode:(NSString *)code
{
    /*
     client_id      true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type     true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code           true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     
     // result
     access_token	string	用于调用access_token，接口获取授权后的access token。
     expires_in     string	access_token的生命周期，单位是秒数。
     uid            string	当前授权用户的UID。
     
     */
    NSDictionary *params = @{@"client_id"       : AppKey,
                             @"client_secret"   : AppSecret,
                             @"grant_type"      : @"authorization_code",
                             @"code"            : code,
                             @"redirect_uri"    : AppCallbackUrl
                             };
    [[YLNetworkTool shareNetworkTool] postWithURL:GetUserAccessTokenAPI params:params success:^(id json) {
        
        YLAccount *account = [YLAccount accountWithDict:json];
        [[YLUserCacheTool shareUserCacheTool] saveAccount:account];
        if(self.getAccountSuccess)
        {
            self.getAccountSuccess(account);
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"获取信息失败！"];
        
    }];
}

@end
