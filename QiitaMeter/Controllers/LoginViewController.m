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

#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setUpnavigationBarButton];
    
    if ([[JANUserService loadUser] accessTokens]) {
        [self openListViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - page transition

-(void)openListViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QiitaListController"
                                                         bundle:[NSBundle mainBundle]];
    QiitaListViewController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller
                                         animated:NO];
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

#pragma mark - notification
- (void)updateViewWithLogout:(NSNotification *)dic
{
    [self setUpnavigationBarButton];
}

#pragma mark - view
- (void)setUpnavigationBarButton
{
    UIBarButtonItem *rightBtn;
    UIBarButtonItem *leftBtn;
    if ([[JANUserService loadUser] accessTokens]) {
        rightBtn = [[UIBarButtonItem alloc]
                    initWithTitle:@"List"
                    style:UIBarButtonItemStylePlain
                    target:self action:@selector(openListViewController)];
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

@end
