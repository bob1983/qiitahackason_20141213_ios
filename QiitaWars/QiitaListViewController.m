//
//  QiitaListViewController.m
//  QiitaWars
//
//  Created by bob on 2014/12/13.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "QiitaListViewController.h"
#import "JANUser.h"
#import "JANQiitaUserInfo.h"
#import "JANQiitaUserInfoService.h"
#import "JANStockService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface QiitaListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) JANUser *user;
@property (nonatomic, strong) JANQiitaUserInfo *myQiitaUserInfo;
@property (nonatomic, strong) NSArray *rivalsQiitaUserInfo;
@property (nonatomic, strong) JANQiitaUserInfoService *userInfoService;
@property (nonatomic, strong) JANStockService *stockService;
@property (strong, nonatomic) IBOutlet UITableView *qiitaListView;
@end

@implementation QiitaListViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInfoService = [[JANQiitaUserInfoService alloc] init];
        self.stockService    = [[JANStockService alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.userInfoService retrieveQiitaUserInfoWithUserId:@"bOb_sTrane"
                                           successHandler:^(JANQiitaUserInfo *qiitaUserInfo){
                                               self.myQiitaUserInfo = qiitaUserInfo;
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   [self.qiitaListView reloadData];
                                               });                                               ;
                                           }
                                            failedHandler:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Your activitie";
    }
    return @"Rivals activity";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"hoge";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        if (self.myQiitaUserInfo) {
            cell.textLabel.text = self.myQiitaUserInfo.qiitaId;
            
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.myQiitaUserInfo.qiitaId]
                              placeholderImage:nil];
             
//            [cell.myImageView setImageWithURL:[NSURL URLWithString:thumbUrl]
//                             placeholderImage:nil
//                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
//                                        [self.myImageView setImageWithURL:[NSURL URLWithString:fullUrl] placeholderImage:image];
//                                    }];
        }
    }
    
    return cell;
}

@end
