//
//  JANStockService.h
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JANStock;

typedef void(^StockServiceRetrieveSuccessHandler)(JANStock *);
typedef void(^StockServiceFailedHandler)();

@interface JANStockService : NSObject
+ (void)retrieveStocksWithUserId:(NSString *)userId
                         successHandler:(StockServiceRetrieveSuccessHandler)successHandler
                          failedHandler:(StockServiceFailedHandler)failedHandler;

+ (JANStock *)janStockFromRetrievedArray :(NSArray *)stocks;
+ (void)saveStock:(JANStock*) stock;
+ (JANStock *)lastStock;
+ (NSArray *)loadStocks;
+ (void)saveStocks:(NSArray*)stocks;
@end
