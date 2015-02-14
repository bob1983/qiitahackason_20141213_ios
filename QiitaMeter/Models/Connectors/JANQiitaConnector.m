//
//  JANQiitaConnector.m
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "JANQiitaConnector.h"
#import "JANNetworkInterface.h"
#import "JANQiitaUserInfoService.h"
#import "JANConfig.h"

#define TIMEOUT_INTERVAL 10.0

@implementation JANQiitaConnector
+ (void)retrieveStocksWithUserId:(NSString *)userId
                            page:(NSInteger)page
                         perPage:(NSInteger)perPage
                 successHandler:(JANQiitaConnectorStocksSuccessHandler)successHandler
                  failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl     = [JANConfig usersStockUrlString:userId];
    NSDictionary *params = @{
                          @"page":[NSNumber numberWithInteger:page],
                          @"per_page":[NSNumber numberWithInteger:perPage]
                          };
    [JANNetworkInterface GETRequestWithURLString:baseUrl
                                      parameters:params
                                 timeoutInterval:TIMEOUT_INTERVAL
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         success:^(NSHTTPURLResponse *response, id responseObject) {
//                                             NSLog(@"%@", responseObject);
                                             if (successHandler) {
                                                 successHandler([NSArray arrayWithArray:responseObject]);
                                             }
                                         } failure:^(NSHTTPURLResponse *response, NSError *error) {
                                             if (failedHandler) {
                                                 failedHandler();
                                             }
                                         }];
}
+ (void)retrieveQiitaUserInfoWithUserId:(NSString *)userId
                         successHandler:(JANQiitaConnectorUserInfoSuccessHandler)successHandler
                          failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl     = [JANConfig usersUrlString:userId];
    [JANNetworkInterface GETRequestWithURLString:baseUrl
                                      parameters:nil
                                 timeoutInterval:TIMEOUT_INTERVAL
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         success:^(NSHTTPURLResponse *response, id responseObject) {
//                                             NSLog(@"%@",responseObject);
                                             if (successHandler){
                                                 successHandler([NSDictionary dictionaryWithDictionary:responseObject]);
                                             }
                                         } failure:^(NSHTTPURLResponse *response, NSError *error) {
                                             if (failedHandler) {
                                                 failedHandler();
                                             }
                                         }];
}

+ (void)retrieveQiitaUserInfoWithsuccessHandler:(JANQiitaConnectorUserInfoSuccessHandler)successHandler
                                  failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl     = [JANConfig authenticatedUserUrlString];
    [JANNetworkInterface GETRequestWithURLString:baseUrl
                                      parameters:nil
                                 timeoutInterval:TIMEOUT_INTERVAL
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         success:^(NSHTTPURLResponse *response, id responseObject) {
                                             //                                             NSLog(@"%@",responseObject);
                                             if (successHandler){
                                                 successHandler([NSDictionary dictionaryWithDictionary:responseObject]);
                                             }
                                         } failure:^(NSHTTPURLResponse *response, NSError *error) {
                                             if (failedHandler) {
                                                 failedHandler();
                                             }
                                         }];
}

+ (void)retrieveQiitaAccessTokensWithCode:(NSString *)code
                           successHandler:(JANQiitaConnectorAccessTokesSuccessHandler)successHandler
                            failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl = [JANConfig accessTokensUrlString];
    NSDictionary *dic = [JANConfig accessTokensParamsWithCode:code];
    [JANNetworkInterface JSONPOSTRequestWithURLString:baseUrl
                                                 json:dic
                                      timeoutInterval:TIMEOUT_INTERVAL
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              success:^(NSHTTPURLResponse *response, id responseObject) {
//                                                  NSLog(@"%@",responseObject);
                                                  NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                                                  
                                                  if (successHandler){
                                                      successHandler([dic objectForKey:@"token"]);
                                                  }
                                              } failure:^(NSHTTPURLResponse *response, NSError *error) {
                                                  if (failedHandler) {
                                                      failedHandler();
                                                  }
                                              }];
    
}

+ (void)retrieveDeleteQiitaAccessTokens:(NSString *)accessTokens
                         successHandler:(JANQiitaConnectorSuccessHandler)successHandler
                          failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl = [JANConfig deleteAccessTokensUrlString:accessTokens];
    [JANNetworkInterface DELETERequestWithURLString:baseUrl parameters:nil timeoutInterval:TIMEOUT_INTERVAL cachePolicy:NSURLRequestUseProtocolCachePolicy success:^(NSHTTPURLResponse *response, id responseObject) {
        
        if (successHandler){
            successHandler();
        }
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        if (failedHandler) {
            failedHandler();
        }
    }];
}

+ (void)GETRequestWithURLString:(NSString*)baseUrl
                     parameters:(NSDictionary*)params
                        success:(id)successHandler
                        failure:(id)failedHandler
{
}
@end
