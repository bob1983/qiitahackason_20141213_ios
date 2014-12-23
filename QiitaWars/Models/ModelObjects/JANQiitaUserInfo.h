//
//  JANQiitaUserInfo.h
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JANQiitaUserInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *qiitaId;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic)       NSUInteger followersCount;
@property (nonatomic)       NSUInteger followeesCount;
@property (nonatomic)       NSUInteger itemsCount;
@end
