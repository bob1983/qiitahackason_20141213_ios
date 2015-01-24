//
//  JANPoint.m
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANPoint.h"

@implementation JANPoint
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.totalPoint = [coder decodeIntegerForKey:@"totalPoint"];
        self.gaugePersentValue = [coder decodeFloatForKey:@"gaugePersentValue"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInteger:_totalPoint forKey:@"totalPoint"];
    [coder encodeFloat:_gaugePersentValue forKey:@"gaugePersentValue"];
}
@end
