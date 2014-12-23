//
//  JANQiitaConnector.h
//  QiitaMeter
//
//  Created by 神田 on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JANQiitaConnectorSuccessHandler)(NSArray *);
typedef void(^JANQiitaConnectorFailedHandler)();

@interface JANQiitaConnector : NSObject

+ (void)retrieveStocksWithUserId:(NSString *)userId
                  successHandler:(JANQiitaConnectorSuccessHandler)successHandler
                   failedHandler:(JANQiitaConnectorFailedHandler)failedHandler;
@end
