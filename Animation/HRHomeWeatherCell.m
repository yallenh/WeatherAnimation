//
//  HRHomeWeatherCell.m
//  Animation
//
//  Created by Allen on 11/23/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

// #define HRHOMEWEATHER_SHOW_SK_DEBUG_INFO
// #define HRHOMEWEATHER_GIF_SUPPORT

#import "HRHomeWeatherCell.h"
#import "HRHomeWeatherScene.h"
#import "HRHomeWeatherTemperatureCell.h"
#import "HRHomeWeatherHoursCell.h"

@interface HRHomeWeatherCell ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>
@property (nonatomic) UICollectionView *carousel;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) SKView *skView;
@property (nonatomic) HRHomeWeatherScene *scene;
#ifdef HRHOMEWEATHER_GIF_SUPPORT
@property (nonatomic) UIImageView *imageView;
#endif

@end

@implementation HRHomeWeatherCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // NOTE: (allenh) the order of setting up is meaningful due to addSubview:
        [self setUpBackground];
        [self setUpCarousel];
        [self setUpPageControl];
    }
    return self;
}

- (void)setUpBackground
{
#ifdef HRHOMEWEATHER_GIF_SUPPORT
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.hidden = YES;
    [self addSubview:_imageView];
#endif

    _skView = [[SKView alloc] initWithFrame:self.bounds];
#ifdef HRHOMEWEATHER_SHOW_SK_DEBUG_INFO
    _skView.showsFPS = YES;
    _skView.showsNodeCount = YES;
#endif
    // [_skView presentScene:scene];
    [self addSubview:_skView];
}

- (void)setUpCarousel
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _carousel = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _carousel.dataSource = self;
    _carousel.delegate = self;
    _carousel.pagingEnabled = YES;
    _carousel.showsHorizontalScrollIndicator = NO;
    _carousel.backgroundColor = [UIColor clearColor];
    [_carousel registerNib:[UINib nibWithNibName:[HRHomeWeatherTemperatureCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRHomeWeatherTemperatureCell nibName]];
    [_carousel registerClass:[HRHomeWeatherHoursCell class] forCellWithReuseIdentifier:[HRHomeWeatherHoursCell cellIdentifier]];
    [self addSubview:_carousel];
}

- (void)setUpPageControl
{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.carousel.frame) - 30.f, CGRectGetWidth(self.carousel.frame), 10.f)];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.f alpha:.3f];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = HRHomeWeatherDisplayCount;
    _pageControl.currentPage = HRHomeWeatherDisplayTemperature;
    [self addSubview:_pageControl];
}

#pragma mark -- Public methods
- (void)pupulateWithData:(id)data forWidth:(CGFloat)width
{
    self.scene = (HRHomeWeatherScene *)data;
    [self.skView presentScene:self.scene];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return HRHomeWeatherDisplayCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == HRHomeWeatherDisplayTemperature) {
        HRHomeWeatherTemperatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRHomeWeatherTemperatureCell nibName] forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == HRHomeWeatherDisplayHours){
        HRHomeWeatherHoursCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRHomeWeatherHoursCell cellIdentifier] forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), CGRectGetHeight(collectionView.frame));
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = CGRectGetWidth(self.carousel.frame);
    self.pageControl.currentPage = ((self.carousel.contentOffset.x - width / 2.f) / width) + 1;
}

@end
