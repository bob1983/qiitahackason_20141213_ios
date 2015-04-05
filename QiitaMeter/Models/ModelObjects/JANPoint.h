//
//  JANPoint.h
//  QiitaMeter
//
//  Created by 神田 on 2015/01/12.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Realm/Realm.h>

@interface JANPoint : RLMObject
@property NSString *qiitaId;
@property NSInteger totalPoint;
@property float gaugePersentValue;
@end
