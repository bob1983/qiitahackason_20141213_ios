//
//  JANNetworkInterface.h
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JANNetworkInterface : NSObject
+ (void)GETRequestWithURLString:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                timeoutInterval:(NSTimeInterval)timeoutInterval
                    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                        success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                        failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

+ (void)POSTRequestWithURLString:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                timeoutInterval:(NSTimeInterval)timeoutInterval
                    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                        success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                         failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

+ (void)JSONPOSTRequestWithURLString:(NSString *)URLString
                                json:(NSDictionary *)json
                     timeoutInterval:(NSTimeInterval)timeoutInterval
                         cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                             success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                             failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

+ (void)DELETERequestWithURLString:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                   timeoutInterval:(NSTimeInterval)timeoutInterval
                       cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                           success:(void (^)(NSHTTPURLResponse *response, id responseObject))success
                           failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;
/**
 The last HTTP response received by the operation's connection.
 */
@property (readonly, nonatomic, strong) NSHTTPURLResponse *response;

@property (readonly, nonatomic, strong) id responseObject;
@end
