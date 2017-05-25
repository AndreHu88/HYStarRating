//
//  StarRatingView.h
//  StarRating
//
//  Created by leimo on 2017/5/25.
//  Copyright © 2017年 huyong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , RateStyle){
    
    RateStyleWholeStar = 0,         //只能整星
    RateStyleHalfStar  = 1,         //只能半星
    RateStyleOptional  = 2          //允许不完整
};

@class StarRatingView;

@protocol HYStarRatingDelegate <NSObject>

/** 代理回传评分 */
- (void)starRatingWithScore:(CGFloat)score;

@end

@interface StarRatingView : UIView

/** 评分样式 */
@property (nonatomic,assign) RateStyle rateStyle;

/** 评分星星数量 */
@property (nonatomic,assign) NSInteger starCount;


@property (nonatomic,weak) id<HYStarRatingDelegate>delegate;

/**
 *  用评分样式初始化
 */
- (instancetype)initWithFrame:(CGRect)frame rateStyle:(RateStyle)style;

@end
