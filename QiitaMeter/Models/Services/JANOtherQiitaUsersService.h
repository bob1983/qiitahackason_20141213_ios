//
//  JANOtherUsersService.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/24.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JANOtherQiitaUsersServiceRetrieveQiitaUserInfoSuccessHandler)(NSArray *);
typedef void(^JANOtherQiitaUsersServiceRetrieveSuccessHandler)();

@interface JANOtherQiitaUsersService : NSObject

+ (void)retrieveOtherQiitaUsersWithSuccessHandler:(JANOtherQiitaUsersServiceRetrieveQiitaUserInfoSuccessHandler)successHandler
                               failedHandler:(JANOtherQiitaUsersServiceRetrieveSuccessHandler)failedHandler;

@end
