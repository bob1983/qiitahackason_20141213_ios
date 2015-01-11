//
//  JANPointService.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/11.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JANPoints;

@interface JANPointService : NSObject
+ (NSInteger)makePointWithlastPoints:(JANPoints *)lastPoints secondPoints:(JANPoints *)secondPoints;
@end

@interface JANPoints : NSObject
@property (nonatomic, readonly) NSInteger stockCount;
@property (nonatomic, readonly) NSInteger followeesCount;
@property (nonatomic, readonly) NSInteger itemsCount;
- (instancetype)initWithUserId:(NSString *)userId;
@end
