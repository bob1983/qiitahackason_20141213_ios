//
//  JANUser.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANUser.h"

@implementation JANUser
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.accountName = [coder decodeObjectForKey:@"accountName"];
        self.accessTokens = [coder decodeObjectForKey:@"accessTokens"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_accountName forKey:@"accountName"];
    [coder encodeObject:_accessTokens forKey:@"accessTokens"];
}
@end
