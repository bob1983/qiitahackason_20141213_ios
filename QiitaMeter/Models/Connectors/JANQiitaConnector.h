//
//  JANQiitaConnector.h
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JANQiitaUserInfo;

typedef void(^JANQiitaConnectorSuccessHandler)();

typedef void(^JANQiitaConnectorStocksSuccessHandler)(NSArray *, NSInteger);
typedef void(^JANQiitaConnectorFailedHandler)();

typedef void(^JANQiitaConnectorUserInfoSuccessHandler)(NSDictionary *);

typedef void(^JANQiitaConnectorAccessTokesSuccessHandler)(NSString *);

@interface JANQiitaConnector : NSObject

+ (void)retrieveStocksWithUserId:(NSString *)userId
                            page:(NSInteger)page
                         perPage:(NSInteger)perPage
                  successHandler:(JANQiitaConnectorStocksSuccessHandler)successHandler
                   failedHandler:(JANQiitaConnectorFailedHandler)failedHandler;


+ (void)retrieveQiitaUserInfoWithUserId:(NSString *)userId
                         successHandler:(JANQiitaConnectorUserInfoSuccessHandler)successHandler
                          failedHandler:(JANQiitaConnectorFailedHandler)failedHandler;


+ (void)retrieveQiitaUserInfoWithsuccessHandler:(JANQiitaConnectorUserInfoSuccessHandler)successHandler
                                  failedHandler:(JANQiitaConnectorFailedHandler)failedHandler;


+ (void)retrieveQiitaAccessTokensWithCode:(NSString *)code
                           successHandler:(JANQiitaConnectorAccessTokesSuccessHandler)successHandler
                            failedHandler:(JANQiitaConnectorFailedHandler)failedHandler;
+ (void)retrieveDeleteQiitaAccessTokens:(NSString *)accessTokens
                         successHandler:(JANQiitaConnectorSuccessHandler)successHandler
                          failedHandler:(JANQiitaConnectorFailedHandler)failedHandler;

@end
