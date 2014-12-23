//
//  QiitaLIstTableViewCell.m
//  QiitaWars
//
//  Created by 神田 on 2014/12/13.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "QiitaListTableViewCell.h"

@implementation QiitaListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    CGRect frame = _contributeCountBackImageView.frame;
    frame.size.width = _contributeCountLabel.frame.size.width;
    frame.size.height = _contributeCountLabel.frame.size.height;
    [_contributeCountBackImageView setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStockCount:(NSInteger)stockCount
{
    _stockCountLabel.text = [NSString stringWithFormat:@"%ld", (long)stockCount];
}

-(void)setFolloeesCount:(NSInteger)folloeesCount
{
    _folloeesCountLavel.text = [NSString stringWithFormat:@"%ld", (long)folloeesCount];
}

-(void)setContributeCount:(NSInteger)contributeCount
{
    _contributeCountLabel.text = [NSString stringWithFormat:@"%ld", (long)contributeCount];
}

-(void)setTotalValue:(NSInteger)totalValue
{
    _totalValueLabel.text = [NSString stringWithFormat:@"%ld Pt.", (long)totalValue];
}
@end
