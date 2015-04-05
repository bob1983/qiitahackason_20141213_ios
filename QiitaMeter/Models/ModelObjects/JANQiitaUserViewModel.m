//
//  JANQiitaListViewModel.m
//  QiitaMeter
//
//  Created by bob on 2015/04/05.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANQiitaUserViewModel.h"
#import "JANQiitaUserInfo.h"
#import "JANPoint.h"

@interface JANQiitaUserViewModel ()
@end

@implementation JANQiitaUserViewModel

- (instancetype)initWithQiitaUserInfo:(JANQiitaUserInfo *)qiitaUserInfo
                                point:(JANPoint *)point
{
    self = [super init];
    if (self) {
        _qiitaId            = qiitaUserInfo.qiitaId;
        _profileImageURL    = qiitaUserInfo.profileImageUrl;
        _name               = [qiitaUserInfo accountName];
        _itemsCount         = qiitaUserInfo.itemsCount;
        _stocksCount        = qiitaUserInfo.stocksCount;
        _foloweesCount      = qiitaUserInfo.followeesCount;
        _totalPoint         = point.totalPoint;
        _gaugePersentValue  = point.gaugePersentValue;
        
    }
    return self;
}
@end
