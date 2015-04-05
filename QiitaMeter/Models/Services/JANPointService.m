//
//  JANPointService.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANPointService.h"
#import "JANQiitaUserInfo.h"
#import "JANQiitaUserInfoService.h"
#import "JANStockService.h"
#import "JANStock.h"
#import "JANPoint.h"

@implementation JANPointService

+ (JANPoint *)makePointWithLastUserInfo:(JANQiitaUserInfo *)lastUserInfo newUserInfo:(JANQiitaUserInfo *)newUserInfo
{
    JANPoint *point = [[JANPoint alloc] init];
    point.qiitaId = newUserInfo.qiitaId;
    
    //　現在のポイントを取得
    // 二つのuserInfoからポイントを比較
    
    float lastTotalPoint = (lastUserInfo.itemsCount)*50 + (lastUserInfo.followeesCount)*10 + (lastUserInfo.stocksCount)*1;
    float newTotalPoint = 0;
    float gaugePersentValue = 0;
    
    newUserInfo.itemsCount = lastUserInfo.itemsCount +1;
    
    if (!lastUserInfo || lastUserInfo.qiitaId.length < 1 || lastTotalPoint == 0 ){
        point.totalPoint = 0;
        point.gaugePersentValue = 0.5;
    }
    
    else if (newUserInfo.itemsCount > lastUserInfo.itemsCount || newUserInfo.followeesCount > lastUserInfo.followeesCount ||newUserInfo.stocksCount > lastUserInfo.stocksCount) {
        
        // 増加がある->二つのuserInfoからポイントの増分を決定
        newTotalPoint = (newUserInfo.itemsCount)*50 + (newUserInfo.followeesCount)*10 + (newUserInfo.stocksCount)*1;
        
        if (newTotalPoint > lastTotalPoint*2) {
            gaugePersentValue = 1;
        } else {
            gaugePersentValue = newTotalPoint/(lastTotalPoint*2);
        }
        
        point.totalPoint = newTotalPoint;
        point.gaugePersentValue = gaugePersentValue;
        
        
    } else {
        // 増加がない->経過時間に基づいて減点
        float timeInterval = [[NSDate date] timeIntervalSinceDate:lastUserInfo.lastUpdate];
        float deducingPonit = timeInterval/60;
        newTotalPoint = (newUserInfo.itemsCount)*50 + (newUserInfo.followeesCount)*10 + (newUserInfo.stocksCount)*1 - deducingPonit;
        if (newTotalPoint*2 < lastTotalPoint) {
            gaugePersentValue = 0;
        } else {
            gaugePersentValue = newTotalPoint/(lastTotalPoint*2);
        }
        
        point.totalPoint = newTotalPoint;
        point.gaugePersentValue = gaugePersentValue;
        
    }
    
    return point;

}

+ (void)saveWithPoint:(JANPoint *)point
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:point];
    }];
}

+ (JANPoint *)pointWithQiitaId:(NSString *)qiitaId
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [JANPoint objectsInRealm:realm where:@"qiitaId = %@", qiitaId];
    return results.firstObject;
}

@end
