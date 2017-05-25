//
//  ViewController.m
//  StarRating
//
//  Created by leimo on 2017/5/25.
//  Copyright © 2017年 huyong. All rights reserved.
//

#import "ViewController.h"
#import "StarRatingView.h"


@interface ViewController ()<HYStarRatingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    StarRatingView *starView = [[StarRatingView alloc] initWithFrame:CGRectMake(60, 120, 270, 30) rateStyle:RateStyleWholeStar];
    starView.rateStyle = RateStyleOptional;
    starView.delegate = self;
    [self.view addSubview:starView];
}

- (void)starRatingWithScore:(CGFloat)score{
    
    NSLog(@"评分: %f",score);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
