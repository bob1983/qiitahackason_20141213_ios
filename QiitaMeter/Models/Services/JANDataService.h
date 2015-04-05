//
//  JANDataService.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QIITA_USER_INFO_NOTIFICATION_KEY @"qiita_user_info_notification_key"
#define OTHER_QIITA_USER_INFOS_NOTIFICATION_KEY @"other_qiita_user_infos_notification_key"
#define STOCK_NOTIFICATION_KEY @"stock_notification_key"
#define QIITA_ID_NOTIFICATION_KEY @"qiita_id_notification_key"

@class JANQiitaUserInfo, JANStock;

typedef void(^JANDataServiceFinishHandler)();

@protocol JANDataServiceViewUpdateObserver<NSObject>;
@optional
- (void)updateViewWithQiitaUserInfo:(NSNotification *)dic;
- (void)updateViewWithOtherQiitaUserInfos:(NSNotification *)dic;
- (void)updateViewWithOtherUserStock:(NSNotification *)dic;
- (void)updateViewWithLogout:(NSNotification *)dic;
@end

@interface JANDataService : NSObject
// 更新完了はNSNotificationCenterで行われる
+ (void)dataUpdateRequest:(JANDataServiceFinishHandler)finishHandler;
+ (void)setViewUpdateToObserver:(id<JANDataServiceViewUpdateObserver>)observer;
+ (void)logoutRequest:(JANDataServiceFinishHandler)finishHnadler;
@end
