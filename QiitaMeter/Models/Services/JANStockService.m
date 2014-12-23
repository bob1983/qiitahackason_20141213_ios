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
- (void)retrieveStocksWithUserId:(NSString *)userId
                  successHandler:(StockServiceRetrieveSuccessHandler)successHandler
                   failedHandler:(StockServiceFailedHandler)failedHandler

{
    [JANQiitaConnector retrieveStocksWithUserId:userId
                                 successHandler:successHandler
                                  failedHandler:failedHandler];
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


- (void)saveStock:(JANStock*) stock
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:stock];
    
    NSMutableArray *stocks = [NSMutableArray arrayWithArray:[self loadStocks]];
    [stocks addObject:data];
    [self saveStocks:stocks];
    
}

-(JANStock *)lastStock
{
    NSArray *stocks = [self loadStocks];
    NSData* data = (NSData*)[stocks lastObject];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

-(NSArray *)loadStocks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *stocks = [userDefaults objectForKey:STOCKS];
    if (stocks) {
        return stocks;
    }
    return [NSArray array];
}

- (void)saveStocks:(NSArray*)stocks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:stocks forKey:STOCKS];
    [userDefaults synchronize];
}
@end
