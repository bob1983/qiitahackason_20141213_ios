//
//  JANQiitaCount.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANQiitaCount.h"

@implementation JANQiitaCount
- (instancetype)initWithQiitaUserInfo:(JANQiitaUserInfo *)qiitaUserInfo
                               stocks:(JANStock *)stocks
{
    self = [super init];
    if (self) {
        self.itemsCount = qiitaUserInfo.itemsCount;
        self.followeesCount = qiitaUserInfo.followeesCount;
        self.stocksCount = stocks.count;
    }
    return self;
}
@end
