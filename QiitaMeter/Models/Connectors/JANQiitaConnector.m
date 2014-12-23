//
//  JANQiitaConnector.m
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "JANQiitaConnector.h"
#import "JANNetworkInterface.h"

@implementation JANQiitaConnector
+ (void)retrieveStocksWithUserId:(NSString *)userId
                 successHandler:(JANQiitaConnectorSuccessHandler)successHandler
                  failedHandler:(JANQiitaConnectorFailedHandler)failedHandler
{
    NSString *baseUrl     = [NSString stringWithFormat:@"https://qiita.com/api/v2/users/%@/stocks", userId];
    NSDictionary *params = @{
                          @"page":@1,
                          @"per_page":@100
                          };
    [JANNetworkInterface GETRequestWithURLString:baseUrl
                                      parameters:params
                                 timeoutInterval:10
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         success:^(NSHTTPURLResponse *response, id responseObject) {
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
