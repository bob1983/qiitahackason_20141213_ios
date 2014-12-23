//
//  JANQiitaUserInfoService.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANQiitaUserInfoService.h"
#import "JANQiitaUserInfo.h"

#define QIITA_USER_INFO @"QIITA_USER_INFO"

@implementation JANQiitaUserInfoService

- (void)retrieveQiitaUserInfoWithUserId:(NSString *)userId
                         successHandler:(QiitaUserInfoServiceRetrieveSuccessHandler)successHandler
                          failedHandler:(QiitaUserInfoServiceRetrieveFailedHandler)failedHandler
{
    
    NSString *baseUrl     = @"https://qiita.com/api/v2/users/";
    NSString *urlStr      = [NSString stringWithFormat:@"%@%@", baseUrl, userId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               if (connectionError) {
                                   return;
                               }
                               JANQiitaUserInfo *qiitaUserInfo = [self janQiitaUserInfoFromRetrievedData:data];
                               if (successHandler){
                                   successHandler(qiitaUserInfo);
                               }
                           }];
}

- (JANQiitaUserInfo *)janQiitaUserInfoFromRetrievedData:(NSData *)data
{
    NSError *error;
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    
    JANQiitaUserInfo *qiitaUserInfo = [[JANQiitaUserInfo alloc] init];
    qiitaUserInfo.name = parsedData[@"name"];
    qiitaUserInfo.qiitaId = parsedData[@"id"];
    qiitaUserInfo.profileImageUrl = parsedData[@"profile_image_url"];
    qiitaUserInfo.followersCount = [parsedData[@"followers_count"] integerValue];
    qiitaUserInfo.followeesCount = [parsedData[@"followees_count"] integerValue];
    qiitaUserInfo.itemsCount = [parsedData[@"items_count"] integerValue];
    return qiitaUserInfo;
}
- (void)saveQiitaUserInfo:(JANQiitaUserInfo*) qiitaUserInfo
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:qiitaUserInfo];
    
    NSMutableArray *qiitaUserInfos = [NSMutableArray arrayWithArray:[self loadQiitaUserInfos]];
    [qiitaUserInfos addObject:data];
    [self saveQiitaUserInfos:qiitaUserInfos];
    
}

-(JANQiitaUserInfo *)lastQiitaUserInfo
{
    NSArray *qiitaUserInfos = [self loadQiitaUserInfos];
    NSData* data = (NSData*)[qiitaUserInfos lastObject];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

-(NSArray *)loadQiitaUserInfos
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *qiitaUserInfos = [userDefaults objectForKey:QIITA_USER_INFO];
    if (qiitaUserInfos) {
        return [userDefaults objectForKey:QIITA_USER_INFO];
    }
    return [NSArray array];
}

- (void)saveQiitaUserInfos:(NSArray*)qiitaUserInfos
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:qiitaUserInfos forKey:QIITA_USER_INFO];
    [userDefaults synchronize];
}
@end
