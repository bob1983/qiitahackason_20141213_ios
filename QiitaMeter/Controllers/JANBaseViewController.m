//
//  JanBaseViewController.m
//  QiitaMeter
//
//  Created by bob on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "JANBaseViewController.h"

@interface JANBaseViewController ()

@end

@implementation JANBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LogBlue(@"%s line:%d", __PRETTY_FUNCTION__, __LINE__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    LogBlue(@"%s line:%d", __PRETTY_FUNCTION__, __LINE__);
}


@end
