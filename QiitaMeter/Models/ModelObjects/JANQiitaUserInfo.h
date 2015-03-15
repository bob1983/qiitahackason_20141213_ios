//
//  JANQiitaUserInfo.h
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import <Realm/Realm.h>

/**
 * Qiitaのユーザを表す
 */
@interface JANQiitaUserInfo : RLMObject

@property NSString *name;
@property NSString *qiitaId;
@property NSString *profileImageUrl;
@property NSInteger followersCount;
@property NSInteger followeesCount;
@property NSInteger itemsCount;
- (NSString *)accountName;

@end
