//
//  JANConfig.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANConfig.h"
#import "NSURL+QueryDictionary.h"

#define PLIST_FILE_NAME @"config"

#define QIITA_API_BASE_URL @"https://qiita.com/api/v2"

#define QIITA_OAUTH_API_URL [NSString stringWithFormat:@"%@%@", QIITA_API_BASE_URL, @"/oauth/authorize"]
#define QIITA_ACCESS_TOKENS_API_URL [NSString stringWithFormat:@"%@%@", QIITA_API_BASE_URL, @"/access_tokens"] //POST
#define QIITA_AUTOENTICATED_USER_API_URL [NSString stringWithFormat:@"%@%@", QIITA_API_BASE_URL, @"/authenticated_user"]
#define QIITA_DELETE_ACCESS_TOKENS_API_URL [NSString stringWithFormat:@"%@%@", QIITA_API_BASE_URL, @"/access_tokens"] //DELETE

#define QIITA_USERS_API_URL [NSString stringWithFormat:@"%@%@", QIITA_API_BASE_URL, @"/users"]

#define QIITA_OAUTH_REDIRECT_URL @"http://genqi.gingbear.com"

#define SPECIAL_USERS @"takayosh1hasegawa/bOb_sTrane/gingbear"

static NSString *qiitaClientId;
static NSString *qiitaClientSecret;

@implementation JANConfig
+ (NSString *)qiitaApiUrlString
{
    return QIITA_API_BASE_URL;
}

+ (NSString *)clientId
{
    if (!qiitaClientId) {
        [self setValuesFromPlist];
    }
    return qiitaClientId;
}

+ (NSString *)clientSecret
{
    if (!qiitaClientSecret) {
        [self setValuesFromPlist];
    }
    return qiitaClientSecret;
}

+ (NSURL *)oauthApiUrl
{
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&scope=read_qiita", QIITA_OAUTH_API_URL, [self clientId]];
    return [NSURL URLWithString:urlString];
}

+ (NSString *)oauthRedirectUrlString
{
    return [[NSURL URLWithString:QIITA_OAUTH_REDIRECT_URL] host];
}

+ (NSDictionary *)accessTokensParamsWithCode:(NSString *)code
{
    return @{@"client_id":[self clientId],
             @"client_secret":[self clientSecret],
             @"code":code
             };
}

+ (NSString *)accessTokensUrlString
{
    return QIITA_ACCESS_TOKENS_API_URL;
}

+ (NSString *)authenticatedUserUrlString
{
    return QIITA_AUTOENTICATED_USER_API_URL;
}

+ (NSString *)deleteAccessTokensUrlString:(NSString *)accessTokens
{
    return [NSString stringWithFormat:@"%@/%@", QIITA_DELETE_ACCESS_TOKENS_API_URL, accessTokens];
}

+ (NSString *)usersUrlString:(NSString *)userId
{
    return [NSString stringWithFormat:@"%@/%@", QIITA_USERS_API_URL, userId];
}

+ (NSString *)usersStockUrlString:(NSString *)userId
{
    return [NSString stringWithFormat:@"%@/%@/stocks", QIITA_USERS_API_URL, userId];
}



+ (void)setValuesFromPlist
{
    NSDictionary *dic = [self loadPlist];
    qiitaClientId = [dic valueForKey:@"client_id"];
    qiitaClientSecret = [dic valueForKey:@"client_secret"];
    
}

+ (NSDictionary *)loadPlist
{
    NSBundle* bundle = [NSBundle mainBundle];
    
    // 読み込みたいplistのパスを作成
    NSString* filePath = [bundle pathForResource:PLIST_FILE_NAME ofType:@"plist"];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在しないか?
    if (![fileManager fileExistsAtPath:filePath]) { // yes
        NSLog(@"plistが存在しません．");
        return nil;
    }
    
    // plistを読み込む
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@", dict);
    return dict;
}

+ (NSArray *)specialUsers
{
    static NSArray *spesialUsers;
    if (!spesialUsers) {
        spesialUsers = [SPECIAL_USERS componentsSeparatedByString:@"/"];
    }
    return spesialUsers;
}

@end
