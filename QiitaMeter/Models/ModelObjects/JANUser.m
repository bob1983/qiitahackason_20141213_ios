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
        self.qiitaId = [coder decodeObjectForKey:@"qiitaId"];
        self.accessTokens = [coder decodeObjectForKey:@"accessTokens"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_qiitaId forKey:@"qiitaId"];
    [coder encodeObject:_accessTokens forKey:@"accessTokens"];
}
@end
