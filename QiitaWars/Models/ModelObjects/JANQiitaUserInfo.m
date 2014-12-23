//
//  JANQiitaUserInfo.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANQiitaUserInfo.h"

@implementation JANQiitaUserInfo
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.qiitaId = [coder decodeObjectForKey:@"qiitaId"];
        self.profileImageUrl = [coder decodeObjectForKey:@"profileImageUrl"];
        self.followersCount = [coder decodeIntegerForKey:@"followersCount"];
        self.followeesCount = [coder decodeIntegerForKey:@"followeesCount"];
        self.itemsCount = [coder decodeIntegerForKey:@"itemsCount"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_qiitaId forKey:@"qiitaId"];
    [coder encodeObject:_profileImageUrl forKey:@"profileImageUrl"];
    [coder encodeInteger:_followersCount forKey:@"followersCount"];
    [coder encodeInteger:_followeesCount forKey:@"followeesCount"];
    [coder encodeInteger:_itemsCount forKey:@"itemsCount"];
}
@end
