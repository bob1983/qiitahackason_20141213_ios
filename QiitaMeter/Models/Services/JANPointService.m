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

@implementation JANPointService
+ (NSInteger)makePointWithlastPoints:(JANPoints *)lastPoints secondPoints:(JANPoints *)secondPoints
{
    return lastPoints.followeesCount + lastPoints.itemsCount + lastPoints.stockCount;
}
@end


@interface JANPoints ()
@property (nonatomic, readwrite) NSInteger stockCount;
@property (nonatomic, readwrite) NSInteger followeesCount;
@property (nonatomic, readwrite) NSInteger itemsCount;
- (void)setValues;
@end

@implementation JANPoints
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setValues];
    }
    return self;
}

- (instancetype)initWithUserId:(NSString *)userId
{
    return [self init];
}

- (void)setValues
{
    JANQiitaUserInfo *qiitaUserInfo = [JANQiitaUserInfoService lastQiitaUserInfo];
    self.followeesCount = qiitaUserInfo.followeesCount;
    self.itemsCount = qiitaUserInfo.itemsCount;
    
    JANStock *stock = [JANStockService lastStock];
    self.stockCount = stock.count;
}
@end
