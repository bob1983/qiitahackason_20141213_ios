//
//  JANUserService.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANUserService.h"
#import "JANQiitaConnector.h"
#import "JANUser.h"
#import "JANQiitaUserInfoService.h"
#import "JANQiitaUserInfo.h"

#define USER @"user"

@implementation JANUserService

+ (void)retrieveAccessTokensWithCode:(NSString *)code
                      successHandler:(JANUserServiceRetrieveAccessTokensSuccessHandler)successHandler
                       failedHandler:(JANUserServiceFailedHandler)failedHandler
{
    [JANQiitaConnector retrieveQiitaAccessTokensWithCode:code successHandler:successHandler failedHandler:failedHandler];
}

+ (void)retrieveQiitaUserInfoWithSuccessHandler:(JANUserServiceRetrieveQiitaUserInfoSuccessHandler)successHandler
                                  failedHandler:(JANUserServiceFailedHandler)failedHandler
{
    [JANQiitaConnector retrieveQiitaUserInfoWithsuccessHandler:^(NSDictionary *dic){
        JANQiitaUserInfo *qiitaUserInfo = [JANQiitaUserInfoService janQiitaUserInfoFromRetrievedDictionary:dic];
        if (successHandler) {
            successHandler(qiitaUserInfo);
        }
    } failedHandler:failedHandler];
}

+ (void)retrieveDeleteAccessTokensWithSuccessHandler:(JANUserServiceRetrieveSuccessHandler)successHandler failedHandler:(JANUserServiceFailedHandler)failedHandler
{
    JANUser *user = [JANUserService loadUser];
    [JANQiitaConnector retrieveDeleteQiitaAccessTokens:user.accessTokens successHandler:^{
        [JANUserService deleteUser];
        if (successHandler) {
            successHandler();
        }
    } failedHandler:^{
        if (failedHandler) {
            failedHandler();
        }
    }];
}

+ (void)saveAccessTokens:(NSString *)accessTokens
{
    JANUser *user = [self loadUser];
    user.accessTokens = accessTokens;
    [self saveUser:user];
}

+ (void)saveAccountName:(NSString *)accountName
{
    JANUser *user = [self loadUser];
    user.accountName = accountName;
    [self saveUser:user];
}

+ (void)saveUser:(JANUser *)user
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:USER];
    [userDefaults synchronize];
}

+ (JANUser *)loadUser
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *user = [userDefaults objectForKey:USER];
    if (user) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:user];
    }
    return [[JANUser alloc] init];
}

+ (void)deleteUser
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER];
    [userDefaults synchronize];
}
@end
