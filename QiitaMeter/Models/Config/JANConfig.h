//
//  JANConfig.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JANConfig : NSObject
+ (NSString *)qiitaApiUrlString;
+ (NSString *)clientId;
+ (NSString *)clientSecret;
+ (NSURL *)oauthApiUrl;
+ (NSDictionary *)accessTokensParamsWithCode:(NSString*)code;
+ (NSString *)accessTokensUrlString;
+ (NSString *)oauthRedirectUrlString;
+ (NSString *)authenticatedUserUrlString;
+ (NSString *)deleteAccessTokensUrlString:(NSString *)accessTokens;
@end
