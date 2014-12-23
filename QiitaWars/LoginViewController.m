//
//  ViewController.m
//  QiitaWars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "LoginViewController.h"
#import "QiitaListViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"ログイン";
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height - 60);
    
    [scrollView setPagingEnabled:YES];

    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash"]];
    [imageView setFrame:CGRectMake(imageView.frame.size.width*0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    [scrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"concept1"]];
    [imageView setFrame:CGRectMake(imageView.frame.size.width*1, 0, imageView.frame.size.width, imageView.frame.size.height)];
    [scrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"concept"]];
    [imageView setFrame:CGRectMake(imageView.frame.size.width*2, 0, imageView.frame.size.width, imageView.frame.size.height)];
    [scrollView addSubview:imageView];
    
    
    
    [self.view addSubview:scrollView];
    
    
    
    //右側にカメラボタンを表示する
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                             target:self action:@selector(hoge:)] ;
    self.navigationItem.rightBarButtonItem = btn;
    
}

//カメラボタンが押されたときに呼ばれるメソッド
-(void)hoge:(UIBarButtonItem*)b{
    [self.navigationController pushViewController:[[QiitaListViewController alloc] init] animated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.navigationController pushViewController:[[QiitaListViewController alloc] init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
