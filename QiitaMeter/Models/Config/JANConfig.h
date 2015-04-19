//
//  JANConfig.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 固定の値，構造を管理するクラス
 * 主に，APIのURLとパラメータ，開発者のID一覧
 */

@interface JANConfig : NSObject
+ (NSString *)qiitaApiUrlString;
+ (NSString *)clientId;
+ (NSString *)clientSecret;
+ (NSURL *)oauthApiUrl;
+ (NSString *)accessTokensUrlString;
+ (NSString *)oauthRedirectUrlString;
+ (NSString *)authenticatedUserUrlString;
+ (NSString *)usersUrlString:(NSString *)userId;
+ (NSString *)usersStockUrlString:(NSString *)userId;

+ (NSString *)deleteAccessTokensUrlString:(NSString *)accessTokens;

+ (NSDictionary *)accessTokensParamsWithCode:(NSString*)code;

+ (NSArray *)specialUsers;
@end

@interface UIColor(Common)
+ (UIColor *)commonColor;
@end
