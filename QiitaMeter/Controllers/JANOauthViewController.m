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
#import "JANQiitaConnector.h"
#import "JANUserService.h"

@implementation JANOauthViewController
- (void)viewDidLoad
{
    NSURL *url = [JANConfig oauthApiUrl];
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
    if ([request.URL.host isEqualToString:[JANConfig oauthRedirectUrlString]]) {
        NSString *code = [request.URL.uq_queryDictionary valueForKey:@"code"];
        [JANQiitaConnector retrieveQiitaAccessTokensWithCode:code successHandler:^(NSString *accessToekns){
            [JANUserService saveAccessTokens:accessToekns];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        } failedHandler:^(){
            
        }];
        return NO;
    }
    return YES;
}
@end
