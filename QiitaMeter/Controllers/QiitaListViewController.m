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
#import "JANPointService.h"
#import "JANQiitaCount.h"
#import "JANPoint.h"

static NSString * const QiitaLIstTableViewCellIdentifier = @"QiitaLIstTableViewCell";

@interface QiitaListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) JANUser *user;
@property (nonatomic, strong) JANQiitaUserInfo *myQiitaUserInfo;
@property (nonatomic, strong) NSArray *rivalsQiitaUserInfo;
@property (nonatomic, strong) JANStock *myQiitaStocks;
@property (nonatomic, strong) JANPoint *myPoint;
@property (nonatomic, strong) JANQiitaUserInfoService *userInfoService;
@property (nonatomic, strong) JANStockService *stockService;
//@property (nonatomic, assign) NSInteger myPoint;
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
        self.myPoint = [JANPointService makePointWithLastCount:[[JANQiitaCount alloc] initWithQiitaUserInfo:_myQiitaUserInfo stocks:_myQiitaStocks] secondCount:nil];
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
    
    self.title = [self.myQiitaUserInfo accountName];
    UIBarButtonItem* dataUpdateButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"更新"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(updateQiitaListRequest)];
    self.navigationItem.rightBarButtonItem = dataUpdateButton;
    
    [self setLogoutBarButton];
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

- (void)setLogoutBarButton
{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]
                   initWithTitle:@"Logout"
                   style:UIBarButtonItemStylePlain
                   target:self
                   action:@selector(logout)];

    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)logout
{
    [JANDataService setViewUpdateToObserver:self];
    [JANDataService logoutRequest:nil];
}

- (void)updateViewWithLogout:(NSNotification *)dic
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133;
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
- (void)viewDidLayoutSubviews
{
    
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
            
            [cell setTotalValue:self.myPoint.totalPoint];
            
            [cell setGaugePercentValue:self.myPoint.gaugePersentValue];
            [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:self.myQiitaUserInfo.profileImageUrl]
                                  placeholderImage:nil
                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                                             [cell.userImageView setImage:image];
                                         }];
            [cell layoutIfNeeded];
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

- (void)updateQiitaListRequest
{
    [JANDataService dataUpdateRequest:nil];
}

- (void)updateViewWithQiitaUserInfo:(NSNotification *)dic
{
    JANQiitaUserInfo *qiitaUserInfo = [[dic userInfo] objectForKey:QIITA_USER_INFO_NOTIFICATION_KEY];
    self.myQiitaUserInfo = qiitaUserInfo;
    
    self.myPoint = [JANPointService makePointWithLastCount:[[JANQiitaCount alloc] initWithQiitaUserInfo:_myQiitaUserInfo stocks:_myQiitaStocks] secondCount:nil];
    
    self.title = [self.myQiitaUserInfo accountName];
    
    [self.qiitaListView reloadData];
}
- (void)updateViewWithStock:(NSNotification *)dic
{
    JANStock *stock = [[dic userInfo] objectForKey:STOCK_NOTIFICATION_KEY];
    self.myQiitaStocks = stock;
    
    self.myPoint = [JANPointService makePointWithLastCount:[[JANQiitaCount alloc] initWithQiitaUserInfo:_myQiitaUserInfo stocks:_myQiitaStocks] secondCount:nil];
    
    [self.qiitaListView reloadData];
}
- (void)updateViewWithPoint:(NSNotification *)dic
{
    
    self.myPoint = [JANPointService makePointWithLastCount:[[JANQiitaCount alloc] initWithQiitaUserInfo:_myQiitaUserInfo stocks:_myQiitaStocks] secondCount:nil];
    
    [self.qiitaListView reloadData];
}
@end
