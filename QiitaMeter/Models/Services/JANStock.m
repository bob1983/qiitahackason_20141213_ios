//
//  JANStock.m
//  qiitawars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 janehouse. All rights reserved.
//

#import "JANStock.h"

@implementation JANStock
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.data = [coder decodeObjectForKey:@"data"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_data forKey:@"data"];
}
@end
