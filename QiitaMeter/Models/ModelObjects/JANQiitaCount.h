//
//  JANQiitaCount.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JANQiitaUserInfo.h"
#import "JANStock.h"

@interface JANQiitaCount : NSObject
@property (nonatomic, assign) NSInteger itemsCount;
@property (nonatomic, assign) NSInteger followeesCount;
@property (nonatomic, assign) NSInteger stocksCount;

- (instancetype)initWithQiitaUserInfo:(JANQiitaUserInfo *)qiitaUserInfo stocks:(JANStock *)stocks;
@end
