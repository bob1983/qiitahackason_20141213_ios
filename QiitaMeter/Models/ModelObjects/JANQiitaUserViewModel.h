//
//  JANQiitaListViewModel.h
//  QiitaMeter
//
//  Created by bob on 2015/04/05.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JANQiitaUserInfo;
@class JANPoint;

/**
 *  ユーザ一覧画面を表示するためのViewModel
 */
@interface JANQiitaUserViewModel : NSObject

- (instancetype)initWithQiitaUserInfo:(JANQiitaUserInfo *)qiitaUserInfo
                                point:(JANPoint *)point;

/// Qiita ID
@property (nonatomic) NSString *qiitaId;

/// アイコンのパス
@property (nonatomic) NSString *profileImageURL;
/// 表示名
@property (nonatomic) NSString *name;
/// 投稿数
@property (nonatomic) NSInteger itemsCount;
/// ストック数
@property (nonatomic) NSInteger stocksCount;
/// フォローされている数
@property (nonatomic) NSInteger foloweesCount;
/// ポイント
@property (nonatomic) NSInteger totalPoint;
/// 表示のパーセンテージ
@property (nonatomic) CGFloat gaugePersentValue;

@end
