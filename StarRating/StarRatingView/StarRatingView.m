//
//  StarRatingView.m
//  StarRating
//
//  Created by leimo on 2017/5/25.
//  Copyright © 2017年 huyong. All rights reserved.
//



#import "StarRatingView.h"

/** 每个星星的宽度 */
static CGFloat const starWidth = 30.0f;

/** 每个星星的间距 */
static CGFloat const starMargin = 20.0f;

@interface StarRatingView()

/** 存放星星的数组 */
@property (nonatomic,strong) NSMutableArray *starImgArray;

/** 当前的分数 */
@property (nonatomic,assign) CGFloat currentScore;

/** 选中的星星的View */
@property (nonatomic,strong) UIView *foregroundView;

@end

@implementation StarRatingView

- (instancetype)initWithFrame:(CGRect)frame rateStyle:(RateStyle)style{

    if (self = [super initWithFrame:frame]) {
        
        _starImgArray = [NSMutableArray array];
        [self createBackgroundStarRate];
        
        [self addSubview:self.foregroundView];
        [self createSelectStarRate];
    }
    
    return self;
}

- (UIView *)foregroundView{
    if (!_foregroundView) {
        
        _foregroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _foregroundView.userInteractionEnabled = YES;
        _foregroundView.clipsToBounds = YES;
    }
    return _foregroundView;
}

#pragma mark - Getter
- (NSInteger)starCount{
    
    if (!_starCount) {
        
        _starCount = 5;
    }
    return _starCount;
}

- (void)setCurrentScore:(CGFloat)currentScore{
    
    _currentScore = currentScore;
    [self setNeedsLayout];
    
    if (_delegate && [_delegate respondsToSelector:@selector(starRatingWithScore:)]) {
        
        [_delegate starRatingWithScore:currentScore];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    //动画改变frame
    [UIView animateWithDuration:0.2 animations:^{
        
        //如果是整数
        if ((int)self.currentScore == self.currentScore ) {
            
            CGFloat width = self.currentScore * (starWidth + starMargin);
            weakSelf.foregroundView.frame = CGRectMake(0, 0, width, starWidth);
        }
        else{
            
            CGFloat width = floor(self.currentScore) * (starWidth + starMargin) + starWidth * (self.currentScore - floor(self.currentScore)) + starMargin ;
            weakSelf.foregroundView.frame = CGRectMake(0, 0, width, starWidth);

        }
    }];
}

//创建灰色的star背景
- (void)createBackgroundStarRate{
    
    for (NSInteger i = 0; i < self.starCount; i++) {
        
        CGFloat starX = i * (starWidth + starMargin) + starMargin;
        //创建starImage
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starX, 0, starWidth, starWidth)];
        starImgView.image = [UIImage imageNamed:@"star_gray"];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:starImgView];
        [_starImgArray addObject:starImgView];
    }
}

//创建选中的starView
- (void)createSelectStarRate{
    
    for (NSInteger i = 0; i < self.starCount; i++) {
        
        CGFloat starX = i * (starWidth + starMargin) + starMargin;
        //创建starImage
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starX, 0, starWidth, starWidth)];
        starImgView.image = [UIImage imageNamed:@"star_yellow"];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.foregroundView addSubview:starImgView];
    }

}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取点击位置的X坐标
    CGPoint touchPoint = [[[event allTouches] anyObject] locationInView:self];
    NSInteger index =  touchPoint.x / (starMargin + starWidth);
    
    UIImageView *starImgView = nil;
    if (index > 4) {
        
        index = 5;
        starImgView = _starImgArray[4];
    }
    else{
        //获取对应的imageView
        starImgView = _starImgArray[index];
    }

    //转化为每个imageView的坐标
    CGPoint touchImgPoint = [self convertPoint:touchPoint toView:starImgView];
    
    
    CGFloat starScore;
    if (touchImgPoint.x < 0 || touchImgPoint.x > starWidth) {
        
        starScore = index;
    }
    else{
        
        starScore = touchImgPoint.x / starWidth + index;
    }
    
    switch (_rateStyle) {
        case RateStyleWholeStar:
            self.currentScore = ceilf(starScore);
            break;
            
        case RateStyleHalfStar:
            self.currentScore =  ceil(starScore) > starScore ? ceil(starScore) : ceil(starScore) - 0.5;
            break;
        case RateStyleOptional:
            self.currentScore = starScore;
            break;
            
        default:
            break;
    }
}

@end
