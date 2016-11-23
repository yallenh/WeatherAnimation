//
//  HRHomeWeatherHoursCell.m
//  Animation
//
//  Created by Allen on 11/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWeatherHoursCell.h"
#import "UIImage+ColorReplacement.h"

static const CGFloat kHRHomeWeatherHourCellWidth = 32.f;
static const CGFloat kHRHomeWeatherHourCellSpacing = 12.f;
static const CGFloat kHRHomeWeatherHoursCollectionViewWidth = 208.f; // 32 * 5 + 12 * (5 - 1)

@interface HRHomeWeatherHourCell ()
@property (weak, nonatomic) IBOutlet UILabel *hour;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@end

@implementation HRHomeWeatherHourCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.weatherIcon.image = [UIImage imageNamed:@"weather-clearNight-icon" replaceColor:[UIColor whiteColor]];
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end


@interface HRHomeWeatherHoursCell ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>
@property (nonatomic) UICollectionView *collectionView;
@end

@implementation HRHomeWeatherHoursCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // set up collectionview
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = kHRHomeWeatherHourCellSpacing;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:[HRHomeWeatherHourCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRHomeWeatherHourCell nibName]];
        [self addSubview:_collectionView];

        // add constraints
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [_collectionView addConstraints:
         @[
           [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:kHRHomeWeatherHoursCollectionViewWidth],
           [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:CGRectGetHeight(self.frame)]
        ]];
        [self addConstraints:
         @[
           [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0],
           [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]
        ]];
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:[HRHomeWeatherHourCell nibName] forIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kHRHomeWeatherHourCellWidth, CGRectGetHeight(collectionView.frame));
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

@end

