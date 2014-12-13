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

-(void)saveParsedString:(NSString*)parsedString
{
    NSMutableArray *stocks = [NSMutableArray arrayWithArray:[self loadStacks]];
    [stocks addObject:parsedString];
}

-(NSUInteger)stockCount
{
    NSArray *stocks = [self loadStacks];
    NSString *lastParsedString = [stocks lastObject];
    NSArray *stock = [lastParsedString objectFromJSONString];
    return [stock count];
}



-(void)saveStock:(JANStock *)stock
{
    NSMutableArray *stocks = [NSMutableArray arrayWithArray:[self loadStacks]];
    [stocks addObject:stocks];
    [self saveStacks:stocks];
}

-(NSArray *)loadStacks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults arrayForKey:STOCKS];
    if (array) {
        return [userDefaults arrayForKey:STOCKS];
    }
    return [NSArray array];
}

-(void)saveStacks:(NSArray *)stocks
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:stocks forKey:STOCKS];
    [userDefaults synchronize];
}
@end
