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
        
        [self addChild:self._pSkyLayer];
        [self addChild:self._pParticleLayer];
        
        TowerAndPlanetLayer *pTowerAndPlanet = [[[TowerAndPlanetLayer alloc] initWithGameData:i_pGameData PlanetLayer:self._pPlanetLayer] autorelease];
        [self addChild:pTowerAndPlanet];
        // Analyze game data
        
        // init layers
        
        // add light on tower column (particle)

    }
    
    return self;
}


-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}


@end
