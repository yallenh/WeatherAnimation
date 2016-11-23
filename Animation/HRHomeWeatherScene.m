//
//  HRHomeWeatherScene.m
//  Animation
//
//  Created by Allen on 11/21/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWeatherScene.h"
#import "HRHomeWeather.h"

static const CGFloat kHRHomeWeatherSceneWidth = 706.f;
static const CGFloat kHRHomeWeatherSceneHeight = 282.f;

@implementation HRAnimationUnit

- (instancetype)initWithNode:(SKSpriteNode *)node action:(SKAction *)action
{
    if ([super init]) {
        self.node = node;
        self.action = action;
        self.initialPosition = node.position;
    }
    return self;
}

@end



@interface HRHomeWeatherScene ()

@property (nonatomic) SKTextureAtlas *atlas;
@property (nonatomic) NSMutableArray <HRAnimationUnit *> *animations;

@end

@implementation HRHomeWeatherScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.scaleMode = SKSceneScaleModeAspectFill;
        self.atlas = [SKTextureAtlas atlasNamed:HRHOMEWEATHER_ATLAS_NAME];
        self.animations = [NSMutableArray array];
    }
    return self;
}

- (void)setUpBackgroundTexture:(SKTexture *)texture
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:texture];
    background.anchorPoint = CGPointZero;
    [self addChild: background];
}

- (void)setUpGround
{
    SKTexture *texture = HRHOMEWEATHER_TEX_BACKGROUND_DAY;
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = CGPointMake(self.size.width / 2.f, self.size.height / 2.f);
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:nil];
    [self.animations addObject:au];
}

- (void)setUpStar
{
    SKTexture *texture = HRHOMEWEATHER_TEX_STAR;
    CGFloat fadeDuration = 1.f;
    CGFloat ratio = .7f;
    
    SKAction *starTexture = [SKAction setTexture:texture];
    starTexture = [SKAction resizeToWidth:(self.size.width * ratio) height:(self.size.height * ratio) duration:0];
    starTexture = [SKAction moveBy:CGVectorMake(0, self.size.height * (1.f - ratio) / 4.f) duration:0];
    SKAction *fadeIn = [SKAction fadeInWithDuration:fadeDuration];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:2.f * fadeDuration];
    SKAction *blinkForever = [SKAction repeatActionForever:[SKAction sequence:@[fadeOut, fadeIn]]];
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = CGPointMake(self.size.width / 2.f, self.size.height / 2.f);
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:[SKAction sequence:@[starTexture, fadeIn, blinkForever]]];
    [self.animations addObject:au];
}

- (void)setUpFlower
{
    SKTexture *texture = HRHOMEWEATHER_TEX_FLOWER_FLOWER;
    CGFloat rotateDuration = 2.f;
    CGFloat degree = 20.f;
    
    SKAction *flowerTexture = [SKAction setTexture:texture];
    SKAction *rotateRight = [SKAction rotateByAngle:(-degree * M_PI / 180.f) duration:rotateDuration];
    SKAction *rotateLeft = [SKAction rotateByAngle:(degree * M_PI / 180.f) duration:rotateDuration];
    SKAction *rotateForEver = [SKAction repeatActionForever:[SKAction sequence:@[rotateRight, rotateLeft]]];
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.anchorPoint = CGPointZero;
    node.position = CGPointMake(580.f, 25.f);
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:[SKAction sequence:@[flowerTexture, rotateForEver]]];
    [self.animations addObject:au];
}

- (void)setUpShinePosition:(CGPoint)position
{
    SKTexture *texture = HRHOMEWEATHER_TEX_SHINE;
    CGFloat alphaMax = .4f;
    CGFloat alphaMim = .1f;
    CGFloat rotateDuration = 2.f;
    CGFloat fadeDuration = rotateDuration;

    SKAction *shineTexture = [SKAction setTexture:texture];
    shineTexture = [SKAction fadeAlphaTo:alphaMax duration:0];

    SKAction *rotate = [SKAction rotateByAngle:(M_PI / 180.f) duration:rotateDuration];
    SKAction *fadeIn = [SKAction group:@[rotate, [SKAction fadeAlphaTo:alphaMax duration:fadeDuration]]];
    SKAction *fadeOut = [SKAction group:@[rotate, [SKAction fadeAlphaTo:alphaMim duration:fadeDuration]]];
    SKAction *blinkRotateForever = [SKAction repeatActionForever:[SKAction sequence:@[fadeOut, fadeIn]]];

    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = position;
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:[SKAction sequence:@[shineTexture, blinkRotateForever]]];
    [self.animations addObject:au];
}

- (void)setUpSunMoonTexture:(SKTexture *)texture scale:(CGFloat)scale position:(CGPoint)position moveToY:(CGFloat)toY
{
    CGFloat downDuration = .5f;
    CGFloat rotateDuration = 1.f;
    CGFloat degree = 15.f;
    
    SKAction *sunMoonTexture = [SKAction setTexture:texture];
    sunMoonTexture = [SKAction scaleTo:scale duration:0];
    SKAction *down = [SKAction moveToY:toY duration:downDuration];
    SKAction *rotateLeft = [SKAction rotateToAngle:(degree / 2.f * M_PI / 180.f) duration:rotateDuration];
    SKAction *rotateRight2X = [SKAction rotateByAngle:(-degree * M_PI / 180.f) duration:2.f * rotateDuration];
    SKAction *rotateLeft2X = [SKAction rotateByAngle:(degree * M_PI / 180.f) duration:2.f * rotateDuration];
    SKAction *rotateForEver = [SKAction repeatActionForever:[SKAction sequence:@[rotateRight2X, rotateLeft2X]]];
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = position;
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:[SKAction sequence:@[sunMoonTexture, down, rotateLeft, rotateForEver]]];
    [self.animations addObject:au];
}

- (void)setUpCloudTexture:(SKTexture *)texture scale:(CGFloat)scale position:(CGPoint)position moveToX:(CGFloat)toX range:(CGFloat)range
{
    CGFloat rightDuration = .5f;

    SKAction *cloudTexture = [SKAction setTexture:texture];
    cloudTexture = [SKAction scaleTo:scale duration:0];
    SKAction *right = [SKAction moveToX:toX duration:rightDuration];
    SKAction *left = [SKAction moveToX:toX - range duration:rightDuration];
    SKAction *moveForever = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveBy:CGVectorMake(range, 0) duration:4.f * rightDuration], [SKAction moveBy:CGVectorMake(-range, 0) duration:4.f * rightDuration]]]];

    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = position;
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:[SKAction sequence:@[cloudTexture, right, left, moveForever]]];
    [self.animations addObject:au];
}

- (void)setUpCloudsForTime:(HRHomeWeatherTime)time
{
    SKTexture *cloudTexture = (time == HRHomeWeatherTimeNight) ? HRHOMEWEATHER_TEX_CLOUD_NIGHT : HRHOMEWEATHER_TEX_CLOUD_DAY;
    [self setUpCloudTexture:cloudTexture scale:.8f position:CGPointMake(-100.f, 190.f) moveToX:160.f range:30.f];
    [self setUpCloudTexture:cloudTexture scale:1.f position:CGPointMake(-150.f, 210.f) moveToX:100.f range:10.f];
}

- (void)setUpCloudyForTime:(HRHomeWeatherTime)time
{
    SKTexture *cloudTexture = (time == HRHomeWeatherTimeNight) ? HRHOMEWEATHER_TEX_CLOUD_NIGHT : HRHOMEWEATHER_TEX_CLOUD_DAY;
    [self setUpCloudTexture:cloudTexture scale:1.f position:CGPointMake(-150.f, 210.f) moveToX:100.f range:10.f];
    [self setUpCloudTexture:cloudTexture scale:1.f position:CGPointMake(850.f, 230.f) moveToX:620.f range:5.f];
    [self setUpCloudTexture:cloudTexture scale:1.f position:CGPointMake(850.f, 200.f) moveToX:570.f range:15.f];
    [self setUpCloudTexture:cloudTexture scale:.7f position:CGPointMake(850.f, 170.f) moveToX:640.f range:10.f];
}

- (void)setUpTreeTexture:(SKTexture *)texture scale:(CGFloat)scale position:(CGPoint)position moveToX:(CGFloat)toX
{
    CGFloat rightDuration = .5f;
    
    SKAction *treeTexture = [SKAction setTexture:texture];
    treeTexture = [SKAction scaleTo:scale duration:0];
    SKAction *right = [SKAction moveToX:toX duration:rightDuration];

    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    node.position = position;
    HRAnimationUnit *au = [[HRAnimationUnit alloc] initWithNode:node action:[SKAction sequence:@[treeTexture, right]]];
    [self.animations addObject:au];
}

- (void)setUpTreesForTime:(HRHomeWeatherTime)time
{
    SKTexture *treeTexture = nil;
    switch (time) {
        case HRHomeWeatherTimeNight:
            treeTexture = HRHOMEWEATHER_TEX_TREE_NIGHT_TREE;
            break;
        case HRHomeWeatherTimeSnow:
            treeTexture = HRHOMEWEATHER_TEX_TREE_SNOW_TREE;
            break;
        default:
            treeTexture = HRHOMEWEATHER_TEX_TREE_DAY_TREE;
            break;
    }
    [self setUpTreeTexture:treeTexture scale:.7f position:CGPointMake(-100.f, 65.f) moveToX:140.f];
    [self setUpTreeTexture:treeTexture scale:1.f position:CGPointMake(-150.f, 70.f) moveToX:80.f];
}

- (void)runAnimation:(HRAnimationUnit *)au
{
    if (au.node) {
        au.node.position = au.initialPosition;
        [au.node removeAllActions];
        [au.node removeFromParent];
    }
    if (au.action) {
        [au.node runAction:au.action];
    }
    [self addChild:au.node];
}

- (void)run
{
    __weak typeof (self) weakSelf = self;
    [self.animations enumerateObjectsUsingBlock:^(HRAnimationUnit *au, NSUInteger idx, BOOL *stop) {
        [weakSelf runAnimation:au];
    }];
}

@end



@implementation HRHomeWeatherScene (Factory)

#pragma mark -- Day Scenes
+ (HRHomeWeatherScene *)generateDaySunScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_BACKGROUND_DAY_SKY];
    [scene setUpShinePosition:CGPointMake(630.f, 80.f)];
    [scene setUpGround];
    [scene setUpCloudsForTime:HRHomeWeatherTimeDay];
    [scene setUpTreesForTime:HRHomeWeatherTimeDay];
    [scene setUpFlower];
    [scene run];
    return scene;
}

+ (HRHomeWeatherScene *)generateDayCloudyScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_CLOUDY_RAIN];
    [scene setUpSunMoonTexture:HRHOMEWEATHER_TEX_SUN scale:.6f position:CGPointMake(600.f, 300.f) moveToY:210.f];
    [scene setUpCloudyForTime:HRHomeWeatherTimeDay];
    [scene setUpTreesForTime:HRHomeWeatherTimeDay];
    [scene setUpFlower];
    [scene run];
    return scene;
}

+ (HRHomeWeatherScene *)generateDayRainScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_CLOUDY_RAIN];
    [scene setUpTreesForTime:HRHomeWeatherTimeDay];
    [scene setUpFlower];
    [scene run];
    return scene;
}

#pragma mark -- Noon Scenes
+ (HRHomeWeatherScene *)generateNoonSunScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_BACKGROUND_NOON];
    [scene setUpCloudsForTime:HRHomeWeatherTimeNoon];
    [scene setUpTreesForTime:HRHomeWeatherTimeNoon];
    [scene setUpFlower];
    [scene setUpShinePosition:CGPointMake(scene.size.width, scene.size.height)];
    [scene setUpSunMoonTexture:HRHOMEWEATHER_TEX_SUN scale:1.f position:CGPointMake(scene.size.width, 450.f) moveToY:scene.size.height];
    [scene run];
    return scene;
}

+ (HRHomeWeatherScene *)generateNoonCloudyScene
{
    return [HRHomeWeatherScene generateDayCloudyScene];
}

+ (HRHomeWeatherScene *)generateNoonRainScene
{
    return [HRHomeWeatherScene generateDayRainScene];
}

#pragma mark -- Night Scenes
+ (HRHomeWeatherScene *)generateNightMoonScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_BACKGROUND_NIGHT];
    [scene setUpStar];
    [scene setUpSunMoonTexture:HRHOMEWEATHER_TEX_MOON scale:1.f position:CGPointMake(600.f, 300.f) moveToY:210.f];
    [scene setUpCloudsForTime:HRHomeWeatherTimeNight];
    [scene setUpTreesForTime:HRHomeWeatherTimeNight];
    [scene run];
    return scene;
}

+ (HRHomeWeatherScene *)generateNightCloudyScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_BACKGROUND_NIGHT];
    [scene setUpStar];
    [scene setUpSunMoonTexture:HRHOMEWEATHER_TEX_MOON scale:1.f position:CGPointMake(600.f, 300.f) moveToY:210.f];
    [scene setUpCloudyForTime:HRHomeWeatherTimeNight];
    [scene setUpTreesForTime:HRHomeWeatherTimeNight];
    [scene run];
    return scene;
}

+ (HRHomeWeatherScene *)generateNightRainScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_BACKGROUND_NIGHT];
    [scene setUpTreesForTime:HRHomeWeatherTimeNight];
    [scene run];
    return scene;
}

#pragma mark -- Snow Scenes
+ (HRHomeWeatherScene *)generateSnowScene
{
    HRHomeWeatherScene *scene = [[HRHomeWeatherScene alloc] initWithSize:CGSizeMake(kHRHomeWeatherSceneWidth, kHRHomeWeatherSceneHeight)];
    [scene setUpBackgroundTexture:HRHOMEWEATHER_TEX_BACKGROUND_SNOW];
    [scene setUpTreesForTime:HRHomeWeatherTimeSnow];
    [scene run];
    return scene;
}

@end
