//
//  JANPointService.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JANQiitaUserInfo, JANPoint;

@interface JANPointService : NSObject
+ (JANPoint *)makePointWithLastUserInfo:(JANQiitaUserInfo *)lastUserInfo newUserInfo:(JANQiitaUserInfo *)newUserInfo;

+ (void)saveWithPoint:(JANPoint *)point;

@end