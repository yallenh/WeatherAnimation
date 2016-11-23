//
//  ViewController.m
//  Animation
//
//  Created by Allen on 11/21/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "HRHomeWeatherCell.h"
#import "HRHomeWeatherScene.h"

@interface ViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource =
    @[
      [HRHomeWeatherScene generateDaySunScene],
      [HRHomeWeatherScene generateDayCloudyScene],
      [HRHomeWeatherScene generateDayRainScene],
      [HRHomeWeatherScene generateNoonSunScene],
      [HRHomeWeatherScene generateNightMoonScene],
      [HRHomeWeatherScene generateNightCloudyScene],
      [HRHomeWeatherScene generateNightRainScene],
      [HRHomeWeatherScene generateSnowScene]
    ];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[HRHomeWeatherCell class] forCellWithReuseIdentifier:[HRHomeWeatherCell cellIdentifier]];
    [self.view addSubview:_collectionView];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRHomeWeatherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRHomeWeatherCell cellIdentifier] forIndexPath:indexPath];
    [cell pupulateWithData:[self.dataSource objectAtIndex:indexPath.row] forWidth:CGRectGetWidth(collectionView.frame)];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRHomeWeatherScene *scene = [self.dataSource objectAtIndex:indexPath.row];
    CGFloat width = CGRectGetWidth(collectionView.frame);
    CGFloat height = width * (scene.size.height / scene.size.width);
    return CGSizeMake(width, height);
}

@end
