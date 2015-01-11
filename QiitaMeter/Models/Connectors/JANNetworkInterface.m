//
//  JANNetworkInterface.m
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "JANNetworkInterface.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@implementation JANNetworkInterface
+ (void)GETRequestWithURLString:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                timeoutInterval:(NSTimeInterval)timeoutInterval
                    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                        success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                        failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET"
                                                                      URLString:[[NSURL URLWithString:URLString] absoluteString]
                                                                     parameters:parameters
                                                                          error:nil];
    NSLog(@"%@", request.URL);
    request.timeoutInterval = timeoutInterval;
    request.cachePolicy = cachePolicy;
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                                                             NSLog(@"response: %@", responseObject);
                                                                             if (success) {
                                                                                 success([operation response], responseObject);
                                                                             }
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                                                             NSLog(@"Error: %@", error);
                                                                             if (failure) {
                                                                                 failure([operation response], error);
                                                                             }
                                                                         }];
    [manager.operationQueue addOperation:operation];
}
@end
