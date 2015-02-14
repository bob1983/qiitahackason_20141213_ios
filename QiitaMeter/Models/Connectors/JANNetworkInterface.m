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
#import "JANUserService.h"
#import "JANUser.h"

@implementation JANNetworkInterface
+ (void)GETRequestWithURLString:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                timeoutInterval:(NSTimeInterval)timeoutInterval
                    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                        success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                        failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure
{
    NSMutableURLRequest *request = [self baseRequestWithURLString:URLString
                                                           method:@"GET"
                                                       parameters:parameters
                                                  timeoutInterval:timeoutInterval
                                                      cachePolicy:cachePolicy];
    
    [self sendRequest:request success:success failure:failure];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    
//    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET"
//                                                                      URLString:[[NSURL URLWithString:URLString] absoluteString]
//                                                                     parameters:parameters
//                                                                          error:nil];
//    NSLog(@"%@", request.URL);
//    request.timeoutInterval = timeoutInterval;
//    request.cachePolicy = cachePolicy;
//    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
//                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
////                                                                             NSLog(@"response: %@", responseObject);
//                                                                             if (success) {
//                                                                                 success([operation response], responseObject);
//                                                                             }
//                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////                                                                             NSLog(@"Error: %@", error);
//                                                                             if (failure) {
//                                                                                 failure([operation response], error);
//                                                                             }
//                                                                         }];
//    [manager.operationQueue addOperation:operation];
}

+ (void)POSTRequestWithURLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                 timeoutInterval:(NSTimeInterval)timeoutInterval
                     cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                         success:(void (^)(NSHTTPURLResponse *, id))success
                         failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
{
    NSMutableURLRequest *request = [self baseRequestWithURLString:URLString
                                                           method:@"POST"
                                                       parameters:parameters
                                                  timeoutInterval:timeoutInterval
                                                      cachePolicy:cachePolicy];
    
    [self sendRequest:request success:success failure:failure];
}

+ (void)JSONPOSTRequestWithURLString:(NSString *)URLString
                                json:(NSDictionary *)json
                     timeoutInterval:(NSTimeInterval)timeoutInterval
                         cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                             success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                             failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure
{
    NSMutableURLRequest *request = [self baseRequestWithURLString:URLString
                                                           method:@"POST"
                                                       parameters:nil
                                                  timeoutInterval:timeoutInterval
                                                      cachePolicy:cachePolicy];
    
    if (json) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableData *body = [NSMutableData data];
        [body appendData:jsonData];
        [request setHTTPBody:body];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    }
    
    [self sendRequest:request success:success failure:failure];
    
}

+ (void)DELETERequestWithURLString:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                   timeoutInterval:(NSTimeInterval)timeoutInterval
                       cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                           success:(void (^)(NSHTTPURLResponse *, id))success
                           failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
{
    NSMutableURLRequest *request = [self baseRequestWithURLString:URLString
                                                           method:@"DELETE"
                                                       parameters:parameters
                                                  timeoutInterval:timeoutInterval
                                                      cachePolicy:cachePolicy];
    
    [self sendRequest:request success:success failure:failure];
}

+ (NSMutableURLRequest *)baseRequestWithURLString:(NSString *)URLString
                                           method:(NSString *)method
                                       parameters:(NSDictionary *)parameters
                                  timeoutInterval:(NSTimeInterval)timeoutInterval
                                      cachePolicy:(NSURLRequestCachePolicy)cachePolicy
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method
                                                                      URLString:[[NSURL URLWithString:URLString] absoluteString]
                                                                     parameters:parameters
                                                                          error:nil];
    request.timeoutInterval = timeoutInterval;
    request.cachePolicy = cachePolicy;
    JANUser *user = [JANUserService loadUser];
    if (user.accessTokens) {
        [request setValue:[NSString stringWithFormat:@"Bearer %@", user.accessTokens] forHTTPHeaderField:@"Authorization"];
    }
    return request;
}

+ (void)sendRequest:(NSMutableURLRequest *)request
            success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
            failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure
{
    NSLog(@"%@", request.URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                                                             NSLog(@"response: %@", responseObject);
                                                                             if (success) {
                                                                                 success([operation response], responseObject);
                                                                             }
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"Error: %@", error);
                                                                             if (failure) {
                                                                                 failure([operation response], error);
                                                                             }
                                                                         }];
    [manager.operationQueue addOperation:operation];
}
@end
