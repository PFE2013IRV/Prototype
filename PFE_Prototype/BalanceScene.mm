//
//  BalanceScene.m
//
//  The tower balance game scene
//

#import "BalanceScene.h"
#import "TowerAndPlanetLayer.h"


@implementation BalanceScene

-(id) initGameScene : (GameData*) i_pGameData
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
    }
    else if (self = [super init])
    {
        self._pGameData = i_pGameData;
        
        [self._pSkyLayer ManageBackgroundBalance];
        [self addChild:self._pSkyLayer];
        
        StarsLayer* pStars = [[StarsLayer alloc] init];
        [self addChild:pStars];
        
        CGPoint positionBkg1 = ccp(580,700);
        CGPoint positionBkg2 = ccp(160,340);
        
        AnimatedBackground* pBkg1 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg1 withScale:0.5 withBeginDelay:20 withPlanetType:1];
        AnimatedBackground* pBkg2 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg2 withScale:1 withBeginDelay:10 withPlanetType:2];
        CloudsBack* pCloudsBack = [[CloudsBack alloc] init];
        CloudsFront* pCloudsFront = [[CloudsFront alloc] init];
        
        [self addChild:pBkg1];
        [self addChild:pBkg2];
        [self addChild:pCloudsBack];
        
        [self._pSunLayer ManageSunBalance];
        [self addChild:self._pSunLayer];
        
        
        //[self addChild:self._pParticleLayer];
        
        TowerAndPlanetLayer *pTowerAndPlanet = [[[TowerAndPlanetLayer alloc] initWithGameData:i_pGameData PlanetLayer:self._pPlanetLayer] autorelease];
        [self addChild:pTowerAndPlanet];
        
        [self addChild:pCloudsFront];
    }
    
    return self;
}


-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}


@end
