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

#define QIITA_USER_INFO_VIEW_UPDATE @"Qiita_User_Info_View_Update"
#define STOCK_VIEW_UPDATE @"Stock_View_Update"

@implementation JANDataService
+ (void)dataUpdateRequest:(JANDataServiceFinishHandler)finishHandler
{
    [JANQiitaUserInfoService retrieveQiitaUserInfoWithUserId:@"bOb_sTrane"
                                              successHandler:^(JANQiitaUserInfo *qiitaUserInfo){
                                                  [JANQiitaUserInfoService saveQiitaUserInfo:qiitaUserInfo];
                                                  
                                                      NSNotification *n = [NSNotification notificationWithName:QIITA_USER_INFO_VIEW_UPDATE object:self userInfo:@{QIITA_USER_INFO_NOTIFICATION_KEY:qiitaUserInfo}];
                                                      
                                                      [[NSNotificationCenter defaultCenter] postNotification:n];
                                              }
                                               failedHandler:^{}];
    [JANStockService retrieveStocksWithUserId:@"bOb_sTrane"
                               successHandler:^(JANStock *stock) {
                                   [JANStockService saveStock:stock];

                                       NSNotification *n = [NSNotification notificationWithName:STOCK_VIEW_UPDATE object:self userInfo:@{STOCK_NOTIFICATION_KEY:stock}];
                                       
                                       [[NSNotificationCenter defaultCenter] postNotification:n];
                               }
                                failedHandler:^{}];
}
+ (void)viewUpdateRequest
{
    dispatch_async(dispatch_get_main_queue(), ^{

    });
}

+ (void)setViewUpdateToObserver:(id<JANDataServiceViewUpdateObserver>)observer
{
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:observer selector:@selector(updateViewWithQiitaUserInfo:) name:QIITA_USER_INFO_VIEW_UPDATE object:nil];
    [nc addObserver:observer selector:@selector(updateViewWithStock:) name:STOCK_VIEW_UPDATE object:nil];
}
@end
