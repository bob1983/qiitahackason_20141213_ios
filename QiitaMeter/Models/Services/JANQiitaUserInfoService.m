//
//  JANQiitaUserInfoService.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANQiitaUserInfoService.h"
#import "JANQiitaUserInfo.h"
#import "JANQiitaConnector.h"
#import "JANUserService.h"
#import "JANUser.h"

#define QIITA_USER_INFO @"QIITA_USER_INFO"

@implementation JANQiitaUserInfoService

+ (void)retrieveQiitaUserInfoWithUserId:(NSString *)userId
                         successHandler:(QiitaUserInfoServiceRetrieveSuccessHandler)successHandler
                          failedHandler:(QiitaUserInfoServiceRetrieveFailedHandler)failedHandler
{
    JANUser *user = [JANUserService loadUser];
    if ([user.qiitaId isEqualToString:userId]) {
        if (failedHandler) {
            failedHandler();
        }
        return;
    }
    [JANQiitaConnector retrieveQiitaUserInfoWithUserId:userId
                                        successHandler:^(NSDictionary *userInfo) {
                                            JANQiitaUserInfo *qiitaUserInfo = [JANQiitaUserInfoService janQiitaUserInfoFromRetrievedDictionary:userInfo];
                                            if (qiitaUserInfo) {
                                                if (successHandler){
                                                    successHandler(qiitaUserInfo);
                                                }
                                            } else {
                                                if (failedHandler) {
                                                    failedHandler();
                                                }
                                            }
                                        }
                                         failedHandler:failedHandler];
}

+ (JANQiitaUserInfo *)janQiitaUserInfoFromRetrievedDictionary :(NSDictionary *)dic
{
    if (!dic[@"id"]) {
        return nil;
    }
    JANQiitaUserInfo *qiitaUserInfo = [[JANQiitaUserInfo alloc] init];
    qiitaUserInfo.name = dic[@"name"];
    qiitaUserInfo.qiitaId = dic[@"id"];
    qiitaUserInfo.profileImageUrl = dic[@"profile_image_url"];
    qiitaUserInfo.followersCount = [dic[@"followers_count"] integerValue];
    qiitaUserInfo.followeesCount = [dic[@"followees_count"] integerValue];
    qiitaUserInfo.itemsCount = [dic[@"items_count"] integerValue];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:qiitaUserInfo];
    }];
    
    return qiitaUserInfo;
}

+ (JANQiitaUserInfo *)qiitaUserInfoWithQiitaId:(NSString *)qiitaId
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [JANQiitaUserInfo objectsInRealm:realm where:@"qiitaId = %@", qiitaId];
    return results.firstObject;
}

+ (RLMResults *)qiitaUserInfosWithoutOwn
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    JANUser *user = [JANUserService loadUser];
    if (!user.qiitaId) {
        return [self qiitaUserInfos];
    }
    return [JANQiitaUserInfo objectsInRealm:realm where:@"qiitaId <> %@", user.qiitaId];
}

+ (RLMResults *)qiitaUserInfos
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    return [JANQiitaUserInfo objectsInRealm:realm where:nil];
}

+ (void)deleteQiitaUserInfoWithQiitaId:(NSString *)qiitaId
{
    JANQiitaUserInfo *qiitaUserInfo = [self qiitaUserInfoWithQiitaId:qiitaId];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:qiitaUserInfo];
    [realm commitWriteTransaction];
}
@end
