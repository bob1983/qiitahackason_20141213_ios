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

@implementation JANOtherQiitaUsersService

+ (void)retrieveOtherQiitaUsersWithSuccessHandler:(JANOtherQiitaUsersServiceRetrieveQiitaUserInfoSuccessHandler)successHandler failedHandler:(JANOtherQiitaUsersServiceRetrieveSuccessHandler)failedHandler
{
    
    __block NSMutableArray *users = [NSMutableArray array];

    //現状は，開発者の一覧を返す
    NSArray *specailUsers = [JANConfig specialUsers];
    
    for (NSString *userId in specailUsers) {
        [JANQiitaUserInfoService retrieveQiitaUserInfoWithUserId:userId successHandler:^(JANQiitaUserInfo *qiitaUserInfo) {
            [users addObject:qiitaUserInfo];
            if (users.count == specailUsers.count) {
                successHandler(users);
            }
            
        } failedHandler:failedHandler];
    }
}
@end
