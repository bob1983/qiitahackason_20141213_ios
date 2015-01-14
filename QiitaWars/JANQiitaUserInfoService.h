//
//  JANQiitaUserInfoService.h
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JANQiitaUserInfo.h"

typedef void(^QiitaUserInfoServiceRetrieveSuccessHandler)(JANQiitaUserInfo *);
typedef void(^QiitaUserInfoServiceRetrieveFailedHandler)();

@interface JANQiitaUserInfoService : NSObject

// TODO: 多分公開する必要ない。というか別のクラスでやるべき
- (void)retrieveQiitaUserInfoWithUserId:(NSString *)userId
                         successHandler:(QiitaUserInfoServiceRetrieveSuccessHandler)successHandler
                          failedHandler:(QiitaUserInfoServiceRetrieveFailedHandler)failedHandler;

@end
