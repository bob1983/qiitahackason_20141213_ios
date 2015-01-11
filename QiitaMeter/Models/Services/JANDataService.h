//
//  JANDataService.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QIITA_USER_INFO_NOTIFICATION_KEY @"qiita_user_info_notification_key"
#define STOCK_NOTIFICATION_KEY @"stock_notification_key"

@class JANQiitaUserInfo, JANStock;

typedef void(^JANDataServiceFinishHandler)();

@protocol JANDataServiceViewUpdateObserver<NSObject>;
- (void)updateViewWithQiitaUserInfo:(NSNotification *)dic;
- (void)updateViewWithStock:(NSNotification *)dic;
@end

@interface JANDataService : NSObject
+ (void)dataUpdateRequest:(JANDataServiceFinishHandler)finishHandler;
+ (void)setViewUpdateToObserver:(id<JANDataServiceViewUpdateObserver>)observer;
@end
