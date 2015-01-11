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
#import "JANDataService.h"
#import "JANStock.h"

static NSString * const QiitaLIstTableViewCellIdentifier = @"QiitaLIstTableViewCell";

@interface QiitaListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) JANUser *user;
@property (nonatomic, strong) JANQiitaUserInfo *myQiitaUserInfo;
@property (nonatomic, strong) NSArray *rivalsQiitaUserInfo;
@property (nonatomic, strong) JANStock *myQiitaStocks;
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
        self.myQiitaUserInfo = [JANQiitaUserInfoService lastQiitaUserInfo];
        self.myQiitaStocks = [JANStockService lastStock];
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
    [JANDataService setViewUpdateToObserver:self];
    [JANDataService dataUpdateRequest:nil];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [QiitaListTableViewCell identifier];
    
    QiitaListTableViewCell *cell = [self.qiitaListView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
//    if (indexPath.section == 0) {
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
//    } else {
//        cell.accountNameLabel.text = @"ging";
//        [cell setStockCount:12];
//        [cell setFolloeesCount:3];
//        [cell setContributeCount:7];
//        
//        [cell setTotalValue:22];
//        [cell.userImageView setImage:[UIImage imageNamed:@"icon.jpg"]];
//    }
    
    return cell;
}


- (void)updateViewWithQiitaUserInfo:(NSNotification *)dic
{
    JANQiitaUserInfo *qiitaUserInfo = [[dic userInfo] objectForKey:QIITA_USER_INFO_NOTIFICATION_KEY];
    self.myQiitaUserInfo = qiitaUserInfo;
    [self.qiitaListView reloadData];
}
- (void)updateViewWithStock:(NSNotification *)dic
{
    JANStock *stock = [[dic userInfo] objectForKey:STOCK_NOTIFICATION_KEY];
    self.myQiitaStocks = stock;
    [self.qiitaListView reloadData];
}
@end