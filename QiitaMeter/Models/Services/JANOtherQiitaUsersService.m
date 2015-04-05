//
//  JANOtherUsersService.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/24.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANOtherQiitaUsersService.h"

#import "JANQiitaConnector.h"
#import "JANQiitaUserInfo.h"
#import "JANQiitaUserInfoService.h"
#import "JANConfig.h"
#import "JANQiitaUserInfoService.h"

@implementation JANOtherQiitaUsersService

+ (void)retrieveOtherQiitaUsersWithSuccessHandler:(JANOtherQiitaUsersServiceRetrieveQiitaUserInfoSuccessHandler)successHandler failedHandler:(JANOtherQiitaUsersServiceRetrieveSuccessHandler)failedHandler
{
    
    __block NSMutableArray *users = [NSMutableArray array];

    RLMResults *otherUsers = [JANQiitaUserInfoService qiitaUserInfosWithoutOwn];
    
    for (JANQiitaUserInfo *userInfo in otherUsers) {
        [JANQiitaUserInfoService retrieveQiitaUserInfoWithUserId:userInfo.qiitaId
                                                  successHandler:^(JANQiitaUserInfo *qiitaUserInfo) {
                                                      [users addObject:qiitaUserInfo];
                                                      if (users.count == otherUsers.count) {
                                                          successHandler(users);
                                                      }
                                                      
                                                  } failedHandler:failedHandler];
    }
}

@end
