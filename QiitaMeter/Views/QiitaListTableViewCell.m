//
//  QiitaLIstTableViewCell.m
//  QiitaWars
//
//  Created by 神田 on 2014/12/13.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "QiitaListTableViewCell.h"
#import "UIView+JMFrame.h"

@implementation QiitaListTableViewCell

+ (NSString *)identifier
{
    static NSString *_identifier;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _identifier = NSStringFromClass([self class]);
    });
    return _identifier;
}

- (void)awakeFromNib
{
    // Initialization code
    CGRect frame = _contributeCountBackImageView.frame;
    frame.size.width = _contributeCountLabel.frame.size.width;
    frame.size.height = _contributeCountLabel.frame.size.height;
//    [_contributeCountBackImageView setFrame:frame];
    [self reset];
}

- (void)reset
{
    self.stockCountLabel.text =
    self.folloeesCountLavel.text =
    self.contributeCountLabel.text = @"-";
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
    _totalValueLabel.text = [NSString stringWithFormat:@"%ld", (long)totalValue];
}

- (void)setGaugePercentValue:(float)percentValue
{
    [_gaugeView setPersentValue:percentValue];
    [_gaugeView setNeedsDisplay];
}
@end
