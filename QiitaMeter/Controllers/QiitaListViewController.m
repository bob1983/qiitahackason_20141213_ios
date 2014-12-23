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
#import "QiitaListTableViewCell.h"

static NSString * const QiitaLIstTableViewCellIdentifier = @"QiitaLIstTableViewCell";

@interface QiitaListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) JANUser *user;
@property (nonatomic, strong) JANQiitaUserInfo *myQiitaUserInfo;
@property (nonatomic, strong) NSArray *rivalsQiitaUserInfo;
@property (nonatomic, strong) NSArray *myQiitaStocks;
@property (nonatomic, strong) JANQiitaUserInfoService *userInfoService;
@property (nonatomic, strong) JANStockService *stockService;
@property (strong, nonatomic) IBOutlet UITableView *qiitaListView;
@end

@implementation QiitaListViewController

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.userInfoService = [[JANQiitaUserInfoService alloc] init];
//        self.stockService    = [[JANStockService alloc] init];
//        
//    }
//    return self;
//}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInfoService = [[JANQiitaUserInfoService alloc] init];
        self.stockService    = [[JANStockService alloc] init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
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
    [self.stockService retrieveStocksWithUserId:@"bOb_sTrane"
                                 successHandler:^(NSArray *stocks) {
                                     self.myQiitaStocks = stocks;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [self.qiitaListView reloadData];
                                     });
                                 }
                                  failedHandler:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"マイQiitaメーター";
    }
    return @"みんなのQiitaメーター";
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [QiitaListTableViewCell identifier];
    
    QiitaListTableViewCell *cell = [self.qiitaListView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if (self.myQiitaUserInfo) {
            cell.accountNameLabel.text = self.myQiitaUserInfo.qiitaId;
            [cell setStockCount:[self.myQiitaStocks count]];
            [cell setFolloeesCount:self.myQiitaUserInfo.followeesCount];
            [cell setContributeCount:self.myQiitaUserInfo.itemsCount];
            
            [cell setTotalValue:[self.myQiitaStocks count] + self.myQiitaUserInfo.followeesCount + self.myQiitaUserInfo.itemsCount];
            
            [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:self.myQiitaUserInfo.profileImageUrl]
                             placeholderImage:nil
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                                        [cell.userImageView setImage:image];
                                    }];
    }
        } else {
            cell.accountNameLabel.text = @"ging";
            [cell setStockCount:12];
            [cell setFolloeesCount:3];
            [cell setContributeCount:7];
            
            [cell setTotalValue:22];
            [cell.userImageView setImage:[UIImage imageNamed:@"icon.jpg"]];
        }
    
    return cell;
}

@end
