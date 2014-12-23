//
//  IntroductionViewController.m
//  QiitaMeter
//
//  Created by bob on 2014/12/23.
//  Copyright (c) 2014年 bob. All rights reserved.
//

#import "IntroductionViewController.h"


@interface IntroductionViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *introductionScrollView;

@end

@implementation IntroductionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];

    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash"]];
    [imageView setFrame:CGRectMake(imageView.frame.size.width*0,
                                   0,
                                   imageView.frame.size.width,
                                   imageView.frame.size.height)];
    [self.introductionScrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"concept1"]];
    [imageView setFrame:CGRectMake(imageView.frame.size.width*1,
                                   0,
                                   imageView.frame.size.width,
                                   imageView.frame.size.height)];
    [self.introductionScrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"concept"]];
    [imageView setFrame:CGRectMake(imageView.frame.size.width*2,
                                   0,
                                   imageView.frame.size.width,
                                   imageView.frame.size.height)];
    [self.introductionScrollView addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
     self.introductionScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.introductionScrollView.frame) * 3,
                                                         CGRectGetHeight(self.introductionScrollView.frame));
}

@end
