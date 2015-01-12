//
//  JANPointService.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JANQiitaCount, JANPoint;

@interface JANPointService : NSObject
+ (JANPoint *)makePointWithLastCount:(JANQiitaCount *)lastCount secondCount:(JANQiitaCount *)seccondCounts;
@end
