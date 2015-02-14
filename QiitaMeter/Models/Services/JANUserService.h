//
//  JANUserService.h
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JANUser, JANQiitaUserInfo;

typedef void(^JANUserServiceRetrieveQiitaUserInfoSuccessHandler)(JANQiitaUserInfo *);
typedef void(^JANUserServiceRetrieveSuccessHandler)();

typedef void(^JANUserServiceRetrieveAccessTokensSuccessHandler)(NSString *);
typedef void(^JANUserServiceFailedHandler)();

@interface JANUserService : NSObject
+ (void)retrieveAccessTokensWithCode:(NSString *)code
                  successHandler:(JANUserServiceRetrieveAccessTokensSuccessHandler)successHandler
                   failedHandler:(JANUserServiceFailedHandler)failedHandler;

+ (void)retrieveQiitaUserInfoWithSuccessHandler:(JANUserServiceRetrieveQiitaUserInfoSuccessHandler)successHandler
                          failedHandler:(JANUserServiceFailedHandler)failedHandler;
+ (void)retrieveDeleteAccessTokensWithSuccessHandler:(JANUserServiceRetrieveSuccessHandler)successHandler
                                       failedHandler:(JANUserServiceFailedHandler)failedHandler;

+ (void)saveQiitaId:(NSString *)qiitaId;
+ (void)saveAccessTokens:(NSString *)accessTokens;
//+ (void)saveOauthCode:(NSString *)oauthCode;
+ (void)saveUser:(JANUser *)user;
+ (JANUser *)loadUser;
+ (void)deleteUser;
@end
