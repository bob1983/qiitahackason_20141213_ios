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
#import "JANQiitaCount.h"

@implementation JANPointService

+ (JANPoint *)makePointWithLastCount:(JANQiitaCount *)lastCount secondCount:(JANQiitaCount *)seccondCounts
{
    JANPoint *point = [[JANPoint alloc] init];
    point.totalPoint = lastCount.followeesCount + lastCount.itemsCount + lastCount.stocksCount;
    point.gaugePersentValue = point.totalPoint / 100.0;
    return point;
}
@end
