//
//  JANStockService.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANStockService.h"
#import "JANStock.h"
#import "JANQiitaConnector.h"

#define STOCKS @"stocks"

@implementation JANStockService
+ (void)retrieveStocksWithUserId:(NSString *)userId
                  successHandler:(StockServiceRetrieveSuccessHandler)successHandler
                   failedHandler:(StockServiceFailedHandler)failedHandler

{
    [self _retrieveStocksWithUserId:userId
                               page:1
                            perPage:1
                     successHandler:successHandler
                      failedHandler:failedHandler];
}
+ (void)_retrieveStocksWithUserId:(NSString *)userId
                             page:(NSInteger)page
                          perPage:(NSInteger)perPage
                  successHandler:(StockServiceRetrieveSuccessHandler)successHandler
                   failedHandler:(StockServiceFailedHandler)failedHandler

{
    NSLog(@"page:%ld, perPage:%ld", page, perPage);
    static NSMutableArray *stockary;
    [JANQiitaConnector retrieveStocksWithUserId:userId
                               page:page
                            perPage:perPage
                     successHandler:^(NSArray *stocks, NSInteger maxPage) {
                         NSLog(@"maxPage:%ld", (long)maxPage);
// ページングを行って最大値を取得する場合 
//                         if (page == 1) {
//                             stockary = [NSMutableArray arrayWithArray:stocks];
//                         } else {
//                             [stockary addObjectsFromArray:stocks];
//                         }
//                         NSLog(@"count:%ld", stocks.count);
//                         if (stocks.count == perPage) {
//                             NSLog(@"%ld以上", perPage * page);
//                             [self _retrieveStocksWithUserId:userId
//                                                        page:page+1
//                                                     perPage:perPage
//                                              successHandler:successHandler
//                                               failedHandler:failedHandler];
//                             
//                         } else {
                             if (successHandler) {
                                 JANStock *stock = [self janStockFromRetrievedArray:stockary];
                                 // 1 stock per page なら page数 = stock数 になる
                                 stock.count = maxPage * perPage;
                                 successHandler(stock);
                             }
//                         }
                     }
                      failedHandler:failedHandler];
}


+ (JANStock *)janStockFromRetrievedArray :(NSArray *)stocks
{
    JANStock *stock = [[JANStock alloc] init];
//    stock.data = stocks;
    stock.count = stocks.count;
    return stock;
}

- (NSArray *)stocksFromRetrievedData:(NSData *)data
{
    NSError *error;
    NSArray *parsedData = [NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingMutableContainers
                                                            error:&error];
    NSMutableArray *stocks = [NSMutableArray array];
    
    for (id stock in parsedData) {
        [stocks addObject:stock];
    }
    
    return stocks;
}


+ (void)saveStock:(JANStock*) stock
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:stock];
    
    NSMutableArray *stocks = [NSMutableArray arrayWithArray:[self loadStocks]];
    [stocks addObject:data];
    [self saveStocks:stocks];
    
}

+ (JANStock *)lastStock
{
    NSArray *stocks = [self loadStocks];
    NSData* data = (NSData*)[stocks lastObject];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return [[JANStock alloc] init];
}

+ (NSArray *)loadStocks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *stocks = [userDefaults objectForKey:STOCKS];
    if (stocks) {
        return stocks;
    }
    return [NSArray array];
}

+ (void)saveStocks:(NSArray*)stocks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:stocks forKey:STOCKS];
    [userDefaults synchronize];
}
@end
