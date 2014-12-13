//
//  JANQiitaUserInfoService.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANQiitaUserInfoService.h"
#import <JSONKit-NoWarning/JSONKit.h>

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
    NSDictionary *dict = [data objectFromJSONData];
    
    JANQiitaUserInfo *qiitaUserInfo = [[JANQiitaUserInfo alloc] init];
    qiitaUserInfo.name = dict[@"name"];
    qiitaUserInfo.qiitaId = dict[@"id"];
    qiitaUserInfo.profileImageUrl = dict[@"profile_image_url"];
    qiitaUserInfo.followersCount = [dict[@"followers_count"] integerValue];
    qiitaUserInfo.followeesCount = [dict[@"followees_count"] integerValue];
    qiitaUserInfo.itemsCount = [dict[@"items_count"] integerValue];
    return qiitaUserInfo;
}

@end
