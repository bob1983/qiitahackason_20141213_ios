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
    return qiitaUserInfo;
}

+ (void)saveQiitaUserInfo:(JANQiitaUserInfo*) qiitaUserInfo
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:qiitaUserInfo];
    
    NSMutableArray *qiitaUserInfos = [NSMutableArray arrayWithArray:[self loadQiitaUserInfos]];
    [qiitaUserInfos addObject:data];
    [self saveQiitaUserInfos:qiitaUserInfos];
    
}

+ (JANQiitaUserInfo *)lastQiitaUserInfo
{
    NSArray *qiitaUserInfos = [self loadQiitaUserInfos];
    NSData* data = (NSData*)[qiitaUserInfos lastObject];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return [[JANQiitaUserInfo alloc] init];
}

+ (NSArray *)loadQiitaUserInfos
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *qiitaUserInfos = [userDefaults objectForKey:QIITA_USER_INFO];
    if (qiitaUserInfos) {
        return [userDefaults objectForKey:QIITA_USER_INFO];
    }
    return [NSArray array];
}

+ (void)saveQiitaUserInfos:(NSArray*)qiitaUserInfos
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:qiitaUserInfos forKey:QIITA_USER_INFO];
    [userDefaults synchronize];
}
@end
