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
#import <Realm/Realm.h>

#define QIITA_USER_INFO @"QIITA_USER_INFO"

@implementation JANQiitaUserInfoService

+ (void)retrieveQiitaUserInfoWithUserId:(NSString *)userId
                         successHandler:(QiitaUserInfoServiceRetrieveSuccessHandler)successHandler
                          failedHandler:(QiitaUserInfoServiceRetrieveFailedHandler)failedHandler
{
    [JANQiitaConnector retrieveQiitaUserInfoWithUserId:userId
                                        successHandler:^(NSDictionary *userInfo) {
                                            JANQiitaUserInfo *qiitaUserInfo = [JANQiitaUserInfoService janQiitaUserInfoFromRetrievedDictionary:userInfo];
                                            if (successHandler){
                                                successHandler(qiitaUserInfo);
                                            }
                                        }
                                         failedHandler:failedHandler];
}

+ (JANQiitaUserInfo *)janQiitaUserInfoFromRetrievedDictionary :(NSDictionary *)dic
{
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
@end
