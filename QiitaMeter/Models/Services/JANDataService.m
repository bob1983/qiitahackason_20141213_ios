//
//  JANDataService.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANDataService.h"
#import "JANStockService.h"
#import "JANQiitaUserInfoService.h"
#import "JANUserService.h"
#import "JANUser.h"

#define QIITA_USER_INFO_VIEW_UPDATE @"Qiita_User_Info_View_Update"
#define STOCK_VIEW_UPDATE @"Stock_View_Update"
#define POINT_VIEW_UPDATE @"point_view_update"
#define LOGOUT_VIEW_UPDATE @"logout_view_update"

@implementation JANDataService
+ (void)dataUpdateRequest:(JANDataServiceFinishHandler)finishHandler
{
    if ([[JANUserService loadUser] accessTokens]) {
        [JANUserService retrieveQiitaUserInfoWithSuccessHandler:^(JANQiitaUserInfo *qiitaUserInfo) {
            [JANQiitaUserInfoService saveQiitaUserInfo:qiitaUserInfo];
            
            NSNotification *n = [NSNotification notificationWithName:QIITA_USER_INFO_VIEW_UPDATE object:self userInfo:@{QIITA_USER_INFO_NOTIFICATION_KEY:qiitaUserInfo}];
            
            [[NSNotificationCenter defaultCenter] postNotification:n];
            [JANStockService retrieveStocksWithUserId:qiitaUserInfo.qiitaId
                                       successHandler:^(JANStock *stock) {
                                           [JANStockService saveStock:stock];
                                           
                                           NSNotification *n = [NSNotification notificationWithName:STOCK_VIEW_UPDATE object:self userInfo:@{STOCK_NOTIFICATION_KEY:stock}];
                                           
                                           [[NSNotificationCenter defaultCenter] postNotification:n];
                                       }
                                        failedHandler:^{}];
        } failedHandler:^{
            
        }];
    }
}
+ (void)viewUpdateRequest
{
    dispatch_async(dispatch_get_main_queue(), ^{

    });
}

+ (void)logoutRequest:(JANDataServiceFinishHandler)finishHnadler
{
    [JANUserService retrieveDeleteAccessTokensWithSuccessHandler:^{
        NSNotification *n = [NSNotification notificationWithName:LOGOUT_VIEW_UPDATE object:self userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:n];
    } failedHandler:^{
    }];
}

+ (void)setViewUpdateToObserver:(id<JANDataServiceViewUpdateObserver>)observer
{
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    if ([observer respondsToSelector:@selector(updateViewWithQiitaUserInfo:)])
        [nc addObserver:observer selector:@selector(updateViewWithQiitaUserInfo:) name:QIITA_USER_INFO_VIEW_UPDATE object:nil];
    if ([observer respondsToSelector:@selector(updateViewWithStock:)])
        [nc addObserver:observer selector:@selector(updateViewWithStock:) name:STOCK_VIEW_UPDATE object:nil];
    if ([observer respondsToSelector:@selector(updateViewWithPoint:)])
        [nc addObserver:observer selector:@selector(updateViewWithPoint:) name:POINT_VIEW_UPDATE object:nil];
    if ([observer respondsToSelector:@selector(updateViewWithLogout:)])
        [nc addObserver:observer selector:@selector(updateViewWithLogout:) name:LOGOUT_VIEW_UPDATE object:nil];
}
@end
