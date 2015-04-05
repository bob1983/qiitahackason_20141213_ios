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


/// アイコンのパス
@property (nonatomic, readonly) NSURL *iconPath;
/// 表示名
@property (nonatomic, readonly) NSString *name;
/// 投稿数
@property (nonatomic, readonly) NSString *itemsCount;
/// ストック数
@property (nonatomic, readonly) NSString *stocksCount;
/// フォローされている数
@property (nonatomic, readonly) NSString *foloweesCount;
/// ポイント
@property (nonatomic, readonly) NSString *point;

@end
