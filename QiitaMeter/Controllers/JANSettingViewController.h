//
//  JANSettingViewController.h
//  QiitaMeter
//
//  Created by 神田 on 2015/03/15.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JANQiitaUserInfoService.h"

@interface JANSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) RLMResults *userList;
@end
