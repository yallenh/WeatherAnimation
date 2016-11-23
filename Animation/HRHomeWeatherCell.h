//
//  HRHomeWeatherCell.h
//  Animation
//
//  Created by Allen on 11/23/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HRHomeWeatherDisplay) {
    HRHomeWeatherDisplayTemperature,
    HRHomeWeatherDisplayHours,
    HRHomeWeatherDisplayCount
};

@interface HRHomeWeatherCell : UICollectionViewCell

- (void)pupulateWithData:(id)data forWidth:(CGFloat)width;

+ (NSString *)cellIdentifier;

@end
