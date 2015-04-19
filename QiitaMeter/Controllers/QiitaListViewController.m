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
#import "JANPoint.h"
#import "JANUserService.h"
#import "JANConfig.h"
#import "JANSettingViewController.h"
#import "JANQiitaUserViewModel.h"

static NSString * const QiitaLIstTableViewCellIdentifier = @"QiitaLIstTableViewCell";

@interface QiitaListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JANQiitaUserViewModel *myQiitaUserInfo;
@property (nonatomic, strong) NSArray *rivalsQiitaUserInfo;
@property (nonatomic, strong) NSMutableDictionary *rivalsStocks;
@property (strong, nonatomic) IBOutlet UITableView *qiitaListView;
@end

@implementation QiitaListViewController

#pragma mark - lifecycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rivalsStocks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"GenQi";
    
    UIImage *settingImage = [[UIImage imageNamed:@"gear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc]
                                       initWithImage:settingImage
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(openSettingViewController)]; //設定画面への遷移イベントとする
    [settingsButton setBackgroundImage:[[UIImage alloc] init]
                              forState:UIControlStateNormal
                            barMetrics:UIBarMetricsDefault];

    self.navigationItem.rightBarButtonItem = settingsButton;

    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                  target:self
                                                                                  action:@selector(updateQiitaListRequest)];

    self.navigationItem.leftBarButtonItem = reloadButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [JANDataService setViewUpdateToObserver:self];
    [JANDataService dataUpdateRequest:nil];
}

- (void)viewDidLayoutSubviews
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
- (void)logout
{
    [JANDataService setViewUpdateToObserver:self];
    [JANDataService logoutRequest:nil];
}

- (void)updateViewWithLogout:(NSNotification *)dic
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView
           heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rivalsQiitaUserInfo.count == 0 && indexPath.section == 1) {
        return 44;
    }
    
    return 116;
}

- (NSString *)tableView:(UITableView *)tableView
              titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"今日のGenQi";
    }
    return @"みんなのGenQi";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (_rivalsQiitaUserInfo.count == 0) {
        return 1;
    }
    return _rivalsQiitaUserInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rivalsQiitaUserInfo.count == 0 && indexPath.section == 1 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoRivalsUserMessageCell"];
        return cell;
    }
    
    NSString *CellIdentifier = [QiitaListTableViewCell identifier];
    
    QiitaListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell reset];
    JANQiitaUserViewModel *qiitaUserInfo;
    if (indexPath.section == 0) {
        if (self.myQiitaUserInfo) {
            qiitaUserInfo = self.myQiitaUserInfo;
        }
    } else {
        qiitaUserInfo = [_rivalsQiitaUserInfo objectAtIndex:indexPath.row];
    }
    
    cell.accountNameLabel.text = qiitaUserInfo.qiitaId;
    
    [cell setStockCount:qiitaUserInfo.stocksCount];
    [cell setFolloeesCount:qiitaUserInfo.foloweesCount];
    [cell setContributeCount:qiitaUserInfo.itemsCount];
    
    [cell setTotalValue:qiitaUserInfo.totalPoint];
    
    [cell setGaugePercentValue:qiitaUserInfo.gaugePersentValue];
    [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:qiitaUserInfo.profileImageURL]
                          placeholderImage:nil
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                                     [cell.userImageView setImage:image];
                                 }];
    [cell layoutIfNeeded];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rivalsQiitaUserInfo.count == 0 && indexPath.section == 1 && indexPath.row == 0) {
        [self openSettingViewController];
        return;
    }
        
    NSString *selectedQiitaUserId;
    if( indexPath.section == 0 ) {
        if( indexPath.row == 0 ) {
            //自分のQiitaページ
            selectedQiitaUserId = self.myQiitaUserInfo.qiitaId;
        }
    } else {
        JANQiitaUserInfo *selectedQiitaUserInfo = [self.rivalsQiitaUserInfo objectAtIndex:indexPath.row];
        selectedQiitaUserId = selectedQiitaUserInfo.qiitaId;
    }
    // Safariで指定したURLを開く
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://qiita.com/%@", selectedQiitaUserId]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)updateQiitaListRequest
{
    [JANDataService dataUpdateRequest:nil];
}

-(void)openSettingViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SettingViewController"
                                                         bundle:[NSBundle mainBundle]];
    JANSettingViewController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller
                                         animated:YES];
}

#pragma - Notifications
- (void)updateViewWithQiitaUserInfo:(NSNotification *)dic
{
    JANQiitaUserViewModel *qiitaUserInfo = [[dic userInfo] objectForKey:QIITA_USER_INFO_NOTIFICATION_KEY];
    self.myQiitaUserInfo = qiitaUserInfo;
    
    [self.qiitaListView reloadData];
}

- (void)updateViewWithOtherQiitaUserInfos:(NSNotification *)dic
{
    JANQiitaUserViewModel *otherQiitaUser = [[dic userInfo] objectForKey:OTHER_QIITA_USER_INFOS_NOTIFICATION_KEY];
    if (self.rivalsQiitaUserInfo) {
        NSMutableArray *tempRivals = [self.rivalsQiitaUserInfo mutableCopy];
        __block NSInteger index = NSNotFound;
        [tempRivals enumerateObjectsUsingBlock:^(JANQiitaUserViewModel *qiitaUserInfo, NSUInteger idx, BOOL *stop) {
            if ([qiitaUserInfo.qiitaId isEqualToString:otherQiitaUser.qiitaId]) {
                index = idx;
                *stop = YES;
            }
        }];
        if (index == NSNotFound) {
            [tempRivals addObject:otherQiitaUser];
        } else {
            [tempRivals replaceObjectAtIndex:index withObject:otherQiitaUser];
        }
        self.rivalsQiitaUserInfo = tempRivals;
    } else {
        self.rivalsQiitaUserInfo = @[otherQiitaUser];
    }
    [self.qiitaListView reloadData];
}

- (void)updateViewWithDeleteOtherQiitaUserInfoId:(NSNotification *)dic
{
    NSString *deleteOtherQiitaUserId = [[dic userInfo] objectForKey:DELETE_OTHER_QIITA_USER_INFO_ID_NOTIFICATION_KEY];
    if (self.rivalsQiitaUserInfo) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"qiitaId", deleteOtherQiitaUserId];
        JANQiitaUserViewModel *deletedOtherQiitaUser = [[self.rivalsQiitaUserInfo filteredArrayUsingPredicate:predicate] firstObject];
        
        NSMutableArray *ary = [self.rivalsQiitaUserInfo mutableCopy];
        [ary removeObject:deletedOtherQiitaUser];
        self.rivalsQiitaUserInfo = ary;
    }
}

- (void)updateViewWithOtherUserStock:(NSNotification *)dic
{
    JANStock *stock = [[dic userInfo] objectForKey:STOCK_NOTIFICATION_KEY];
    NSString *qiitaId = [[dic userInfo] objectForKey:QIITA_ID_NOTIFICATION_KEY];
    [self.rivalsStocks setObject:stock forKey:qiitaId];
    [self.qiitaListView reloadData];
}

@end
