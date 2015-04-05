//
//  JANDataService.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANDataService.h"
#import "JANStockService.h"
#import "JANPointService.h"
#import "JANQiitaUserInfo.h"
#import "JANQiitaUserInfoService.h"
#import "JANUserService.h"
#import "JANUser.h"
#import "JANStock.h"
#import "JANQiitaUserViewModel.h"

#define QIITA_USER_INFO_VIEW_UPDATE @"Qiita_User_Info_View_Update"
#define STOCK_VIEW_UPDATE @"Stock_View_Update"
#define POINT_VIEW_UPDATE @"point_view_update"
#define LOGOUT_VIEW_UPDATE @"logout_view_update"
#define OTHER_QIITA_USER_INFO_VIEW_UPDATE @"Other_Qiita_User_Info_View_Update"
#define OTHER_USER_STOCK_VIEW_UPDATE @"Other_User_Stock_View_Update"
#define DELETE_ALL_OTHER_USER_UPDATE @"Delete_All_Other_User_Update"

@interface JANDataService()
+ (void)userDataUpdateRequest;
+ (void)otherUserDataUpdateRequest;
@end

@implementation JANDataService
+ (void)dataUpdateRequest:(JANDataServiceFinishHandler)finishHandler
{
    [self userDataUpdateRequest];
    [self otherUserDataUpdateRequest];
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
    if ([observer respondsToSelector:@selector(updateViewWithOtherQiitaUserInfos:)])
        [nc addObserver:observer selector:@selector(updateViewWithOtherQiitaUserInfos:) name:OTHER_QIITA_USER_INFO_VIEW_UPDATE object:nil];
    if ([observer respondsToSelector:@selector(updateViewWithOtherUserStock:)])
        [nc addObserver:observer selector:@selector(updateViewWithOtherUserStock:) name:OTHER_USER_STOCK_VIEW_UPDATE object:nil];
    if ([observer respondsToSelector:@selector(updateViewforDeleteAllOtherUsers)])
        [nc addObserver:observer selector:@selector(updateViewforDeleteAllOtherUsers) name:DELETE_ALL_OTHER_USER_UPDATE object:nil];
}

+ (void)userDataUpdateRequest
{
    if ([[JANUserService loadUser] accessTokens]) {
        [JANUserService retrieveQiitaUserInfoWithSuccessHandler:^(JANQiitaUserInfo *qiitaUserInfo) {
            [JANUserService saveQiitaId:qiitaUserInfo.qiitaId];
            
            NSString *qiitaId = [qiitaUserInfo.qiitaId copy];
            NSNotification *n = [NSNotification notificationWithName:QIITA_USER_INFO_VIEW_UPDATE object:self userInfo:@{QIITA_USER_INFO_NOTIFICATION_KEY:qiitaUserInfo}];
            
            [[NSNotificationCenter defaultCenter] postNotification:n];
            [JANStockService retrieveStocksWithUserId:qiitaUserInfo.qiitaId
                                       successHandler:^(JANStock *stock) {
                                           //ポイントを計算
                                           JANQiitaUserInfo *lastUserInfo = [self qiitaUserInfoWithQiitaId:qiitaUserInfo.qiitaId];
                                           qiitaUserInfo.stocksCount = stock.count;
                                           JANPoint *point = [JANPointService makePointWithLastUserInfo:lastUserInfo newUserInfo:qiitaUserInfo];
                                           
                                           //UserInfoとPointを保存
                                           [JANQiitaUserInfoService saveWithQiitaUserinfo:qiitaUserInfo];
                                           [JANPointService saveWithPoint:point];
                                           
                                           //JANQiitaUserViewModelを生成
                                           JANQiitaUserViewModel *qiitaUserViewModel = [[JANQiitaUserViewModel alloc] initWithQiitaUserInfo:qiitaUserInfo point:point];
                                           
                                           //JANQiitaUserViewModelをわたす //かんちゃん
                                           NSNotification *n = [NSNotification notificationWithName:STOCK_VIEW_UPDATE object:self
                                                                                           userInfo:@{STOCK_NOTIFICATION_KEY:stock}];
                                           
                                           [[NSNotificationCenter defaultCenter] postNotification:n];
                                       }
                                        failedHandler:nil];
        } failedHandler:nil];
    }
}

+ (JANQiitaUserInfo *)qiitaUserInfoWithQiitaId:(NSString *)qiitaId
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [JANQiitaUserInfo objectsInRealm:realm where:@"qiitaId = %@", qiitaId];
    return results.firstObject;
}

+ (void)otherUserDataUpdateRequest
{
    // accessToken無い=ログインしていない場合は，取得しない
    if ([[JANUserService loadUser] accessTokens]) {
        
        RLMResults *otherUsers = [JANQiitaUserInfoService qiitaUserInfosWithoutOwn];
        // 設定画面で，比較ユーザーをすべて消した後に，比較画面を更新するために追加
        // TODO: 他の方法にすべき
        if (otherUsers.count == 0) {
            NSNotification *n = [NSNotification notificationWithName:DELETE_ALL_OTHER_USER_UPDATE
                                                              object:self
                                                            userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:n];
        } else {
            for (JANQiitaUserInfo *qiitaUserInfo in otherUsers) {
                [JANQiitaUserInfoService retrieveQiitaUserInfoWithUserId:qiitaUserInfo.qiitaId
                                                          successHandler:^(JANQiitaUserInfo *qiitaUserInfo) {
                                                              NSNotification *n = [NSNotification notificationWithName:OTHER_QIITA_USER_INFO_VIEW_UPDATE
                                                                                                                object:self
                                                                                                              userInfo:@{
                                                                                                                         OTHER_QIITA_USER_INFOS_NOTIFICATION_KEY:qiitaUserInfo
                                                                                                                         }];
                                                              [[NSNotificationCenter defaultCenter] postNotification:n];
                                                              [JANStockService retrieveStocksWithUserId:qiitaUserInfo.qiitaId
                                                                                         successHandler:^(JANStock *stock) {
                                                                                             //比較ユーザーのSstockデータ取得完了を通知
                                                                                             NSNotification *n = [NSNotification notificationWithName:OTHER_USER_STOCK_VIEW_UPDATE
                                                                                                                                               object:self
                                                                                                                                             userInfo:@{
                                                                                                                                                        STOCK_NOTIFICATION_KEY:stock,
                                                                                                                                                        QIITA_ID_NOTIFICATION_KEY:qiitaUserInfo.qiitaId
                                                                                                                                                        }];
                                                                                             
                                                                                             [[NSNotificationCenter defaultCenter] postNotification:n];
                                                                                         } failedHandler:nil];
                                                          } failedHandler:^{}];
            }
        }
    }
    
}


@end
