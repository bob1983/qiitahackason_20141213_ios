//
//  JANOauthoViewController.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JANBaseViewController.h"
@interface JANOauthViewController : JANBaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *oauthWebView;

@end
