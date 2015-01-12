//
//  JANOauthoViewController.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANOauthViewController.h"
#import "JANConfig.h"
#import "NSURL+QueryDictionary.h"

@implementation JANOauthViewController
- (void)viewDidLoad
{
    NSURL *url = //[NSURL URLWithString:@"https://qiita.com/api/v2/oauth/authorize?client_id=123430671ca22508f508bda05bb0b84d5874b8b6&scope=read_qiita"];
    [JANConfig oauthApiUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_oauthWebView loadRequest:req];
}
// ページ読込開始時にインジケータをくるくるさせる
-(void)webViewDidStartLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// ページ読込完了時にインジケータを非表示にする
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL);
    if ([request.URL.host isEqualToString:[JANConfig oauthRedirectUrlString]]) {
        NSLog(@"code:%@", request.URL.uq_queryDictionary);
        NSString *code = [request.URL.uq_queryDictionary valueForKey:@"code"];
        NSURL *url = [JANConfig accessTokensUrlWithCode:code];
        NSLog(@"%@", url);
        return NO;
    }
    return YES;
}
@end
