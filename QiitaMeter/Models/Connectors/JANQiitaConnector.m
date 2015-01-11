//
//  JANQiitaConnector.m
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "JANQiitaConnector.h"
#import "JANNetworkInterface.h"

#define USERS_URL @"https://qiita.com/api/v2/users"
#define STOCK_URL_WITH_USER_ID(__USER_ID__) [NSString stringWithFormat:@"%@/%@/stocks", USERS_URL, __USER_ID__]

#define TIMEOUT_INTERVAL 10.0

@implementation JANQiitaConnector
+ (void)retrieveStocksWithUserId:(NSString *)userId
                            page:(NSInteger)page
                         perPage:(NSInteger)perPage
                 successHandler:(JANQiitaConnectorSuccessHandler)successHandler
                  failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl     = STOCK_URL_WITH_USER_ID(userId);
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
@end
