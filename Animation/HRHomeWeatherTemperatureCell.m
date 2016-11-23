//
//  HRHomeWeatherTemperatureCell.m
//  Animation
//
//  Created by Allen on 11/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWeatherTemperatureCell.h"
#import "UIImage+ColorReplacement.h"

@interface HRHomeWeatherTemperatureCell ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rainIcon;
@property (weak, nonatomic) IBOutlet UILabel *rainLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@end

@implementation HRHomeWeatherTemperatureCell

- (void)awakeFromNib
{
    self.containerView.backgroundColor = [UIColor clearColor];
    self.weatherIcon.image = [UIImage imageNamed:@"weather-clearNight-icon" replaceColor:[UIColor whiteColor]];
}

- (IBAction)didTapLocationBtn:(id)sender
{
    NSLog(@"should change location");
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end
