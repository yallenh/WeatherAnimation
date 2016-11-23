//
//  HRHomeWeatherScene.h
//  Animation
//
//  Created by Allen on 11/21/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



typedef NS_ENUM(NSInteger, HRHomeWeatherTime) {
    HRHomeWeatherTimeDay,
    HRHomeWeatherTimeNoon,
    HRHomeWeatherTimeNight,
    HRHomeWeatherTimeSnow
};



@interface HRAnimationUnit : NSObject

- (instancetype)initWithNode:(SKSpriteNode *)node action:(SKAction *)action;

@property (nonatomic) SKSpriteNode *node;
@property (nonatomic) SKAction *action;
@property (nonatomic) CGPoint initialPosition;

@end



@interface HRHomeWeatherScene : SKScene

- (void)setUpGround;
- (void)setUpStar;
- (void)setUpShinePosition:(CGPoint)position;
- (void)setUpCloudTexture:(SKTexture *)texture scale:(CGFloat)scale position:(CGPoint)position moveToX:(CGFloat)toX range:(CGFloat)range;
- (void)setUpTreeTexture:(SKTexture *)texture scale:(CGFloat)scale position:(CGPoint)position moveToX:(CGFloat)toX;
- (void)setUpSunMoonTexture:(SKTexture *)texture scale:(CGFloat)scale  position:(CGPoint)position moveToY:(CGFloat)toY;
- (void)setUpCloudsForTime:(HRHomeWeatherTime)time;
- (void)setUpCloudyForTime:(HRHomeWeatherTime)time;
- (void)setUpTreesForTime:(HRHomeWeatherTime)time;
- (void)run;

@end



@interface HRHomeWeatherScene (Factory)

+ (HRHomeWeatherScene *)generateDaySunScene;
+ (HRHomeWeatherScene *)generateDayCloudyScene;
+ (HRHomeWeatherScene *)generateDayRainScene;

+ (HRHomeWeatherScene *)generateNoonSunScene;
+ (HRHomeWeatherScene *)generateNoonCloudyScene;
+ (HRHomeWeatherScene *)generateNoonRainScene;

+ (HRHomeWeatherScene *)generateNightMoonScene;
+ (HRHomeWeatherScene *)generateNightCloudyScene;
+ (HRHomeWeatherScene *)generateNightRainScene;

+ (HRHomeWeatherScene *)generateSnowScene;

@end
