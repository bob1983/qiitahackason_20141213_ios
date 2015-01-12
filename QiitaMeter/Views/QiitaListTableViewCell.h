//
//  QiitaLIstTableViewCell.h
//  QiitaWars
//
//  Created by 神田 on 2014/12/13.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JANGaugeView.h"

@interface QiitaListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *contributeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *folloeesCountLavel;
@property (weak, nonatomic) IBOutlet UIImageView *contributeCountBackImageView;
@property (weak, nonatomic) IBOutlet JANGaugeView *gaugeView;

- (void)setStockCount:(NSInteger)stockCount;
- (void)setFolloeesCount:(NSInteger)folloeesCount;
- (void)setContributeCount:(NSInteger)contributeCount;
- (void)setTotalValue:(NSInteger)totalValue;
- (void)setGaugePercentValue:(float)percentValue;
+ (NSString *)identifier;
@end
