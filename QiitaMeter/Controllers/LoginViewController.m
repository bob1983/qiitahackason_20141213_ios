//
//  ViewController.m
//  QiitaWars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "LoginViewController.h"
#import "QiitaListViewController.h"
#import "JANOauthViewController.h"
#import "JANUser.h"
#import "JANUserService.h"

@interface LoginViewController ()<JANDataServiceViewUpdateObserver>

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"イントロ";
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
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUpnavigationBarButton];
}

//カメラボタンが押されたときに呼ばれるメソッド
-(void)openListViewController:(UIBarButtonItem*)b{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QiitaListController"
                                                         bundle:[NSBundle mainBundle]];
    QiitaListViewController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

- (void)openOauthViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"OauthViewController"
                                                         bundle:[NSBundle mainBundle]];
    JANOauthViewController *controller = [storyboard instantiateInitialViewController];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)logout
{
    [JANDataService setViewUpdateToObserver:self];
    [JANDataService logoutRequest:nil];
}

- (void)updateViewWithLogout:(NSNotification *)dic
{
    [self setUpnavigationBarButton];
}

- (void)setUpnavigationBarButton
{
    UIBarButtonItem *rightBtn;
    UIBarButtonItem *leftBtn;
    if ([[JANUserService loadUser] accessTokens]) {
        rightBtn = [[UIBarButtonItem alloc]
                    initWithTitle:@"List"
                    style:UIBarButtonItemStylePlain
                    target:self action:@selector(openListViewController:)];
        leftBtn = [[UIBarButtonItem alloc]
                   initWithTitle:@"Logout"
                   style:UIBarButtonItemStylePlain
                   target:self
                   action:@selector(logout)];
    } else {
        rightBtn = [[UIBarButtonItem alloc]
                    initWithTitle:@"Login"
                    style:UIBarButtonItemStylePlain
                    target:self action:@selector(openOauthViewController)];
    }
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
