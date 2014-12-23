//
//  JANStockService.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANStockService.h"
#import <JSONKit-NoWarning/JSONKit.h>
#import "JANStock.h"

#define STOCKS @"stocks"

@implementation JANStockService
- (void)retrieveStocksWithUserId:(NSString *)userId
                  successHandler:(StockServiceRetrieveSuccessHandler)successHandler
                   failedHandler:(StockServiceFailedHandler)failedHandler

{
    
    NSString *baseUrl     = @"https://qiita.com/api/v2/users/";
    NSString *urlStr      = [NSString stringWithFormat:@"%@%@%@", baseUrl, userId, @"/stocks?page=1&per_page=100"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               if (connectionError) {
                                   return;
                               }
                               NSArray *stocks = [self stocksFromRetrievedData:data];
                               if (successHandler){
                                   successHandler(stocks);
                               }
                           }];
}

- (NSArray *)stocksFromRetrievedData:(NSData *)data
{
    NSArray *arr = [data objectFromJSONData];
    NSMutableArray *stocks = [NSMutableArray array];
    
    for (id stock in arr) {
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
